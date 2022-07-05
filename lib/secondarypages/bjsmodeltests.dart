// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:bjsandbarexam/globals.dart';

class BJSModelTests extends StatefulWidget {
  @override
  _BJSModelTestsState createState() => _BJSModelTestsState();
}

class _BJSModelTestsState extends State<BJSModelTests> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  late User userdata;

  @override
  void initState() {
    super.initState();
    userdata = FirebaseAuth.instance.currentUser!;
    // print(userdata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      // appBar: AppBar(
      //   title: Text('রেজাল্ট'),
      //   flexibleSpace: appBarStyle(),
      // ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: Text("Result Page"),
          ),
        ],
      ),
    );
  }
}