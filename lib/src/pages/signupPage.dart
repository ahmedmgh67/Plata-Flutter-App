import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../utils/success_error_overlay.dart';
import './dashboardPage.dart';

class GetStartedPage extends StatefulWidget {
  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  String name;
  String phone;
  String password;
  bool showed = false;
  bool isCorrect;
  final key = new GlobalKey<ScaffoldState>();
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
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 2),
                Image.asset("media/typoper.png"),
                SizedBox(height: 10),
                Text("Welcome to Plata",
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
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (s) => name = s),
                ),
                // Container(
                //   margin: EdgeInsets.only(bottom: 9.0),
                //   child: TextField(
                //       decoration: InputDecoration(
                //         labelText: "E-Mail",
                //         border: OutlineInputBorder(),
                //       ),
                //       onChanged: (s) => email = s),
                // ),
                Container(
                  margin: EdgeInsets.only(bottom: 9.0),
                  child: TextField(
                      decoration: InputDecoration(
                        labelText: "Phone",
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
                  onPressed: () => signup("a"),
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
                      Navigator.of(context).pop();
                    } else {
                      setState(() => showed = false);
                    }
                  },
                ),
        ],
      ),
    );
  }

  Future<int> signup(a) async {
    key.currentState.showSnackBar(SnackBar(content: Text("Loading...")));

    try {
      await post(
        "https://plata-eg.ml/api/register",
        body: {
          // "email": email,
          "password": password,
          "name": name,
          "phone": phone
        },
      );
      // var decoded = jsonDecode(req.body);
      //print(decoded);
    } catch (err) {
      print(err);
      isCorrect = false;
      setState(() {
        showed = true;
      });
      return 1;
    }
    key.currentState.showSnackBar(SnackBar(content: Text("Loading...")));
    isCorrect = true;
    setState(() {
      showed = true;
    });

    return 0;
  }
}

// import 'package:flutter/material.dart';
// import './dashboardPage.dart';
// import './signinPage.dart';
// import 'package:http/http.dart';
// import 'dart:convert';
// import '../utils/success_error_overlay.dart';
// import 'package:dio/dio.dart';

// class GetStartedPage extends StatefulWidget {
//   @override
//   _GetStartedPageState createState() => _GetStartedPageState();
// }

// class _GetStartedPageState extends State<GetStartedPage> {
//   var name;
//   var phone;
//   var email;
//   var password;

//   bool isCorrect;
//   bool showed = false;

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
//                         "Name",
//                         style: TextStyle(
//                           fontSize: 22.5,
//                         ),
//                       ),
//                       TextField(
//                         decoration: InputDecoration(
//                           //border: OutlineInputBorder(),
//                           hintText: "Name",
//                         ),
//                         onChanged: (s) => name = s,
//                       ),
//                       Text(
//                         "E-Mail",
//                         style: TextStyle(
//                           fontSize: 22.5,
//                         ),
//                       ),
//                       TextField(
//                         //obscureText: true,
//                         decoration: InputDecoration(
//                           //border: OutlineInputBorder(),
//                           hintText: "E-Mail",
//                         ),
//                         onChanged: (s) => email = s,
//                       ),
//                       Text(
//                         "Phone",
//                         style: TextStyle(
//                           fontSize: 22.5,
//                         ),
//                       ),
//                       TextField(
//                         //obscureText: true,
//                         decoration: InputDecoration(
//                           //border: OutlineInputBorder(),
//                           hintText: "Phone",
//                         ),
//                         onChanged: (s) => phone = s,
//                       ),
//                       Text(
//                         "Password",
//                         style: TextStyle(
//                           fontSize: 22.5,
//                         ),
//                       ),
//                       TextField(
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           //border: OutlineInputBorder(),
//                           hintText: "Password",
//                         ),
//                         onChanged: (s) => password = s,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 110.0, vertical: 22.5),
//                 child: RaisedButton(
//                     child: Text("Submit"),
//                     color: Colors.blue,
//                     onPressed: () => signup("a")),
//               ),
//             ],
//           ),
//           !showed
//               ? Container()
//               : SuccessErrorOverlay(
//                   isCorrect: isCorrect,
//                   onTap: () {
//                     if(isCorrect){
//                       Navigator.of(context).push(MaterialPageRoute(builder: (_) => DashboardPage(email)));
//                     } else {
//                       setState(() => showed = false);
//                     }
//                   },
//                 ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return smallScreen();
//   }

//   Future<int> signup(a) async {
//     var req;
//     try {
//       var req = await post(
//         "https://plata-eg.ml/api/register",
//         body: {
//           "email": email,
//           "password": password,
//           "name": name,
//           "phone": phone
//         },
//       );
//       var decoded = jsonDecode(req.body);
//       //print(decoded);
//     } catch (err) {
//       print(err);
//       throw err;
//       isCorrect = false;
//       setState(() {
//         showed = true;
//       });
//       return 1;
//     }
//     isCorrect = true;
//     setState(() {
//       showed = true;
//     });

//     return 0;
//   }
// }
