import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../data/local/prefs_service.dart';

const _cachePrefsKey = 'exchangeRateCache';

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

  /// [date] 기준 1 [from] = ? [to] 환율을 반환한다. 오늘 날짜면 최신 환율,
  /// 과거 날짜면 해당 날짜의 환율을 조회한다. 동일 통화쌍/날짜는 로컬 캐시(앱 재시작 후에도
  /// SharedPreferences로 유지)에서 즉시 반환해 불필요한 네트워크 호출을 피한다.
  /// API 호출이 실패하거나(오프라인 등) 통화가 지원되지 않으면 같은 통화쌍의 가장 최근
  /// 캐시 값을 폴백으로 반환하고, 캐시조차 없으면 null(수동 입력 필요)을 반환한다.
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
    final isToday = normalizedDate.year == today.year &&
        normalizedDate.month == today.month &&
        normalizedDate.day == today.day;
    final datePath =
        isToday ? 'latest' : DateFormat('yyyy-MM-dd').format(normalizedDate);
    final fromLower = from.toLowerCase();
    final toLower = to.toLowerCase();

    final hosts = [
      'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@$datePath/v1/currencies/$fromLower.json',
      'https://$datePath.currency-api.pages.dev/v1/currencies/$fromLower.json',
    ];

    for (final host in hosts) {
      try {
        final response = await http
            .get(Uri.parse(host))
            .timeout(const Duration(seconds: 8));
        if (response.statusCode != 200) continue;
        final body = json.decode(response.body) as Map<String, dynamic>;
        final rates = body[fromLower] as Map<String, dynamic>?;
        final rate = (rates?[toLower] as num?)?.toDouble();
        if (rate == null) continue;
        _cache[key] = rate;
        unawaited(_persistCache());
        return rate;
      } catch (_) {
        continue;
      }
    }
    return _lastKnownRate(from, to);
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
