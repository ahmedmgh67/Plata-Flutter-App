import 'package:flutter/material.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

class TransictionsPage extends StatefulWidget {
  final data;
  TransictionsPage(this.data);
  @override
  _TransictionsPageState createState() => _TransictionsPageState();
}

class _TransictionsPageState extends State<TransictionsPage> {

  @override
  void initState() {
    super.initState();
  }
  var data;
  final key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    //var data = widget.data;
    return Scaffold(
      key: key,
      appBar: AppBar(),
      body: widget.data == null
          ? Center(
              child: Column(
                children: <Widget>[
                  Icon(Icons.block, size: 60.0,), 
                  Text("You Have No Transctions")
                ],
              ),
            )
          : ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (context, int i){
              return ListTile(
                title: Text(widget.data[i]["desc"]),
                subtitle: Text(widget.data[i]["amount"]),
                trailing: IconButton(
                  icon: Icon(Icons.content_copy),
                  onPressed: () => copy(widget.data[i]["_id"]),
                ),
                // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ShowQRPage("https://plataapi.tk/pay.html?id=${widget.data[i]["_id"]}")))
              );
            },
          ), 
    );
  }
  void copy(id) async {
    ClipboardManager.copyToClipBoard("https://plataapi.tk/pay.html?id=$id").then((result) {
        final snackBar = SnackBar(
          content: Text('Link Copied to Clipboard'),
          // action: SnackBarAction(
          //   label: 'Undo',
          //   onPressed: () {},
          // ),
        );
        key.currentState.showSnackBar(snackBar);
      });
  }
}
