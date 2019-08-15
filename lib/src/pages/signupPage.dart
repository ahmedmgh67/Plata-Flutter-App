import 'package:flutter/material.dart';
import './dashboardPage.dart';
import './signinPage.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../utils/success_error_overlay.dart';
import 'package:dio/dio.dart';

class GetStartedPage extends StatefulWidget {
  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  var name;
  var phone;
  var email;
  var password;

  bool isCorrect;
  bool showed = false;

  Widget smallScreen() {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Plata",
                  style: TextStyle(
                    fontSize: 60.0,
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 22.5,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          //border: OutlineInputBorder(),
                          hintText: "Name",
                        ),
                        onChanged: (s) => name = s,
                      ),
                      Text(
                        "E-Mail",
                        style: TextStyle(
                          fontSize: 22.5,
                        ),
                      ),
                      TextField(
                        //obscureText: true,
                        decoration: InputDecoration(
                          //border: OutlineInputBorder(),
                          hintText: "E-Mail",
                        ),
                        onChanged: (s) => email = s,
                      ),
                      Text(
                        "Phone",
                        style: TextStyle(
                          fontSize: 22.5,
                        ),
                      ),
                      TextField(
                        //obscureText: true,
                        decoration: InputDecoration(
                          //border: OutlineInputBorder(),
                          hintText: "Phone",
                        ),
                        onChanged: (s) => phone = s,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 22.5,
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          //border: OutlineInputBorder(),
                          hintText: "Password",
                        ),
                        onChanged: (s) => password = s,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 110.0, vertical: 22.5),
                child: RaisedButton(
                    child: Text("Submit"),
                    color: Colors.blue,
                    onPressed: () => signup("a")),
              ),
            ],
          ),
          !showed
              ? Container()
              : SuccessErrorOverlay(
                  isCorrect: isCorrect,
                  onTap: () {
                    if(isCorrect){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => DashboardPage(email)));
                    } else {
                      setState(() => showed = false);
                    }
                  },
                ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return smallScreen();
  }

  Future<int> signup(a) async {
    var req;
    try {
      var req = await post(
        "https://plata-eg.ml/api/register",
        body: {
          "email": email,
          "password": password,
          "name": name,
          "phone": phone
        },
      );
      var decoded = jsonDecode(req.body);
      //print(decoded);
    } catch (err) {
      print(err);
      throw err;
      isCorrect = false;
      setState(() {
        showed = true;
      });
      return 1;
    }
    isCorrect = true;
    setState(() {
      showed = true;
    });

    return 0;
  }
}
