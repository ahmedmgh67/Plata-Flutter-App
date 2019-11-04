import 'package:flutter/material.dart';
import 'package:contact_picker/contact_picker.dart';
import '../utils/success_error_overlay.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SendMoneyPage extends StatefulWidget {
  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final ContactPicker _contactPicker = new ContactPicker();
  Contact acontact;
  TextEditingController cont = TextEditingController();
  final key = new GlobalKey<ScaffoldState>();
  var showed = false;
  var amount;
  var phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ListView(
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.08),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Phone",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.account_circle),
                      onPressed: () async {
                        Contact contact = await _contactPicker.selectContact();
                        acontact = contact;
                        cont.clear();
                        setState(() {
                          cont.text = contact.phoneNumber.number;
                        });
                      },
                    ),
                  ),
                  onChanged: (s) => phone = s,
                  keyboardType: TextInputType.phone,
                  controller: cont,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.08),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Amount"),
                  onChanged: (s) => amount = s,
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepPurple),
                height: 140.0,
                width: 200.0,
                child: InkWell(
                  onTap: () => submit(),
                  child: Center(
                    child: Text("Send Now",
                        style: TextStyle(color: Colors.white, fontSize: 22.0)),
                  ),
                ),
              ),
            ],
          ),
          !showed
              ? Container()
              : SuccessErrorOverlay(
                  isCorrect: true,
                  onTap: () => Navigator.pop(context),
                )
        ],
      ),
    );
  }

  void submit() async {
    if (amount == null || cont.text == null) {
      key.currentState
          .showSnackBar(SnackBar(content: Text("Enter correct info")));
      return;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var userId = prefs.getString("userId");
      var req = await http.get(
        "https://plataapi.tk/api/v1/users/phone/${cont.text}",
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
      );
      var deco = jsonDecode(req.body);
      print(deco);
      if (deco.length == 0) {
        key.currentState.showSnackBar(SnackBar(
          content: Text("Account not Available"),
        ));
        return;
      } else {
        print("availabel!!!!!");
        var reId = deco[0]["_id"];
        var eq = await http.post("https://plataapi.tk/api/v1/transactions",
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json'
            },
            body: jsonEncode(
                {"fromUser": userId, "toUser": reId, "amount": amount}));
        var decoa = jsonDecode(eq.body);
        print(decoa);
        if (decoa["message"] == "amount is less than balance" ||
            decoa["mesaage"] == "missingData") {
          key.currentState.showSnackBar(SnackBar(
            content: Text("Balance not available"),
          ));
        } else {
          setState(() {
            showed = true;
          });
        }
      }
    }
  }
}
