import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:show_dialog/show_dialog.dart';
import './errorPage.dart';

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
    check();
  }

  var loaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: loaded == false
            ? CircularProgressIndicator()
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 80.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Amount", border: OutlineInputBorder()),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.deepPurple,
                      child:
                          Text("Submit", style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  void check() {
    request();
    // var email = widget.;

    // bool a = EmailValidator.validate(widget.emailsc, true, true) == true;
    // if (a) {
    //   request();
    //   return;
    // } else {
    //   Navigator.of(context).push(MaterialPageRoute(builder: (_) => ErrorPage()));
    //   // showaboutDialog(
    //   //   title: "Error",
    //   //   content: "not valid email",
    //   //   buText: "",
    //   //   onPress: null,
    //   //   context: context
    //   // );
    //   // showDialog(
    //   //   context: context,
    //   //   builder: (context) {
    //   //     return AlertDialog(
    //   //       title: Text('Material Dialog'),
    //   //       content: Text('This is the content of the material dialog'),
    //   //       actions: <Widget>[
    //   //         FlatButton(
    //   //             onPressed: () {
    //   //               Navigator.of(context).pop();
    //   //             },
    //   //             child: Text('Close')),
    //   //       ],
    //   //     );
    //   //   },
    //   // );
    // }
  }

  void request() async {
    var email = widget.emailsc;
    var req =
        await http.get("https://plataapi.tk/api/account/"+email);
    var decoded = jsonDecode(req.body);
    if(decoded != null){
    // setState(() {
    //   loaded = true;
    // });
    print("email");
    } else {
      // Navigator.of(context).push(MaterialPageRoute(builder: (_) => ErrorPage()));
      print("not");
    
    }
  }

  void submit() async {}
}
