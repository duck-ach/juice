/// 앱 전역에서 쓰는 공식 연락처/정책 링크.
class AppLinks {
  AppLinks._();

  static const supportEmail = 'juicebudget@gmail.com';

  static const privacyPolicyUrl =
      'https://cypress-pineapple-600.notion.site/Juice-Budget-3ac083f136a080adb088cd3607b329c8';

  static Uri get supportEmailUri => Uri(
        scheme: 'mailto',
        path: supportEmail,
        query: 'subject=${Uri.encodeComponent('[Juice Budget 문의/피드백]')}',
      );
}
