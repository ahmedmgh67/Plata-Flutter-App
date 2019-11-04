// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:success_error_overlay/success_error_overlay.dart';
// import 'package:clipboard_manager/clipboard_manager.dart';
// import 'package:dio/dio.dart';

// class NewTransictionPage extends StatefulWidget {
//   @override
//   _NewTransictionPageState createState() => _NewTransictionPageState();
// }

// class _NewTransictionPageState extends State<NewTransictionPage> {
//   var amount = "";
//   var description = "no description";
//   var cs = 0;
//   var isCorrect;
//   var showed = false;
//   var re = 0.0;
//   final key = new GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: key,
//       resizeToAvoidBottomPadding: false,
//       appBar: AppBar(),
//       body: Stack(
//         fit: StackFit.expand,
//         children: <Widget>[
//           Column(
//             children: <Widget>[
//               Stepper(
//                 currentStep: cs,
//                 type: StepperType.vertical,
//                 onStepContinue: () {
//                   if (cs == 1){
//                     submit();
//                   } else {
//                     setState(() => cs++);
//                   }
//                 },
//                 onStepTapped: (s) => setState(() => cs = s),
//                 onStepCancel: () => Navigator.of(context).pop(),
//                 steps: [
//                   Step(
//                     isActive: true,
//                     title: Text("Enter Amount"),
//                     content: Column(
//                       children: <Widget>[
//                         TextField(
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(),
//                             labelText: "Amount",
//                           ),
//                           keyboardType: TextInputType.number,
//                           onChanged: (s) {
//                             amount = s;
//                             setState(() {
//                               re = int.parse(s) * 0.97.toDouble();
//                             });
//                           },
//                         ),
//                         Text("you'll recieve $re EGP")
//                       ],
//                     ),
//                   ),
//                   Step(
//                     isActive: true,
//                     title: Text("Enter Description (Optional)"),
//                     content: TextField(
//                       decoration: InputDecoration(
//                           border: OutlineInputBorder(),
//                           labelText: "Description"),
//                       onChanged: (s) => description = s,
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 20.0, left: 20.0),
//                 child: RaisedButton(
//                   child: Text(
//                     "Submit",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   onPressed: () => submit(),
//                   color: Colors.deepPurple,
//                 ),
//               ),
//             ],
//           ),
//           !showed
//               ? Container()
//               : SuccessErrorOverlay(
//                   isCorrect: isCorrect,
//                   onTap: () => Navigator.of(context).pop(),
//                 )
//         ],
//       ),
//     );
//   }

//   void submit() async {
//     var prefs = await SharedPreferences.getInstance();
//     var user = prefs.getString("phone");
//     var req = await Dio().post(
//       "https://plataapi.tk/api/transaction",
//       data: {
//         "user": user,
//         "amount": amount,
//         "desc": description,
//       },
//     );
//     //var decoded = jsonDecode(req.body);
//     print(req.data);
//     if (req.statusCode == 200) {
//       ClipboardManager.copyToClipBoard(
//               "https://plataapi.tk/pay.html?id=${req.data["_id"]}")
//           .then((result) {
//         final snackBar = SnackBar(
//           content: Text('Copied to Clipboard'),
//         );
//         key.currentState.showSnackBar(snackBar);
//       });
//       isCorrect = true;
//       setState(() {
//         showed = true;
//       });
//     } else {
//       isCorrect = false;
//       setState(() {
//         showed = true;
//       });
//     }
//   }
// }
