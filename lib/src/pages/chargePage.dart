import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './errorPage.dart';
import '../utils/success_error_overlay.dart';

class ChargeOnePage extends StatefulWidget {
  final emailsc;
  ChargeOnePage(this.emailsc);
  @override
  _ChargeOnePageState createState() => _ChargeOnePageState();
}

class _ChargeOnePageState extends State<ChargeOnePage> {
  @override
  void initState() {
    super.initState();
    request();
  }

  bool loaded = false;
  String id;
  String amount;

  bool showed = false;
  bool isCorrect;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: loaded == false
            ? CircularProgressIndicator()
            : Stack(
              fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 80.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            labelText: "Amount",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (s) {
                            amount = s;
                          },
                        ),
                        RaisedButton(
                          onPressed: () => submit(),
                          color: Colors.deepPurple,
                          child: Text("Submit",
                              style: TextStyle(color: Colors.white)),
                        )
                      ],
                    ),
                  ),

                ],
              ),
      ),
    );
  }

  void request() async {
    var email = widget.emailsc;
    print(email + "this should be email");
    var req = await http.get("https://plata-eg.ml/api/account/" + email);
    var decoded = jsonDecode(req.body);
    if (decoded != null) {
      id = decoded["_id"];
      print(" $decoded decoded");
      setState(() {
        loaded = true;
      });
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => ErrorPage()));
    }
  }

  void submit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myEmail = prefs.getString("email");
    var req = await http.get(
        "https://plata-eg.ml/api/qrcode/$myEmail/${widget.emailsc}/$amount");
    var decoded = jsonDecode(req.body);
    if (decoded["message"] == "amount is less than balance"){
      isCorrect = false;
      setState(() {
        showed = true;
      });
    } else {
      isCorrect = true;
      setState(() {
        showed = true;
      });
    }
  }
}

// String myid = prefs.getString("userId");
// int balance = int.parse(prefs.getString("userAm"));
// print("$id id");
// print("$amount amount");
// print("$myid myid");
// print("$balance balance");
// String myBalance = (balance + amount).toString();
// String chargedNewBalance = (int.parse(chargedBalance) - amount).toString();
// var req = await http.get("https://plata-eg.ml/api/balance/$id/$chargedNewBalance");
// var req2 = await http.get("https://plata-eg.ml/api/balance/$myid/$myBalance");
// var decoded = jsonDecode(req.body);
// var decoded2 = jsonDecode(req2.body);
// print(decoded);
// print(decoded2);
