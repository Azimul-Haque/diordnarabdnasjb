// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field
import 'dart:convert';

import 'package:bjsandbarexam/bkash/testbkash.dart';
import 'package:bjsandbarexam/courses/courseexam.dart';
import 'package:bjsandbarexam/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class QuestionBank extends StatefulWidget {
  @override
  _QuestionBankState createState() => _QuestionBankState();
}

class _QuestionBankState extends State<QuestionBank> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late User userdata;
  bool _showCircle = true;

  @override
  void initState() {
    super.initState();
    userdata = FirebaseAuth.instance.currentUser!;
    // print(widget.courseid);
    if (questionbankexams.isEmpty) {
      _getCoursesData();
      Future.delayed(Duration(milliseconds: 2500), () {
        setState(() {
          _showCircle = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('প্রশ্ন ব্যাংক'),
        flexibleSpace: appBarStyle(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            questionbankexams.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: questionbankexams.length,
                    itemBuilder: (context, index) {
                      return _scrollCard(
                          questionbankexams[index]["name"].toString(),
                          questionbankexams[index]["exam_id"].toString(),
                          screenwidth);
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        _showCircle == true
                            ? CircularProgressIndicator()
                            : Text("কোন নতুন পরীক্ষা নেই!"),
                      ],
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
          "/api/getothercourses/exams/" +
          _softToken +
          "/5"; // 1 = Course, 2 = BJS MT, 3 = Bar MT, 4 = Free MT, 5 = QB
      var response = await http.get(Uri.parse(serviceURL));
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (body["success"] == true) {
          // print("E PORJONTO");
          var data = body["exams"];
          setState(() {
            for (var i in data) {
              questionbankexams.add(i);
            }
          });
          // print(questionbankexams.length);
        } else {}
      } else {
        // print(response.body);
      }
    } catch (_) {
      // print(_);
    }
  }

  Widget _scrollCard(String title, String courseexameid, double screenwidth) {
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
                  courseexameid.toString(),
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
                    testpaymentconditional == true
                        ? Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CourseExam(courseexameid),
                            ),
                          )
                        : Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TestBkashPage(),
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
