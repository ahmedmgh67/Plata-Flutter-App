import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:success_error_overlay/success_error_overlay.dart';

class DepositPage extends StatefulWidget {
  
  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
  int cs = 0;
  var amount = "";
  var name = "";
  var phone = "";
  var address = "";
  var showed = false;
  var isCorrect;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            children: <Widget>[
              Stepper(
                currentStep: cs,
                type: StepperType.vertical,
                onStepContinue: () => setState(() => cs++),
                onStepTapped: (s) => setState(() => cs = s),
                onStepCancel: () => Navigator.of(context).pop(),
                steps: [
                  Step(
                    isActive: true,
                    title: Text("Enter Amount"),
                    content: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Amount",
                      ),
                      
                      keyboardType: TextInputType.number,
                      onChanged: (s) => amount = s,
                    ),
                  ),
                  Step(
                    isActive: true,
                    title: Text("Enter Address"),
                    content: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Address"),
                      onChanged: (s) => address = s,
                    ),
                  ),
                  Step(
                    isActive: true,
                    title: Text("Enter Name"),
                    content: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Name"),
                      onChanged: (s) => name = s,
                    ),
                  ),
                  Step(
                    isActive: true,
                    title: Text("Enter Phone"),
                    content: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Phone"),
                      onChanged: (s) => phone = s,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0, left: 20.0),
                child: RaisedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => submit(),
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          !showed
              ? Container()
              : SuccessErrorOverlay(
                  isCorrect: isCorrect,
                  onTap: () => Navigator.of(context).pop(),
                )
        ],
      ),
    );
  }

  void submit() async {
    var prefs = await SharedPreferences.getInstance();
    var user = prefs.getString("phone");
    var req = await http.post(
      "https://plataapi.tk/api/payments",
      body: {
        "user": user,
        "amount": amount,
        "transiction": "withdraw $user",
        "address":address,
        "phone":phone,
        "name":name,
        "withdraw":"deposit"
      },
    );
    if (req.statusCode == 200) {
      print(req.body);
      isCorrect = true;
      setState(() {
        showed = true;
      });
    } else {
      isCorrect = false;
      setState(() {
        showed = true;
      });
    }
  }
}