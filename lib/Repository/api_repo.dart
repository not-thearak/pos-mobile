import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiRepo {
  static String Url =
      "http://192.168.168.1:8000/"; // static mean we can call this variable without create object of this class

  // Get all confirmSale
  static Future<bool> confirmSale({required Map<String, dynamic> body}) async {
    var respone = await http.post(
      Uri.parse("${Url}api/confirm-sale"),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    if (respone.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } 
  // Get all updateQty
  static Future<bool> updateQty({required Map<String, dynamic> body}) async {
    var respone = await http.post(
      Uri.parse("${Url}api/update_qty"),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    if (respone.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Get all getHoldProduct
  static Future<List<Map<String, dynamic>>> getHoldProduct() async {
    var respone = await http.post(
      Uri.parse("${Url}api/get-hold-products"),

      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    List<Map<String, dynamic>> listResponse = [];
    listResponse = List<Map<String, dynamic>>.from(
      jsonDecode(respone.body)['data'],
    );
    return listResponse;
  }

  // Get all HoldInsert
  static Future<bool> holdInsert({required Map<String, dynamic> body}) async {
    var respone = await http.post(
      Uri.parse("${Url}api/hold-insert"),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    if (respone.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Get all category
  static Future<List<Map<String, dynamic>>> getCategory() async {
    var respone = await http.post(
      Uri.parse("${Url}api/get-category"),

      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    List<Map<String, dynamic>> listResponse = [];
    listResponse = List<Map<String, dynamic>>.from(
      jsonDecode(respone.body)['data'],
    );
    return listResponse;
  }

  // Get all product
  static Future<List<Map<String, dynamic>>> getProduct({
    required int categoryId,
  }) async {
    var respone = await http.post(
      Uri.parse("${Url}api/get-all-products"),
      body: jsonEncode({'category_id': categoryId}),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );

    List<Map<String, dynamic>> listResponse = [];
    listResponse = List<Map<String, dynamic>>.from(
      jsonDecode(respone.body)['data'],
    );
    return listResponse;
  }

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
      listResponse = List<Map<String, dynamic>>.from(decoded['data']);
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
      listResponse = List<Map<String, dynamic>>.from(decoded['data']);
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
