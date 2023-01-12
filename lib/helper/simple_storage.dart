import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Shared preferences Storage
/// → Key-Value Storage
class SimpleStorage {
  static saveStringData(String key, String value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } catch (_) {
      debugPrint(_.toString());
    }
  }

  static Future<String?> getStringData(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (_) {
      debugPrint(_.toString());
    }
    return null;
  }
}
