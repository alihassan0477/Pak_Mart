import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<SharedPreferences> createInstance() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs;
  }

  static Future<String> getUserID() async {
    final prefs = await createInstance();

    String? userId = prefs.getString('user_id');

    if (userId == null) {
      return "";
    }

    return userId;
  }

  static Future<void> setPrefsString(String key, String value) async {
    final prefs = await createInstance();

    prefs.setString(key, value);
  }

  static Future<String> getPrefsString(String key) async {
    final prefs = await createInstance();

    final value = prefs.getString(key);

    return value ?? "";
  }

  static Future<void> removePrefs(String key) async {
    final prefs = await createInstance();

    await prefs.remove(key);
  }
}
