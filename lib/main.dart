import 'package:flutter/material.dart';
import './src/pages/splashPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  runApp(new MyApp(prefs.getString("email")));
}

class MyApp extends StatefulWidget {
  final String email;
  MyApp(this.email);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
	  debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      title: 'Plata',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: SplashPage(widget.email),
    );
  }
}
