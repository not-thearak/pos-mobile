import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_pos/Elements/icon_tab_element.dart';
import 'package:online_pos/Helper/helper.dart';
import 'package:online_pos/Pages/Auth/login_page.dart';
import 'package:online_pos/Pages/Sale/sale_page.dart';
import 'package:online_pos/Repository/api_repo.dart';
import 'package:online_pos/Storage/local_str.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> userInfo = {
    // "name": "Vichet",
    // "phone": "09878776",
    // "role": "admin",
  };

  List<Map<String, dynamic>> listModule = [];
  final List<Color> moduleColors = [
    Color(0xFF667eea),
    Color(0xFF764ba2),
    Color(0xFFf093fb),
    Color(0xFF4facfe),
    Color(0xFF43e97b),
    Color(0xFFfa709a),
    Color(0xFF30cfd0),
    Color(0xFF330867),
  ];

  final List<IconData> moduleIcons = [
    Icons.shopping_cart,
    Icons.people,
    Icons.assessment,
    Icons.settings,
    Icons.notifications,
    Icons.payment,
    Icons.inventory,
    Icons.support_agent,
  ];

  void getModule() async {
    listModule = await ApiRepo.getModule(role: 'admin');
    // listModule = await ApiRepo.getModule(role: userInfo['role']);
    setState(() {});
  }

  void getUserId() {
    LocalStr.getUserStorage().then((userId) {
      // print("User ID: $value");
      ApiRepo.getUserInfo(userId: int.parse(userId!)).then((value) {
        userInfo = value[0];
        setState(() {});
      });
    });
  }

  @override
  void initState() {
    getUserId();
    getModule();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(0xFF667eea),
        title: Text(
          Helper.tranSalate(key: "home_page"),
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              bool isRemove = await LocalStr.clearStorage();
              if (isRemove == true) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              } else {
                print(" can not remote, Error");
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.logout, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF667eea).withOpacity(0.08), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // User Info Header
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF667eea), Color(0xFF764ba2)],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userInfo['name'] ?? "User",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              userInfo['email'] ?? "N/A",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                userInfo['role_id']?.toString().toUpperCase() ?? "Admin",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Modules Section
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Helper.tranSalate(key: "available_modules"),
                      // "Available Modules",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF667eea),
                      ),
                    ),
                    SizedBox(height: 16),
                    listModule.isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: listModule.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 1.2,
                                ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        moduleColors[index %
                                            moduleColors.length],
                                        moduleColors[index %
                                                moduleColors.length]
                                            .withOpacity(0.7),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            moduleColors[index %
                                                    moduleColors.length]
                                                .withOpacity(0.4),
                                        blurRadius: 12,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      onTap: () {
                                        print("Hello world");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return SalePage();
                                            },
                                          ),
                                        );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 56,
                                            height: 56,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white.withOpacity(
                                                0.25,
                                              ),
                                            ),
                                            child: Icon(
                                              moduleIcons[index %
                                                  moduleIcons.length],
                                              color: Colors.white,
                                              size: 28,
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          Text(
                                            Helper.tranSalate(
                                              key: listModule[index]['name']
                                                  .toString(),
                                            ),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
