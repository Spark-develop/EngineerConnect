import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompletedCall extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CompletedCall();
  }
}

class _CompletedCall extends State<CompletedCall> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(child: test(context));
  }

  Widget test(BuildContext context) {
        String uid = "YyL4P1jO5jJOzUcpjZXn";

    // var s =  Firestore.instance.collection('calls').where('model',isNull:true).snapshots();
    return new StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collectionGroup('calls')
            .where('isComplete', isEqualTo: true)
            .where('CallAssignedTo',isEqualTo: uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text("There is no expense");
          // print(snapshot.data.documents);
          // snapshot.data.documents.map((f) => print(f.documentID));
          return new ListView(children: getExpenseItems(snapshot, context));
        });
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    return snapshot.data.documents
        .map((doc) => new ListTile(
              title: new Text(doc.data["model"]),
              subtitle: new Text(doc.data["issue"].toString()),
              trailing: Icon(
                Icons.blur_on,
                color: cs(doc.data["isAssigned"].toString()),
              ),
              // onTap: () {
              //   DocumentSnapshot ds = doc;
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => SecondRoute(
              //                 ds: ds,
              //               )));
              // },
            ))
        .toList();
  }

  Color cs(String s) {
    if (s == "true")
      return Colors.green[500];
    else
      return Colors.red[500];
  }
}
