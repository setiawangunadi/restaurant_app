import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsStorage {
  static const String kNotification = "notification";

  static Future<SharedPreferences> get sharedPrefs =>
      SharedPreferences.getInstance();

  //SessionId
  static Future<int?> getNotification() async =>
      (await sharedPrefs).getInt(kNotification);

  static Future setNotification({required int notification}) async =>
      (await sharedPrefs).setInt(kNotification, notification);

  static Future clearNotification() async =>
      (await sharedPrefs).remove(kNotification);

  static Future clearAll() async {
    (await sharedPrefs).remove(kNotification);
  }
}
