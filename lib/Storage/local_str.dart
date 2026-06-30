import 'package:shared_preferences/shared_preferences.dart';

class LocalStr {
  static Future<bool> saveUserStorage({required String valStr}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSaved = await prefs.setString("user_id", valStr);
    if (isSaved == true) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String?> getUserStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await prefs.getString("user_id");
    return response;
  }

  static Future<bool> saveUserRole({required String role}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("user_role", role);
  }

  static Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_role");
  }

  static Future<bool> clearStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRemoved = await prefs.remove("user_id");
    await prefs.remove("user_role");
    return isRemoved;
  }
}
