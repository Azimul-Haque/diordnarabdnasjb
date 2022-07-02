// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SingleCourse extends StatefulWidget {
  final int courseid;
  SingleCourse(this.courseid);
  @override
  _SingleCourseState createState() => _SingleCourseState();
}

class _SingleCourseState extends State<SingleCourse> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  late User userdata;

  @override
  void initState() {
    super.initState();
    userdata = FirebaseAuth.instance.currentUser!;
    print(widget.courseid);
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
