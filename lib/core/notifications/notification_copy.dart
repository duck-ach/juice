import '../../l10n/app_localizations.dart';

/// (제목, 본문) 알림 카피 한 쌍.
typedef NotificationCopy = (String title, String body);

/// 알림 문구 풀. 실제 스케줄링 로직은 [NotificationService]에 있고, 여기는 카피만 모아둔다.
/// 문구는 모두 l10n(ARB)에서 오며, 알림은 BuildContext 없이 예약되므로 호출부가
/// `lookupAppLocalizations(locale)`로 만든 [AppLocalizations]를 넘겨준다.
class NotificationCopyPool {
  NotificationCopyPool._();

  /// 저녁 8시 알림 풀. [weekday]는 [DateTime.monday](1)~[DateTime.sunday](7)이며,
  /// 요일마다 5개씩 따로 준비해 두어 "불금" 멘트가 평일에 뜨는 식의 어긋남이 없다.
  /// 호출부는 이 풀 안에서 날짜 시드로 한 쌍을 고른다.
  static List<NotificationCopy> eveningFor(AppLocalizations l, int weekday) =>
      switch (weekday) {
        DateTime.monday => [
            (l.notifEveningMon1Title, l.notifEveningMon1Body),
            (l.notifEveningMon2Title, l.notifEveningMon2Body),
            (l.notifEveningMon3Title, l.notifEveningMon3Body),
            (l.notifEveningMon4Title, l.notifEveningMon4Body),
            (l.notifEveningMon5Title, l.notifEveningMon5Body),
          ],
        DateTime.tuesday => [
            (l.notifEveningTue1Title, l.notifEveningTue1Body),
            (l.notifEveningTue2Title, l.notifEveningTue2Body),
            (l.notifEveningTue3Title, l.notifEveningTue3Body),
            (l.notifEveningTue4Title, l.notifEveningTue4Body),
            (l.notifEveningTue5Title, l.notifEveningTue5Body),
          ],
        DateTime.wednesday => [
            (l.notifEveningWed1Title, l.notifEveningWed1Body),
            (l.notifEveningWed2Title, l.notifEveningWed2Body),
            (l.notifEveningWed3Title, l.notifEveningWed3Body),
            (l.notifEveningWed4Title, l.notifEveningWed4Body),
            (l.notifEveningWed5Title, l.notifEveningWed5Body),
          ],
        DateTime.thursday => [
            (l.notifEveningThu1Title, l.notifEveningThu1Body),
            (l.notifEveningThu2Title, l.notifEveningThu2Body),
            (l.notifEveningThu3Title, l.notifEveningThu3Body),
            (l.notifEveningThu4Title, l.notifEveningThu4Body),
            (l.notifEveningThu5Title, l.notifEveningThu5Body),
          ],
        DateTime.friday => [
            (l.notifEveningFri1Title, l.notifEveningFri1Body),
            (l.notifEveningFri2Title, l.notifEveningFri2Body),
            (l.notifEveningFri3Title, l.notifEveningFri3Body),
            (l.notifEveningFri4Title, l.notifEveningFri4Body),
            (l.notifEveningFri5Title, l.notifEveningFri5Body),
          ],
        DateTime.saturday => [
            (l.notifEveningSat1Title, l.notifEveningSat1Body),
            (l.notifEveningSat2Title, l.notifEveningSat2Body),
            (l.notifEveningSat3Title, l.notifEveningSat3Body),
            (l.notifEveningSat4Title, l.notifEveningSat4Body),
            (l.notifEveningSat5Title, l.notifEveningSat5Body),
          ],
        DateTime.sunday => [
            (l.notifEveningSun1Title, l.notifEveningSun1Body),
            (l.notifEveningSun2Title, l.notifEveningSun2Body),
            (l.notifEveningSun3Title, l.notifEveningSun3Body),
            (l.notifEveningSun4Title, l.notifEveningSun4Body),
            (l.notifEveningSun5Title, l.notifEveningSun5Body),
          ],
        _ => throw ArgumentError.value(weekday, 'weekday', 'must be 1..7'),
      };

  /// 월요일 아침 7시 전용 고정 카피(새 한 주의 시작).
  static NotificationCopy mondayMorning(AppLocalizations l) =>
      (l.notifMondayTitle, l.notifMondayBody);

  /// 화~토요일 아침 7시. 아침 확언·명언·운세 톤이며, 이 중 하나를 날짜 기준으로 골라 보낸다.
  static List<NotificationCopy> weekdayMorning(AppLocalizations l) => [
        (l.notifWeekday1Title, l.notifWeekday1Body),
        (l.notifWeekday2Title, l.notifWeekday2Body),
        (l.notifWeekday3Title, l.notifWeekday3Body),
        (l.notifWeekday4Title, l.notifWeekday4Body),
        (l.notifWeekday5Title, l.notifWeekday5Body),
        (l.notifWeekday6Title, l.notifWeekday6Body),
        (l.notifWeekday7Title, l.notifWeekday7Body),
        (l.notifWeekday8Title, l.notifWeekday8Body),
      ];

  /// 일요일 아침 7시. 느긋한 확언·명언·운세 톤이며, 이 중 하나를 날짜 기준으로 골라 보낸다.
  static List<NotificationCopy> sundayMorning(AppLocalizations l) => [
        (l.notifSunday1Title, l.notifSunday1Body),
        (l.notifSunday2Title, l.notifSunday2Body),
        (l.notifSunday3Title, l.notifSunday3Body),
      ];

  /// 마지막 방문 후 n일이 지나면 순서대로 보내는 복귀 유도 카피 (2, 3, 5, 7, 14일).
  static List<NotificationCopy> comeback(AppLocalizations l) => [
        (l.notifComeback1Title, l.notifComeback1Body),
        (l.notifComeback2Title, l.notifComeback2Body),
        (l.notifComeback3Title, l.notifComeback3Body),
        (l.notifComeback4Title, l.notifComeback4Body),
        (l.notifComeback5Title, l.notifComeback5Body),
      ];

  /// [comeback]과 짝을 이루는, 마지막 방문 후 경과일 기준 오프셋.
  static const comebackOffsetDays = <int>[2, 3, 5, 7, 14];
}
