// 알림 문구가 지원하는 모든 언어에서 빠짐없이 번역돼 있는지 검증한다.
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:juice/core/notifications/notification_copy.dart';
import 'package:juice/l10n/app_localizations.dart';

void main() {
  test('모든 언어에 알림 문구 52쌍(저녁 요일별 35 포함)과 채널 정보가 비어 있지 않게 있고, 한국어 원문과 다르다', () {
    final ko = lookupAppLocalizations(const Locale('ko'));
    List<NotificationCopy> all(AppLocalizations l) => [
          for (var d = DateTime.monday; d <= DateTime.sunday; d++)
            ...NotificationCopyPool.eveningFor(l, d),
          NotificationCopyPool.mondayMorning(l),
          ...NotificationCopyPool.weekdayMorning(l),
          ...NotificationCopyPool.sundayMorning(l),
          ...NotificationCopyPool.comeback(l),
        ];
    final koCopies = all(ko);
    expect(koCopies.length, 52);
    for (var d = DateTime.monday; d <= DateTime.sunday; d++) {
      expect(NotificationCopyPool.eveningFor(ko, d).length, 5,
          reason: 'weekday $d');
    }

    for (final locale in AppLocalizations.supportedLocales) {
      if (locale.languageCode == 'ko') continue;
      final loc = lookupAppLocalizations(locale);
      final copies = all(loc);
      expect(copies.length, koCopies.length, reason: '$locale');
      for (var i = 0; i < copies.length; i++) {
        expect(copies[i].$1.trim(), isNotEmpty, reason: '$locale title $i');
        expect(copies[i].$2.trim(), isNotEmpty, reason: '$locale body $i');
        expect(copies[i].$1, isNot(koCopies[i].$1),
            reason: '$locale title $i가 한국어 그대로');
        expect(copies[i].$2, isNot(koCopies[i].$2),
            reason: '$locale body $i가 한국어 그대로');
      }
      expect(loc.notifChannelName, isNot(ko.notifChannelName),
          reason: '$locale');
      expect(loc.notifChannelDescription, isNot(ko.notifChannelDescription),
          reason: '$locale');
    }
  });
}
