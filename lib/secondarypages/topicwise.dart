// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field
import 'dart:convert';

import 'package:bjsandbarexam/bkash/testbkash.dart';
import 'package:bjsandbarexam/courses/courseexam.dart';
import 'package:bjsandbarexam/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class TopicWise extends StatefulWidget {
  @override
  _TopicWiseState createState() => _TopicWiseState();
}

class _TopicWiseState extends State<TopicWise> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late User userdata;
  List topics = [];
  bool _showCircle = true;

  @override
  void initState() {
    super.initState();
    userdata = FirebaseAuth.instance.currentUser!;
    // print(widget.courseid);
    _getTopicsData();
    Future.delayed(Duration(milliseconds: 2500), () {
      setState(() {
        _showCircle = false;
      });
    });
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
            topics.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: topics.length,
                    itemBuilder: (context, index) {
                      return
                          // _scrollCard(topics[index]["name"].toString(),
                          //     topics[index]["id"].toString(), screenwidth);
                          Card(
                              child: ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: Container(
                            child: Image.asset('law.png'),
                                fit: BoxFit.cover)),
                        title: Text(topics[index]["name"]),
                        subtitle: Text(topics[index]["name"]),
                        trailing: Icon(Icons.more_vert),
                        onTap: () {},
                      ));
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

  void _getTopicsData() async {
    try {
      String _softToken = "Rifat.Admin.2022";
      String serviceURL = baseAPIURL + "/api/gettopics/" + _softToken;
      var response = await http.get(Uri.parse(serviceURL));
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (body["success"] == true) {
          // print("E PORJONTO");
          var data = body["topics"];
          setState(() {
            for (var i in data) {
              topics.add(i);
            }
          });
          // print(topics.length);
        } else {}
      } else {
        // print(response.body);
      }
    } catch (_) {
      // print(_);
    }
  }

  Widget _scrollCard(String title, String topicId, double screenwidth) {
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
              ],
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // testpaymentconditional == true
                    //     ? Navigator.of(context).push(
                    //         MaterialPageRoute(
                    //           builder: (context) => CourseExam(topicId),
                    //         ),
                    //       )
                    //     : Navigator.of(context).push(
                    //         MaterialPageRoute(
                    //           builder: (context) => TestBkashPage(),
                    //         ),
                    //       );
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
