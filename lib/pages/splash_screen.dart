import 'package:flutter/material.dart';
import 'package:online_pos/Pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // go splash screen
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder:(context) => HomePage(),));
      });
    });
    super.initState();
  }

  // home
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo_icon.png'),
                ),
              ),
            ),
            Text("WELCOME TO MY POST",style: TextStyle(fontSize: 15),)
          ],
        ),
      ),
    );
  }
}
