import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './chargePage.dart';

class QRPage extends StatefulWidget {
  final String phone;
  QRPage(this.phone);
  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  SharedPreferences prefs;

  bool loaded = false;
  @override
  initState() {
    super.initState();
    init();
  }
  void init() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loaded = true;
    });
  }

  String url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => scan(),
        child: Icon(Icons.camera),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: QrImage(
            data: widget.phone//prefs.getString("phone"),
          ),
        ),
      ),
    );
  }
  dynamic scan() async {
    var result = await QRCodeReader().scan();
    //print(result);
    if (result != null){
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => ChargeOnePage(result)));
      return 0;
    }
    Navigator.of(context).pop();
    return 1;
  }
}