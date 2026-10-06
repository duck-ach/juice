import '../../l10n/app_localizations.dart';

/// (제목, 본문) 알림 카피 한 쌍.
typedef NotificationCopy = (String title, String body);

/// 알림 문구 풀. 실제 스케줄링 로직은 [NotificationService]에 있고, 여기는 카피만 모아둔다.
/// 문구는 모두 l10n(ARB)에서 오며, 알림은 BuildContext 없이 예약되므로 호출부가
/// `lookupAppLocalizations(locale)`로 만든 [AppLocalizations]를 넘겨준다.
class NotificationCopyPool {
  NotificationCopyPool._();

  /// 매일 저녁 8시, 이 중 하나를 날짜 기준으로 골라 보낸다.
  static List<NotificationCopy> evening(AppLocalizations l) => [
        (l.notifEvening1Title, l.notifEvening1Body),
        (l.notifEvening2Title, l.notifEvening2Body),
        (l.notifEvening3Title, l.notifEvening3Body),
        (l.notifEvening4Title, l.notifEvening4Body),
        (l.notifEvening5Title, l.notifEvening5Body),
      ];

  /// 월요일 아침 7시 전용 고정 카피.
  static NotificationCopy mondayMorning(AppLocalizations l) =>
      (l.notifMondayTitle, l.notifMondayBody);

  /// 화~토요일 아침 7시, 이 중 하나를 날짜 기준으로 골라 보낸다.
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

  /// 일요일 아침 7시, 이 중 하나를 날짜 기준으로 골라 보낸다.
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
