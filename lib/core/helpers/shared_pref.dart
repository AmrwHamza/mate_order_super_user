// ignore_for_file: type_literal_in_constant_pattern

// SecureStorage implementation for web
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  // static final _secureStorage = WebStorage();

  static Future<void> setItem(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getItem(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> removeItem(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

class WebStorage {
  final Map<String, String> _localStorage = {};

  Future<void> write({required String key, required String value}) async {
    _localStorage[key] = value;
  }

  Future<String?> read({required String key}) async {
    return _localStorage[key];
  }

  Future<void> delete({required String key}) async {
    _localStorage.remove(key);
  }

  Future<void> deleteAll() async {
    _localStorage.clear();
  }
}

// SharedPrefHelper implementation
class SharedPrefHelper {
  SharedPrefHelper._();

  static Future<void> setData(String key, dynamic value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case String:
        await sharedPreferences.setString(key, value as String);
        break;
      case int:
        await sharedPreferences.setInt(key, value as int);
        break;
      case bool:
        await sharedPreferences.setBool(key, value as bool);
        break;
      case double:
        await sharedPreferences.setDouble(key, value as double);
        break;
      default:
        throw Exception("Unsupported value type: ${value.runtimeType}");
    }
  }

  static Future<dynamic> getData(String key, Type type) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    switch (type) {
      case String:
        return sharedPreferences.getString(key) ?? '';
      case int:
        return sharedPreferences.getInt(key) ?? 0;
      case bool:
        return sharedPreferences.getBool(key) ?? false;
      case double:
        return sharedPreferences.getDouble(key) ?? 0.0;
      default:
        throw Exception("Unsupported type: $type");
    }
  }

  static Future<void> removeData(String key) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  static Future<void> clearAllData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
