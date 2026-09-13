import 'package:shared_preferences/shared_preferences.dart';

/// 앱 시작 시 한 번 초기화 후, 이후로는 동기적으로 접근하는 SharedPreferences 래퍼.
/// HiveService가 Hive 박스를 다루는 방식과 동일한 패턴.
class PrefsService {
  PrefsService._();

  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
