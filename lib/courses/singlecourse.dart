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
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('কোর্স'),
        flexibleSpace: appBarStyle(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            exams.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    // physics: ClampingScrollPhysics(),
                    // shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemCount: exams.length,
                    itemBuilder: (context, index) {
                      return _scrollCard(exams[index]["name"].toString(),
                          exams[index]["exam_id"], screenwidth);
                    },
                  )
                : Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: (CircularProgressIndicator()),
                    ),
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
          "/api/getcourses/exams/" +
          _softToken +
          "/" +
          widget.courseid.toString();
      var response = await http.get(Uri.parse(serviceURL));
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (body["success"] == true) {
          // print("E PORJONTO");
          var data = body["exams"];
          setState(() {
            for (var i in data) {
              exams.add(i);
            }
          });
          print(exams.length);
        } else {}
      } else {
        // print(response.body);
      }
    } catch (_) {
      // print(_);
    }
  }

  Widget _scrollCard(String title, int courseid, double screenwidth) {
    return SizedBox(
      height: 110,
      width: screenwidth,
      child: Card(
        child: Stack(
          children: <Widget>[
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 9,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 8,
                  width: double.infinity,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kalpurush',
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  courseid.toString(),
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 13,
                    fontFamily: 'Kalpurush',
                    height: 1.1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SingleCourse(courseid),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        margin: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        elevation: 2,
        color: Colors.white,
      ),
    );
  }
}
