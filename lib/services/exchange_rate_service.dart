import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../data/local/prefs_service.dart';

const _cachePrefsKey = 'exchangeRateCache';

/// 한 번의 날짜별 환율 조회 결과. [reachable]이 false면 두 호스트 모두 응답 자체를
/// 받지 못한 것(오프라인 등)이라, 호출부는 다른 날짜로 더 재시도해도 소용없다고 판단할 수 있다.
class _DateRateResult {
  const _DateRateResult({required this.rate, required this.reachable});
  final double? rate;
  final bool reachable;
}

/// 무료·키 불필요·요청 제한 없는 환율 API인 fawazahmed0/currency-api
/// (https://github.com/fawazahmed0/exchange-api)를 사용해 결제일 기준 환율
/// (1 [from] = ? [to])을 조회한다. 200개 이상의 통화를 지원해 VND도 포함된다.
/// 1차로 jsdelivr CDN을, 실패하면 저장소가 권장하는 Cloudflare Pages 폴백 호스트를 시도한다.
///
/// 오프라인이거나 두 호스트 모두 실패하면(혹은 그 날짜의 데이터가 아직 없으면) 같은
/// 통화쌍으로 마지막에 성공했던 캐시 환율을 폴백으로 반환하고, 그마저 없으면 null을
/// 반환해 화면에서 사용자가 환율을 직접 입력하도록 유도한다.
class ExchangeRateService {
  ExchangeRateService._();

  /// key: "FROM_TO_yyyy-MM-dd" → 1 FROM = ? TO
  static final Map<String, double> _cache = {};
  static bool _cacheLoaded = false;

  /// 과거 날짜 조회 시 그 날짜에 공시된 환율이 없으면(주말/공휴일) 최대 이만큼 거슬러
  /// 올라가며 가장 가까운 직전 영업일 환율을 찾는다.
  static const _maxLookbackDays = 4;

  static String _cacheKey(String from, String to, DateTime date) =>
      '${from}_${to}_${DateFormat('yyyy-MM-dd').format(date)}';

  static Future<void> _ensureCacheLoaded() async {
    if (_cacheLoaded) return;
    _cacheLoaded = true;
    final raw = PrefsService.prefs.getString(_cachePrefsKey);
    if (raw == null) return;
    try {
      final decoded = json.decode(raw) as Map<String, dynamic>;
      for (final entry in decoded.entries) {
        _cache[entry.key] = (entry.value as num).toDouble();
      }
    } catch (_) {
      // 손상된 캐시는 무시하고 빈 상태로 시작.
    }
  }

  static Future<void> _persistCache() async {
    await PrefsService.prefs.setString(_cachePrefsKey, json.encode(_cache));
  }

  /// [date] 기준 1 [from] = ? [to] 환율을 반환한다.
  /// - 오늘 또는 미래 날짜(할부 등 아직 오지 않은 결제일)는 항상 'latest' 최신 환율을 쓴다
  ///   (미래 날짜를 그대로 API에 던지면 데이터가 없어 항상 실패하기 때문).
  /// - 과거 날짜는 그 날짜부터 최대 [_maxLookbackDays]일 전까지 하루씩 거슬러 올라가며
  ///   조회해, 주말/공휴일이라 그날 공시된 환율이 없어도 가장 가까운 직전 영업일 환율로
  ///   대체한다(무작정 아무 캐시값이나 대신 쓰지 않는다).
  /// 동일 통화쌍/날짜는 로컬 캐시(앱 재시작 후에도 SharedPreferences로 유지)에서 즉시
  /// 반환해 불필요한 네트워크 호출을 피한다. 오프라인 등으로 위 시도가 모두 실패하면
  /// 같은 통화쌍의 가장 최근 캐시 값을 폴백으로 반환하고, 캐시조차 없으면 null(수동 입력
  /// 필요)을 반환한다.
  static Future<double?> fetchRate({
    required String from,
    required String to,
    required DateTime date,
  }) async {
    if (from == to) return 1.0;
    await _ensureCacheLoaded();

    final normalizedDate = DateTime(date.year, date.month, date.day);
    final key = _cacheKey(from, to, normalizedDate);
    final cached = _cache[key];
    if (cached != null) return cached;

    final today = DateTime.now();
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final isPast = normalizedDate.isBefore(normalizedToday);

    if (!isPast) {
      // 오늘이거나 미래 날짜.
      final result = await _fetchForDatePath('latest', from, to);
      if (result.rate != null) {
        _cache[key] = result.rate!;
        unawaited(_persistCache());
        return result.rate;
      }
      return _lastKnownRate(from, to);
    }

    for (var offset = 0; offset <= _maxLookbackDays; offset++) {
      final tryDate = normalizedDate.subtract(Duration(days: offset));
      final datePath = DateFormat('yyyy-MM-dd').format(tryDate);
      final result = await _fetchForDatePath(datePath, from, to);
      if (result.rate != null) {
        _cache[key] = result.rate!;
        unawaited(_persistCache());
        return result.rate;
      }
      if (!result.reachable) {
        // 두 호스트 모두 응답조차 못 받음(오프라인 등) — 날짜를 더 바꿔봐도 의미 없다.
        break;
      }
    }
    return _lastKnownRate(from, to);
  }

  /// [datePath]("latest" 또는 "yyyy-MM-dd") 기준 1 [from] = ? [to] 환율을 두 호스트에
  /// 순서대로 시도해 반환한다. 캐시는 건드리지 않는다.
  static Future<_DateRateResult> _fetchForDatePath(
      String datePath, String from, String to) async {
    final fromLower = from.toLowerCase();
    final toLower = to.toLowerCase();
    final hosts = [
      'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@$datePath/v1/currencies/$fromLower.json',
      'https://$datePath.currency-api.pages.dev/v1/currencies/$fromLower.json',
    ];

    var reachedAnyHost = false;
    for (final host in hosts) {
      try {
        final response = await http
            .get(Uri.parse(host))
            .timeout(const Duration(seconds: 8));
        reachedAnyHost = true;
        if (response.statusCode != 200) continue;
        final body = json.decode(response.body) as Map<String, dynamic>;
        final rates = body[fromLower] as Map<String, dynamic>?;
        final rate = (rates?[toLower] as num?)?.toDouble();
        if (rate == null) continue;
        return _DateRateResult(rate: rate, reachable: true);
      } catch (_) {
        continue;
      }
    }
    return _DateRateResult(rate: null, reachable: reachedAnyHost);
  }

  /// API가 실패했거나 통화를 지원하지 않을 때, 같은 통화쌍으로 과거에 조회 성공했던
  /// 캐시 중 가장 최근(날짜 기준) 값을 폴백으로 돌려준다.
  static double? _lastKnownRate(String from, String to) {
    final prefix = '${from}_${to}_';
    final matching =
        _cache.entries.where((e) => e.key.startsWith(prefix)).toList();
    if (matching.isEmpty) return null;
    matching.sort((a, b) => b.key.compareTo(a.key));
    return matching.first.value;
  }
}
