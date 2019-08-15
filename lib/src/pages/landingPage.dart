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
            opacity: 0.6,
            child: Image.network(
              "https://images.pexels.com/photos/128367/pexels-photo-128367.png?cs=srgb&dl=architecture-buildings-city-128367.jpg&fm=jpg",
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 70),
              Image.network(
                  "https://d3r4tb575cotg3.cloudfront.net/static/typoper.png"),
              SizedBox(height: 90),
              Text("Welcome to Plata",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0)),
              SizedBox(height: 10),
              Text("The Easiest Way to manage your payments easily",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17.0)),
              SizedBox(height: 90),
              RaisedButton(
                child: Text("Get Started", style: TextStyle(color: Colors.white),),
                color: Colors.deepPurple,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => GetStartedPage())),
              ),
              RaisedButton(
                child: Text("    Log In    ", style: TextStyle(color: Colors.white),),
                color: Colors.deepPurple,
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginPage())),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
