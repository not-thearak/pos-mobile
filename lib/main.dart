import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_pos/Helper/helper.dart';
import 'package:online_pos/Pages/Auth/login_page.dart';
import 'package:online_pos/Pages/home_page.dart';
import 'package:online_pos/Pages/splash_screen.dart';
import 'package:online_pos/Storage/local_str.dart';

void main() {
  runApp(
    
    const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

 
  bool isLoading=false;
  String? result="";
  void checkStorage()async{
     result=await LocalStr.getUserStorage();
     setState(() {
       
     });
  }

  void initLang()async{
    isLoading=true;
    await  Helper.loadAssets(lanCode: 'en');
     isLoading=false;
     setState(() {
     });
  }
  @override
  void initState() {
    checkStorage();
    initLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:isLoading==true?SizedBox(): result !=null?HomePage(): LoginPage()
      );
    // return MaterialApp(home: HomePage(),);
  }
}

// storage [///////]