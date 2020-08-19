import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:engineerproto1/style/colors.dart';
import 'package:engineerproto1/views/btn.dart';
import 'package:engineerproto1/views/cards.dart';
import 'package:engineerproto1/views/completed.dart';
import 'package:engineerproto1/views/request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainscrn(),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }

  Widget mainscrn() {
    String uid = "YyL4P1jO5jJOzUcpjZXn";

    // FirebaseAuth.instance.currentUser().then((val) => uid = val.uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('connect'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: bgColor,
      
      body: StreamBuilder(
          stream: Firestore.instance.collectionGroup('calls').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return CircularProgressIndicator();
            else {
              int _request = snapshot.data.documents
                  .where((doc) => doc['isComplete'] == false)
                  .where((doc) => doc['CallAssignedTo'] == uid)
                  .length;
              int _completed = snapshot.data.documents
                  .where((doc) => doc['isComplete'] == true)
                  .where((doc) => doc['CallAssignedTo'] == uid)
                  .length;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CallRequest()));
                      },
                      child: StatsCounter(
                        title: "Request",
                        count: _request,
                        size: 200.0,
                        titleColor: Colors.red,
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 3.0,
                      height: 0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CompletedCall()));
                          },
                          child: StatsCounter(
                            title: "Completed",
                            count: _completed,
                            size: 150.0,
                            titleColor: Colors.lightGreen,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
