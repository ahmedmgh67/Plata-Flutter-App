import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './errorPage.dart';
import '../utils/success_error_overlay.dart';

class ChargeOnePage extends StatefulWidget {
  final phonesc;
  ChargeOnePage(this.phonesc);
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
                  !showed?Container():SuccessErrorOverlay(
                    isCorrect: isCorrect,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
      ),
    );
  }

  void request() async {
    print(widget.phonesc);
    var phone = widget.phonesc;
    var substringList = phone.split("::");
    if (substringList[0] == "b") {
      var billAmount = substringList[2];
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: <Widget>[
                FlatButton(
                  child: Text("Confirm"),
                  onPressed: () =>
                      confirmBusinessPayment(billAmount, substringList[1]),
                ),
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
              title: Text("Confirm"),
              content: Text("Confirm paying $billAmount"),
            );
          });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      // print(phone + "this should be phone");
      var req = await http.get(
        "https://plata-eg.ml/api/v1/users/" + substringList[1],
        headers: {"Authorization": "Bearer $token"},
      );
      var decoded = jsonDecode(req.body);
      if (decoded != null) {
        id = decoded["_id"];
        print(" $decoded decoded");
        setState(() {
          loaded = true;
        });
        //submit();
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => ErrorPage()));
      }
    }
  }

  void confirmBusinessPayment(bill, phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var substringList = phone.split("::");
    String token = prefs.getString("token");
    String userId = prefs.getString("userId");
    var req = await http.post("https://plataapi.tk/api/v1/transactions/",
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "amount": amount,
          "fromUser": userId,
          "toUser": substringList[1]
        }));
    var decoded = jsonDecode(req.body);
    if (decoded["message"] == "amount is less than balance") {
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

  void submit() async {
    var phone = widget.phonesc;
    var substringList = phone.split("::");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    String userId = prefs.getString("userId");
    var req = await http.post("https://plataapi.tk/api/v1/transactions/",
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "amount": amount,
          "fromUser": userId,
          "toUser": substringList[1]
        }));
    var decoded = jsonDecode(req.body);
    if (decoded["message"] == "amount is less than balance") {
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
