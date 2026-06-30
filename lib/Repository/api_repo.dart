import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiRepo {
  static String Url =
      "http://192.168.168.1:8000/"; // static mean we can call this variable without create object of this class

  static Future<List<Map<String, dynamic>>> getUserInfo({
    required int userId,
  }) async {
    try {
      Map<String, dynamic> body = {'user_id': userId};
      var respone = await http.post(
        Uri.parse("${Url}api/getuserinfo"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      var decoded = jsonDecode(respone.body);
      if (decoded['data'] == null) {
        return [];
      }
      List<Map<String, dynamic>> listResponse = [];
      listResponse = List<Map<String, dynamic>>.from(
        decoded['data'],
      );
      return listResponse;
    } catch (e) {
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      Map<String, dynamic> body = {'email': email, 'password': password};
      var respone = await http.post(
        Uri.parse("${Url}api/login"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      var decoded = jsonDecode(respone.body);
      if (decoded['data'] == null) {
        return [];
      }
      List<Map<String, dynamic>> listResponse = [];
      listResponse = List<Map<String, dynamic>>.from(
        decoded['data'],
      );
      return listResponse;
    } catch (e) {
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getModule({
    required dynamic role,
  }) async {
    try {
      Map<String, dynamic> body = {'role': role};
      var respone = await http.post(
        Uri.parse("${Url}api/getmodule"),
        body: jsonEncode(body),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      );
      var decoded = jsonDecode(respone.body);
      if (decoded['data'] == null && decoded['modules'] == null) {
        return [];
      }
      List<Map<String, dynamic>> listResponse = [];
      if (decoded['data'] != null) {
        listResponse = List<Map<String, dynamic>>.from(decoded['data']);
      } else if (decoded['modules'] != null) {
        listResponse = List<Map<String, dynamic>>.from(decoded['modules']);
      }
      return listResponse;
    } catch (e) {
      return [];
    }
  }
}
