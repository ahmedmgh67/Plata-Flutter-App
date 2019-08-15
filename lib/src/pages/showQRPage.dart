import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShowQRPage extends StatefulWidget {
  final data;
  ShowQRPage(this.data);
  @override
  _ShowQRPageState createState() => _ShowQRPageState();
}

class _ShowQRPageState extends State<ShowQRPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: QrImage(
          data: widget.data,
          
        )
      ),
    );
  }
  void qr() {

  }
}