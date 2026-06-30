// import 'package:flutter/services.dart';

import 'dart:convert';

import 'package:flutter/services.dart';

class Helper {
  
  static Map<String,dynamic> mapLang={};

  static Future<void> loadAssets({required String lanCode})async{

    String valJson= await rootBundle.loadString("assets/lang/${lanCode}.json");
    mapLang=jsonDecode(valJson); // {"key":"val"}
    // print("mapLang = ${mapLang['home_page']}");
  
  }
  static String tranSalate({required String key}){
    if(mapLang[key]==null){
      return key.toUpperCase();
    }else{
      return mapLang[key];
    }
  }

}