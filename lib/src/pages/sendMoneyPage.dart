import 'package:flutter/material.dart';
import 'package:contact_picker/contact_picker.dart';
import '../utils/success_error_overlay.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(),
      body: Stack(
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
                  onChanged: (s) => amount = s,
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
    if (amount == null || cont.text == null || cont.text.length != 11) {
      key.currentState.showSnackBar(SnackBar(content: Text("Enter correct info")));
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var phone = prefs.getString("phone");
      await http.get("https://plataapi.tk/api/qrcode/$phone/${acontact.phoneNumber.number.toString()}/$amount");
      setState(() {
        showed = true;
      });
    }
  }
}
