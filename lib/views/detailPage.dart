import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondRoute extends StatefulWidget {
  DocumentSnapshot ds;

  SecondRoute({Key key, @required this.ds}) : super(key: key);

  @override
  SecR createState() => new SecR();
}

class SecR extends State<SecondRoute> {
  String _mo = "", _is = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: FutureBuilder(
          future: onstart(widget.ds),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData)
              return mainPage(context, snapshot.data);
            else
              return new CircularProgressIndicator();
          },
        ),
        backgroundColor: Color(0xFFEEEEEE),
      ),
    );
  }



  Widget userDetails(BuildContext context, DocumentSnapshot ds) {
    // setState(() {
    //   _na = LocalDb.name;
    //   _ad = LocalDb.address;
    //   _mo = LocalDb.mobile;
    //   _em = LocalDb.email;
    // });
    return Card(
      color: Colors.white,
      elevation: 10,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "User Information",
              style: TextStyle(fontSize: 20),
            ),
            Divider(
              color: Colors.black87,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[Text("Name")],
                  ),
                  Column(
                    children: <Widget>[Text(ds.data['Name'])],
                  )
                ],
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[Text("Mobile No")],
                  ),
                  Column(
                    children: <Widget>[Text(ds.data['Mobile'].toString())],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Address",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(ds.data['Address']),
            )
          ],
        ),
      ),
    );
  }

  Widget callInformation(BuildContext context, DocumentSnapshot ds) {
    return Card(
      color: Colors.white,
      elevation: 10,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Call Information",
              style: TextStyle(fontSize: 20),
            ),
            Divider(
              color: Colors.black87,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[Text("Model No")],
                  ),
                  Column(
                    children: <Widget>[Text(_mo)],
                  )
                ],
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                  _is),
            )
          ],
        ),
      ),
    );
  }


  Widget mainPage(BuildContext context, DocumentSnapshot ds) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        userDetails(context, ds),
        callInformation(context, ds),

      ],
    );
  }


  Future<DocumentSnapshot> onstart(DocumentSnapshot dc) async {
    _mo = await dc.data["model"];
    _is = await dc.data["issue"];
    if(_mo == null)
      _mo = "null";
    if(_is == null)
      _is = "null";
    final String uid = dc.reference.parent().parent().documentID.toString();

    return await Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((string) {

      return string;

    });
  }

  Widget st(BuildContext context, DocumentSnapshot dc) {
    // print(dc.reference.parent().parent().documentID);

    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (!snapshot.hasData) return new Text("There is no expense");

          return Text("");
        });
  }
}
