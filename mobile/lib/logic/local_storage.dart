import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  // Save a value to local storage
  Future<void> saveValue(String key, String value) async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    await prefs.then((pref) {
      pref.setString(key, value);
    });
  }

  // Retrieve a value from local storage
  Future<String?> getValue(String key) async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    return prefs.then((pref) {
      return pref.getString(key);
    });
  }

  // Remove a value from local storage
  Future<void> removeValue(String key) async {
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    await prefs.then((pref) {
      pref.remove(key);
    });
  }
}
