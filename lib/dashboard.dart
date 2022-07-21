// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'dart:convert';
import 'package:bjsandbarexam/courses/singlecourse.dart';
import 'package:bjsandbarexam/globals.dart';
import 'package:bjsandbarexam/secondarypages/barmodeltests.dart';
import 'package:bjsandbarexam/secondarypages/bjsmodeltests.dart';
import 'package:bjsandbarexam/secondarypages/contact.dart';
import 'package:bjsandbarexam/secondarypages/freemodeltests.dart';
import 'package:bjsandbarexam/secondarypages/lecturematerials.dart';
import 'package:bjsandbarexam/secondarypages/questionbank.dart';
import 'package:bjsandbarexam/secondarypages/topicwise.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

// import 'package:bjsandbarexam/bkash/testbkash.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String uid;
  late User userdata;

  @override
  void initState() {
    super.initState();
    uid = FirebaseAuth.instance.currentUser!.uid;
    userdata = FirebaseAuth.instance.currentUser!;
    _getCourses();
  }

  @override
  Widget build(BuildContext context) {
    // double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 2,
      //   title: Text('বিজেএস ও বার এক্সাম'),
      //   flexibleSpace: appBarStyle(),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.logout),
      //       onPressed: () async {
      //         await FirebaseAuth.instance.signOut();
      //         Navigator.pushAndRemoveUntil(
      //             context,
      //             MaterialPageRoute(builder: (context) => LoginScreen()),
      //             (route) => false);
      //       },
      //     )
      //   ],
      // ),
      // drawer: _homeDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // WIDGET FOR PACKAGES AND HIDDEN API MESSGES
            // WIDGET FOR PACKAGES AND HIDDEN API MESSGES
            // WIDGET FOR PACKAGES AND HIDDEN API MESSGES
            testpaymentconditional == false
                ? Material(
                    color: Colors.green[50],
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'দুঃখিত! কোন প্যাকেজ কেনা নেই! প্যাকেজ কিনুন।',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            noticemessage == true
                ? Material(
                    color: Colors.yellow[50],
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'কাস্টম মেসেজ!',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            Text(
              "কোর্সসমূহ",
              style: TextStyle(fontSize: 16),
            ),

            courses.isNotEmpty
                ? SizedBox(
                    height: 125,
                    width: double.infinity,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                      // physics: ClampingScrollPhysics(),
                      // shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return _scrollCard(courses[index]["name"].toString(),
                            courses[index]["id"].toString(), screenwidth);
                      },
                    ))
                : SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: (CircularProgressIndicator()),
                  ),
            Divider(
              color: Colors.grey,
              height: 20,
            ),
            Text(
              "পরীক্ষা ও অধ্যয়ন",
              style: TextStyle(fontSize: 16),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      // width: screenwidth * .1,
                      padding: EdgeInsets.only(
                          top: 5, left: 0, bottom: 2.5, right: 2.5),
                      child: _homeCard(
                          "exambjs.png", "বিজিএস\nমডেল টেস্ট", BJSModelTests()),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // width: screenwidth * .1,
                      padding: EdgeInsets.only(
                          top: 5, left: 0, bottom: 2.5, right: 2.5),
                      child: _homeCard(
                          "exambar.png", "বার\nমডেল টেস্ট", BarModelTests()),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // width: screenwidth * .1,
                      padding: EdgeInsets.only(
                          top: 5, left: 0, bottom: 2.5, right: 2.5),
                      child: _homeCard(
                          "examfree.png", "ফ্রি\nমডেল টেস্ট", FreeModelTests()),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      // width: screenwidth * .1,
                      padding: EdgeInsets.only(
                          top: 5, left: 0, bottom: 2.5, right: 2.5),
                      child: _homeCard(
                          "questionbank.png", "প্রশ্ন\nব্যাংক", QuestionBank()),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // width: screenwidth * .1,
                      padding: EdgeInsets.only(
                          top: 5, left: 0, bottom: 2.5, right: 2.5),
                      child: _homeCard("subjectwise.png",
                          "বিষয়ভিত্তিক\nঅনুশীলন", TopicWise()),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // width: screenwidth * .1,
                      padding: EdgeInsets.only(
                          top: 5, left: 0, bottom: 2.5, right: 2.5),
                      child: _homeCard("lecturematerials.png",
                          "লেকচার\nম্যাটেরিয়াল", LectureMaterials()),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 20,
            ),
            Text(
              "অন্যান্য",
              style: TextStyle(fontSize: 16),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/other-write.png",
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'মতামত ও পরামর্শ\nলিখে পাঠান',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Contact(),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/other-facebook.png",
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'ফেসবুক\nকমিউনিটি',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: () => {},
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/other-sharing.png",
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'বন্ধুর সাথে\nশেয়ার করুন',
                            style:
                                TextStyle(fontSize: 13, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: () => {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scrollCard(String title, String courseid, double screenwidth) {
    return SizedBox(
      height: 110,
      width: screenwidth * .85,
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
                    fontSize: 15,
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

  Widget _homeCard(String image, String title, routename) {
    return Card(
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Image.asset("assets/images/" + image),
              ),
              Padding(
                  padding: EdgeInsets.all(2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ))
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => routename,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 2,
    );
  }

  void _getCourses() async {
    try {
      String _softToken = "Rifat.Admin.2022";
      String serviceURL = baseAPIURL +
          "/api/getcourses/" +
          _softToken +
          "/1"; // 1 = Course, 2 = BJS MT, 3 = Bar MT, 4 = Free MT
      var response = await http.get(Uri.parse(serviceURL));
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (body["success"] == true) {
          // print("E PORJONTO");
          var data = body["courses"];
          setState(() {
            for (var i in data) {
              courses.add(i);
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
