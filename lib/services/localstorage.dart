import 'package:nhost_flutter_auth/nhost_flutter_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements AuthStore {
  @override
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<void> removeItem(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> removeallItem() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
