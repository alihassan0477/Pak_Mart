import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? _prefs;

  LocalStorage._();

  static final LocalStorage instance = LocalStorage._();

  factory LocalStorage() {
    return instance;
  }

  Future<void> _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> setStringValue(String key, String value) async {
    await _init(); // Ensure that preferences are initialized before usage
    await _prefs?.setString(key, value);
  }

  Future<dynamic> getValue(String key) async {
    await _init(); // Ensure that preferences are initialized before usage
    return _prefs?.get(key);
  }

  Future<void> clearValue(String key) async {
    await _init();
    await _prefs?.remove(key);
  }
}
