// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field
import 'dart:convert';

import 'package:bjsandbarexam/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
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
  List exams = [];

  @override
  void initState() {
    super.initState();
    userdata = FirebaseAuth.instance.currentUser!;
    // print(widget.courseid);
    _getCoursesData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('রেজাল্ট'),
        flexibleSpace: appBarStyle(),
      ),
      body: SingleChildScrollView(
        mainAxisSize: MainAxisSize.min,
        child: Column(
          children: [
            exams.isNotEmpty
                ? SizedBox(
                    height: 125,
                    width: double.infinity,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      // physics: ClampingScrollPhysics(),
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return _scrollCard(courses[index]["name"].toString(),
                            courses[index]["id"], screenwidth);
                      },
                    ))
                : SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: (CircularProgressIndicator()),
                  ),
          ],
        ),
      ),
    );
  }

  void _getCoursesData() async {
    try {
      String _softToken = "Rifat.Admin.2022";
      String serviceURL = baseAPIURL +
          "/api/getcourses/exams" +
          _softToken +
          "/" +
          widget.courseid.toString();
      var response = await http.get(Uri.parse(serviceURL));
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (body["success"] == true) {
          // print("E PORJONTO");
          var data = body["courses"];
          setState(() {
            for (var i in data) {
              exams.add(i);
            }
          });
          // print(courses);
        } else {}
      } else {
        // print(response.body);
      }
    } catch (_) {
      // print(_);
    }
  }
}
