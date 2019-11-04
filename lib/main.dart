import 'package:flutter/material.dart';
import './src/pages/splashPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var logged = prefs.getBool("logged");
  if (logged == null) {
    logged = false;
  }
  runApp(MyApp(logged));
}

class MyApp extends StatefulWidget {
  final  logged;
  MyApp(this.logged);

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
      home: SplashPage(widget.logged),
    );
  }
}
