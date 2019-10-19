import 'package:flutter/material.dart';
import './signinPage.dart';
import './signupPage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Opacity(
            opacity: 0.4,
            child: Image.asset(
              "media/landing.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 70),
                Image.asset(
                    "media/typoper.png"),
                SizedBox(height: 90),
                Text("Welcome to Plata",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800)),
                SizedBox(height: 10),
                Text("The Easiest Way to manage your payments easily",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700)),
                SizedBox(height: 90),
                RaisedButton(
                  child: Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.deepPurple,
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => GetStartedPage())),
                ),
                RaisedButton(
                  child: Text(
                    "Log In",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.deepPurple,
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => LoginPage())),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
