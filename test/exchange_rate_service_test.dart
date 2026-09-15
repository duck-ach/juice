import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:juice/data/local/prefs_service.dart';
import 'package:juice/services/exchange_rate_service.dart';

/// 실제 네트워크로 fawazahmed0/currency-api를 호출하는 스모크 테스트.
/// 오프라인 환경에서는 실패할 수 있으니 CI에서 네트워크가 없다면 skip 처리할 것.
void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await PrefsService.init();
  });

  test('오늘 날짜는 latest 환율을 정상적으로 가져온다', () async {
    final rate = await ExchangeRateService.fetchRate(
        from: 'USD', to: 'KRW', date: DateTime.now());
    expect(rate, isNotNull);
    expect(rate, greaterThan(0));
  });

  test('동일 통화쌍은 네트워크 호출 없이 1.0을 반환한다', () async {
    final rate = await ExchangeRateService.fetchRate(
        from: 'USD', to: 'USD', date: DateTime.now());
    expect(rate, 1.0);
  });

  test('미래 날짜(할부 등)는 404 대신 latest 엔드포인트로 정상 조회된다', () async {
    final future = DateTime.now().add(const Duration(days: 45));
    final rate = await ExchangeRateService.fetchRate(
        from: 'USD', to: 'KRW', date: future);
    expect(rate, isNotNull);
    expect(rate, greaterThan(0));
  });

  test('과거 주말(공휴일 유사 상황) 날짜는 직전 영업일 환율로 대체된다', () async {
    // 2024-01-06은 토요일 — 그날 자체 환율 데이터가 없을 가능성이 높다.
    final saturday = DateTime(2024, 1, 6);
    final rate = await ExchangeRateService.fetchRate(
        from: 'USD', to: 'KRW', date: saturday);
    expect(rate, isNotNull);
    expect(rate, greaterThan(0));
  });
}
