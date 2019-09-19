import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.warning, size: 70.0,),
            Text("There's an error please try again", style: TextStyle(fontSize: 20.0),),
          ], 
        ),
      ),
    );
  }
}