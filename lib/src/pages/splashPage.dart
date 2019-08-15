import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './signinPage.dart';
import 'dashboardPage.dart';
import './landingPage.dart';

class SplashPage extends StatefulWidget {
  final String user ;
  SplashPage(this.user);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  Widget navigate = LoginPage();
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      gradientBackground: LinearGradient(
        stops: [
          0.0,0.0001,0.1,0.9,1
        ],
        colors: [
          Colors.purple,
          Colors.purpleAccent,
          Colors.deepPurpleAccent,
          Colors.deepPurple,
          Colors.purple,
        ]
      ),
      image: Image.network("https://d3r4tb575cotg3.cloudfront.net/static/typoper.png"),
      seconds: 3,
      navigateAfterSeconds: widget.user != null ? DashboardPage(widget.user) : LandingPage(),
      loaderColor: Colors.white,
    );
  }
  
}