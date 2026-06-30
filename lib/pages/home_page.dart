import 'package:flutter/material.dart';
import 'package:online_pos/Helper/helper.dart';
import 'package:online_pos/Pages/Auth/login_page.dart';
import 'package:online_pos/Pages/Sale/sale_page.dart';
import 'package:online_pos/Repository/api_repo.dart';
import 'package:online_pos/Storage/local_str.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> userInfo = {
    // "name": "Thearak",
    // "phone": "09878776",
    // "role": "admin",
  };

  List<Map<String, dynamic>> listModule = [];
  bool isLoading = true;
  String? errorMessage;

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

  Future<void> getModule() async {
    String? role = userInfo['role'] ?? userInfo['user_role'] ?? userInfo['userRole'] ?? userInfo['role_id']?.toString();
    if (role == null) {
      setState(() {
        errorMessage = "User role not found.";
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      listModule = await ApiRepo.getModule(role: role);
      if (listModule.isEmpty) {
        errorMessage = "No modules available for this role.";
      }
    } catch (e) {
      errorMessage = "Failed to load modules. Please check your connection.";
      listModule = [];
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getUserId() async {
    try {
      String? userId = await LocalStr.getUserStorage();
      if (userId == null) {
        setState(() {
          errorMessage = "User not logged in.";
          isLoading = false;
        });
        return;
      }

      String? savedRole = await LocalStr.getUserRole();

      final value = await ApiRepo.getUserInfo(userId: int.parse(userId));
      if (value.isNotEmpty) {
        userInfo = value[0];
        Object? apiRole = userInfo['role'] ?? userInfo['user_role'] ?? userInfo['userRole'] ?? userInfo['role_id'];
        if (apiRole != null) {
          userInfo['role'] = apiRole.toString();
          await LocalStr.saveUserRole(role: apiRole.toString());
        } else if (savedRole != null) {
          userInfo['role'] = savedRole;
        }
        await getModule();
      } else {
        setState(() {
          errorMessage = "Failed to load user info.";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Failed to load user info. Please check your connection.";
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserId();
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
                          image: DecorationImage(
                            image: AssetImage("assets/images/user.jpg"),
                          ),
                          shape: BoxShape.circle,
                          // color: Colors.white.withOpacity(0.2),
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        // child: Icon(
                        //   Icons.person,
                        //   size: 40,
                        //   color: Colors.white,
                        // ),
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
                              userInfo['email'] ?? "",
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
                                userInfo['role']?.toUpperCase() ?? "USER",
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
                      "Available Modules",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF667eea),
                      ),
                    ),
                    SizedBox(height: 16),
                    if (isLoading)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (errorMessage != null)
                      Padding(
                        padding: EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Text(
                              errorMessage!,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: getModule,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF667eea),
                              ),
                              child: Text("Retry"),
                            ),
                          ],
                        ),
                      )
                    else if (listModule.isEmpty)
                      Padding(
                        padding: EdgeInsets.all(32),
                        child: Column(
                          children: [
                            Text(
                              "No modules available.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: getModule,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF667eea),
                              ),
                              child: Text("Retry"),
                            ),
                          ],
                        ),
                      )
                    else
                      GridView.builder(
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
                                            listModule[index]['name']
                                                .toString(),
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
