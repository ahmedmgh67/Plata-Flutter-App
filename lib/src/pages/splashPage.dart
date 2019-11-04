import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import './signinPage.dart';
import 'dashboardPage.dart';
import './landingPage.dart';

class SplashPage extends StatefulWidget {
  final logged ;
  SplashPage(this.logged);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  Widget navigate = LoginPage();
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      // gradientBackground: LinearGradient(
      //   stops: [
      //     0.0,0.0001,0.1,0.9,1
      //   ],
      //   colors: [
      //     Colors.purple,
      //     Colors.purpleAccent,
      //     Colors.deepPurpleAccent,
      //     Colors.deepPurple,
      //     Colors.purple,
      //   ]
      // ),
      backgroundColor: Colors.white,
      image: Image.asset("media/typoper.png"),
      seconds: 3,
      navigateAfterSeconds: widget.logged ? DashboardPage() : LandingPage(),
      loaderColor: Colors.deepPurple,
    );
  }
  
}
