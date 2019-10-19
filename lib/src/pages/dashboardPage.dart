import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';
import './transactionsPage.dart';
import './withdrawPage.dart';
import './settingsPage.dart';
import './qrPage.dart';
import './sendMoneyPage.dart';

class DashboardPage extends StatefulWidget {
  final String phone;
  DashboardPage(this.phone);
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  initState() {
    super.initState();
    request();
  }

  List apartments = [];
  bool loaded = false;

  var balance;
  var name;
  int trn;
  var transactionjson;
  Widget smallScreen() {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        //backgroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Plata Dashboard',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 30.0),
        ),
        centerTitle: true,
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (_) => NewTransictionPage())),
      //   child: Icon(
      //     Icons.add,
      //     size: 31.0,
      //   ),
      // ),
      drawer: Drawer(
        child: !loaded
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountEmail: Text(widget.phone),
                      accountName: Text(name),
                      decoration: BoxDecoration(color: Colors.deepPurple),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.purple,
                        child:
                            Text(name.toString().substring(0, 1).toUpperCase(), style: TextStyle(fontSize: 39.0),),
                      ),
                    ),
                    ListTile(
                        title: Text("Transactions"),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) =>
                                    TransactionPage(transactionjson)))),
                    ListTile(
                        title: Text("Withdraw"),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => WithdrawPage(balance)))),
                    Divider(),
                    ListTile(
                        title: Text("Settings"),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SettingsPage()))),
                  ],
                ),
              ),
      ),
      body: !loaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : StaggeredGridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              children: <Widget>[
                _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Welcome',
                                  style: TextStyle(color: Colors.redAccent)),
                              Text(name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15.0))
                            ],
                          ),
                          Material(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(24.0),
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.account_circle,
                                    color: Colors.white, size: 30.0),
                              )))
                        ]),
                  ),
                ),
                _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('transaction Made',
                                  style: TextStyle(color: Colors.blueAccent)),
                              Text(trn.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34.0))
                            ],
                          ),
                          Material(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(24.0),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.timeline,
                                    color: Colors.white, size: 30.0),
                              )))
                        ]),
                  ),
                ),
                _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Balance',
                                  style: TextStyle(color: Colors.blueAccent)),
                              Text(balance,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 34.0))
                            ],
                          ),
                          Material(
                              color: Colors.lightGreen,
                              borderRadius: BorderRadius.circular(24.0),
                              child: Center(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.attach_money,
                                    color: Colors.white, size: 30.0),
                              )))
                        ]),
                  ),
                ),
                _buildTile(
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Material(
                                color: Colors.teal,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.widgets,
                                      color: Colors.white, size: 30.0),
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                            Text('transaction',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 21.0)),
                            Text('See All transaction',
                                style: TextStyle(color: Colors.black45)),
                          ]),
                    ),
                    onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                TransactionPage(transactionjson),
                          ),
                        )),
                // _buildTile(
                //     Padding(
                //       padding: const EdgeInsets.all(24.0),
                //       child: Column(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Material(
                //                 color: Colors.amber,
                //                 shape: CircleBorder(),
                //                 child: Padding(
                //                   padding: EdgeInsets.all(16.0),
                //                   child: Icon(Icons.attach_money,
                //                       color: Colors.white, size: 30.0),
                //                 )),
                //             Padding(padding: EdgeInsets.only(bottom: 16.0)),
                //             Text('Withdraw',
                //                 style: TextStyle(
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.w700,
                //                     fontSize: 24.0)),
                //             Text('See All Alerts',
                //                 style: TextStyle(color: Colors.black45)),
                //           ]),
                //     ),
                //     onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => WithdrawPage(balance)))),
                // _buildTile(
                //     Padding(
                //       padding: const EdgeInsets.all(24.0),
                //       child: Column(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: <Widget>[
                //             Material(
                //                 color: Colors.teal,
                //                 shape: CircleBorder(),
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(16.0),
                //                   child: Icon(Icons.settings_applications,
                //                       color: Colors.white, size: 30.0),
                //                 )),
                //             Padding(padding: EdgeInsets.only(bottom: 16.0)),
                //             Text('Deposit',
                //                 style: TextStyle(
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.w700,
                //                     fontSize: 21.0)),
                //             Text('Deposit Money',
                //                 style: TextStyle(color: Colors.black45)),
                //           ]),
                //     ),
                //     onTap: () => Navigator.of(context).push(
                //           MaterialPageRoute(
                //             builder: (context) => DepositPage(),
                //           ),
                //         )),
                _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Material(
                            color: Colors.purple,
                            shape: CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Icon(Icons.bubble_chart,
                                  color: Colors.white, size: 30.0),
                            )),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16.0),
                        ),
                        Text(
                          'Pay ',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 21.0),
                        ),
                        Text(
                          'Pay and Receive',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => QRPage("p::" + widget.phone),
                    ),
                  ),
                ),
                _buildTile(
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Material(
                              color: Colors.grey,
                              shape: CircleBorder(),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Icon(Icons.send,
                                    color: Colors.white, size: 30.0),
                              )),
                          Padding(
                            padding: EdgeInsets.only(bottom: 16.0),
                          ),
                          Text(
                            'Send Money',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 21.0),
                          ),
                          Text(
                            'Send money',
                            style: TextStyle(color: Colors.black45),
                          ),
                        ]),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SendMoneyPage(),
                    ),
                  ),
                ),
              ],
              staggeredTiles: [
                StaggeredTile.extent(2, 110.0),
                StaggeredTile.extent(2, 110.0),
                StaggeredTile.extent(2, 110.0),
                StaggeredTile.extent(1, 180.0),
                StaggeredTile.extent(1, 180.0),
                StaggeredTile.extent(1, 180.0),
                //StaggeredTile.extent(1, 180.0),
                //StaggeredTile.extent(1, 180.0),
              ],
            ),
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell(
          // Do onTap() if it isn't null, otherwise do print()
          onLongPress: onTap,
          onTap: onTap != null
              ? () => onTap()
              : () {
                  print('Not set yet');
                },
          child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return smallScreen();
  }

  void request() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var bioenable = prefs.getBool("authenable");
    if (bioenable == true) {
      LocalAuthentication localAuthentication = LocalAuthentication();

      var authed = await localAuthentication.authenticateWithBiometrics(
        localizedReason: "To open the app",
        useErrorDialogs: true,
        stickyAuth: true,
      );
      if (authed) {
      } else {}
    }
    var req = await http.get(
      "https://plataapi.tk/api/transactions/${widget.phone}",
    );
    var decoded = jsonDecode(req.body);
    transactionjson = decoded;
    print(decoded);
    trn = decoded.length;
    var req2 = await http.get(
      "https://plataapi.tk/api/account/${widget.phone}",
    );
    var decoded2 = jsonDecode(req2.body);
    prefs.setString("userId", decoded2["_id"]);
    prefs.setString("userAm", decoded2["balance"]);
    balance = decoded2["balance"];
    name = decoded2["name"];
    print(decoded2);
    setState(() {
      loaded = true;
    });
  }
}
