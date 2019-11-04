import 'package:flutter/material.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool loaded = false;
  var decoded;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var req = await http.get(
      "https://plataapi.tk/api/v1/transactions/view/",
      headers: {"Authorization": "Bearer $token"},
    );
    decoded = jsonDecode(req.body);
    setState(() {
      loaded = true;
    });
  }

  var data;
  final key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    //var data = widget.data;
    return Scaffold(
      key: key,
      appBar: AppBar(),
      body: loaded == false
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: decoded ==null ? 0 : decoded.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(decoded[i]["toUser"]['username']),
                  subtitle: Text(decoded[i]["amount"]),
                  // trailing: IconButton(
                  //   icon: Icon(Icons.content_copy),
                  //   // onPressed: () => copy(widget.data[i]["_id"]),
                  // ),
                  // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ShowQRPage("https://plataapi.tk/pay.html?id=${widget.data[i]["_id"]}")))
                );
              },
            ),
    );
  }
  // void copy(id) async {
  //   ClipboardManager.copyToClipBoard("https://plataapi.tk/pay.html?id=$id").then((result) {
  //       final snackBar = SnackBar(
  //         content: Text('Link Copied to Clipboard'),
  //         // action: SnackBarAction(
  //         //   label: 'Undo',
  //         //   onPressed: () {},
  //         // ),
  //       );
  //       key.currentState.showSnackBar(snackBar);
  //     });
  // }
}
