import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  LocalAuthentication localAuthentication = LocalAuthentication();
  SharedPreferences prefs;
  bool loaded = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  var bioval = false;
  var bio = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: !loaded ? Center(child: CircularProgressIndicator()):ListView(
        children: <Widget>[
          ListTile(
            title: Text("Use Fingerprint"),
            trailing: Checkbox(
              value: bioval,
              tristate: true,
              onChanged: (val) => switchLT(val),
            ),
          ),
          ListTile(
            title: Text("Log Out"),
            onTap: () => logout(),
          ),
        ],
      ),
    );
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    checkBio();
    checkbioEnabled();
    setState(() {
      loaded = true;
    });
  }

  void switchLT(bool val) async {
    if (val){
      setState(() {
        bioval = true;
      });
      print(val.toString());
      initAuth();
    } else {
      setState(() {
        bioval = false;
      });
      stopAuth();
    }
  }

  void initAuth() {
    prefs.setBool("authenable", true);
  }

  void stopAuth() async {
    prefs.setBool("authenable", false);
  }

  void checkbioEnabled() {
    bioval = prefs.getBool("authenable");
  }

  void checkBio() async {
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    if (canCheckBiometrics) {
      setState(() {
        bio = true;
      });
    } else {
      return;
    }
  }

  void logout() async {
    prefs.clear();
  }
}
