import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/success_error_overlay.dart';
import './dashboardPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String phone;
  String password;
  bool showed = false;
  bool isCorrect;
  final key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
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
            margin: EdgeInsets.symmetric(horizontal: 32.0),
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 2),
                Image.asset("media/typoper.png"),
                SizedBox(height: 10),
                Text("Welcome Back to Plata",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.w800)),
                SizedBox(height: 10),
                Text("The Easiest Way to manage your payments easily",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w700)),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.only(bottom: 9.0),
                  child: TextField(
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (s) => phone = s),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 9.0),
                  child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (s) => password = s),
                ),
                RaisedButton(
                  child: Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.deepPurple,
                  onPressed: () => login(phone, password),
                ),
              ],
            ),
          ),
          !showed
              ? Container()
              : SuccessErrorOverlay(
                  isCorrect: isCorrect,
                  onTap: () {
                    if (isCorrect) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => DashboardPage()));
                    } else {
                      setState(() => showed = false);
                    }
                  },
                ),
        ],
      ),
    );
  }

  // dynamic login() async {
  //   key.currentState.showSnackBar(SnackBar(content: Text("Loading...")));
  //   try {
  //     var req = await http.post(
  //       "https://plataapi.tk/api/login",
  //       body: {
  //         "phone": phone,
  //         "password": password,
  //       },
  //     );
  //     var decoded = jsonDecode(req.body);
  //     if (decoded["phone"] != phone && decoded["password"] != password) {
  //       isCorrect = false;
  //       //html.window.alert("error IN MATCHINg");
  //       setState(() {
  //         showed = true;
  //       });
  //       return 1;
  //     } else {
  //       isCorrect = true;
  //       setState(() {
  //         showed = true;
  //       });
  //       var prefs = await SharedPreferences.getInstance();
  //       // prefs.setString("email", email);
  //       prefs.setString("phone", phone);
  //       await Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(builder: (_) => DashboardPage(phone)));
  //       return 0;
  //     }
  //   } catch (err) {
  //     isCorrect = false;
  //     //html.window.alert("error in res");
  //     setState(() {
  //       showed = true;
  //     });
  //     return 1;
  //   }
  // }
  void login(emaila, passworda) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // print(email + password);
    var req = await http.post(
      "https://plataapi.tk/api/v1/users/auth",
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        "password": passworda.toString().trim(),
        "email": emaila.toString().trim(),
      }),
    );
    Map<String, dynamic> decodedJSON;
    var decodeSucceeded = false;
    print(req.body);
    try {
      json.decode(req.body) as Map<String, dynamic>;
      decodeSucceeded = true;
      final snackBar = SnackBar(
        content: Text('Not correct info. Please Try Again'),
      );
      key.currentState.showSnackBar(snackBar);
    } catch (e) {
      var token = req.body.split("::");
      print(token[0]);
      print(token[1]);
      preferences.setBool("logged", true);
      preferences.setString("token", token[0].replaceAll('"', ''));
      preferences.setString("userId", token[1]);
      //preferences.setString("name", req.body);
      print("success");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => DashboardPage()));
    }
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import './dashboardPage.dart';
// import './signupPage.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../utils/success_error_overlay.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   var email;
//   var password;

//   bool isCorrect;
//   bool showed = false;
//   Widget bigScreen() {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           ListView(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Container(
//                     margin: EdgeInsets.only(top: 7.5, left: 41.25),
//                     child: Text(
//                       "Plata",
//                       style: TextStyle(
//                         fontSize: 60.0,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 7.5, left: 700.0),
//                     child: RaisedButton(
//                       child: Text("Home"),
//                       color: Colors.blue,
//                       onPressed: () => Navigator.of(context).pop(),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 7.25, left: 22.5),
//                     child: RaisedButton(
//                       child: Text("Get Started"),
//                       color: Colors.blue,
//                       onPressed: () => Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (context) => LoginPage(),
//                             ),
//                           ),
//                     ),
//                   ),
//                 ],
//               ),
//               Center(
//                 child: Container(
//                   margin:
//                       EdgeInsets.only(left: 450.0, right: 450.0, top: 150.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         "E-Mail",
//                         style: TextStyle(
//                           fontSize: 22.5,
//                         ),
//                       ),
//                       TextField(
//                         decoration: InputDecoration(
//                           //border: OutlineInputBorder(),
//                           hintText: "E-Mail",
//                         ),
//                         onChanged: (s) => email = s,
//                       ),
//                       Text(
//                         "Password",
//                         style: TextStyle(
//                           fontSize: 22.5,
//                         ),
//                       ),
//                       TextField(
//                         onChanged: (s) => password = s,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           //border: OutlineInputBorder(),
//                           hintText: "Password",
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 637.5, vertical: 22.5),
//                 child: RaisedButton(
//                     child: Text("Log In"),
//                     color: Colors.blue,
//                     onPressed: () => login()),
//               ),
//             ],
//           ),
//           !showed
//               ? Container()
//               : SuccessErrorOverlay(
//                   isCorrect: isCorrect,
//                   onTap: () => setState(() => showed = false),
//                 ),
//         ],
//       ),
//     );
//   }

//   Widget smallScreen() {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           ListView(
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.all(15.0),
//                 child: Text(
//                   "Plata",
//                   style: TextStyle(
//                     fontSize: 60.0,
//                   ),
//                 ),
//               ),
//               Center(
//                 child: Container(
//                   margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         "E-Mail",
//                         style: TextStyle(
//                           fontSize: 22.5,
//                         ),
//                       ),
//                       TextField(
//                         decoration: InputDecoration(
//                           //border: OutlineInputBorder(),
//                           hintText: "E-Mail",
//                         ),
//                         onChanged: (s) => email = s,
//                         //keyboardType: TextInputType.datetime,
//                       ),
//                       Text(
//                         "Password",
//                         style: TextStyle(
//                           fontSize: 22.5,
//                         ),
//                       ),
//                       TextField(
//                         onChanged: (s) => password = s,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           //border: OutlineInputBorder(),
//                           hintText: "Password",
//                         ),
//                         textInputAction: TextInputAction.done,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 110.0, vertical: 22.5),
//                 child: RaisedButton(
//                     child: Text("Log In"),
//                     color: Colors.blue,
//                     onPressed: () => login()),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 110.0,),
//                 child: RaisedButton(
//                     child: Text("Sign Up"),
//                     color: Colors.blue,
//                     onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LoginPage()))
//                     ),
//               ),
//             ],
//           ),
//           !showed
//               ? Container()
//               : SuccessErrorOverlay(
//                   isCorrect: isCorrect,
//                   onTap: () => setState(() => showed = false),
//                 ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return smallScreen();

//   }

//   dynamic login() async {
//     try {
//       var req = await http.post(
//         "https://plataapi.tk/api/login",
//         body: {
//           "email": email,
//           "password": password,
//         },
//       );
//       var decoded = jsonDecode(req.body);
//       if (decoded["email"] != email && decoded["password"] != password) {
//         isCorrect = false;
//         //html.window.alert("error IN MATCHINg");
//         setState(() {
//           showed = true;
//         });
//         return 1;
//       } else {
//         isCorrect = true;
//         setState(() {
//           showed = true;
//         });
//         var prefs = await SharedPreferences.getInstance();
//         prefs.setString("email", email);
//         await Navigator.of(context)
//             .pushReplacement(MaterialPageRoute(builder: (_) => DashboardPage(email)));
//         return 0;
//       }
//     } catch (err) {
//       isCorrect = false;
//       //html.window.alert("error in res");
//       setState(() {
//         showed = true;
//       });
//       return 1;
//     }
//   }
// }
