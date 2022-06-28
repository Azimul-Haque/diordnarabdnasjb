// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

import 'package:bjsandbarexam/bkash/testbkash.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String uid;
  late User userdata;
  // List courses = [];
  List courses = [];

  @override
  void initState() {
    super.initState();
    setState(() {});
    uid = FirebaseAuth.instance.currentUser!.uid;
    userdata = FirebaseAuth.instance.currentUser!;
    _getCourses();
  }

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
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
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // WIDGET FOR PACKAGES AND HIDDEN API MESSGES
            // WIDGET FOR PACKAGES AND HIDDEN API MESSGES
            // WIDGET FOR PACKAGES AND HIDDEN API MESSGES
            SizedBox(
              height: 125,
              width: double.infinity,
              child: ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(courses[index]["name"].toString()),
                  );
                },
              ),
              // ListView(
              //   padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              //   scrollDirection: Axis.horizontal,
              //   children: <Widget>[
              //     courses
              //     _scrollCard("১ টি", 'প্রস্তাবনা', screenwidth),
              //     _scrollCard("১১ টি", 'ভাগ', screenwidth),
              //     _scrollCard("১৫৩ টি", 'অনুচ্ছেদ', screenwidth),
              //     _scrollCard("৭ টি", 'তফসিল', screenwidth),
              //     _scrollCard("১৭ টি", 'সংশোধনী', screenwidth),
              //   ],
              // ),
            ),
            Divider(
              color: Colors.grey,
              height: 20,
            ),
            // ignore: avoid_unnecessary_containers
            Text(
              "পরীক্ষাসমূহ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      // width: screenwidth * .1,
                      padding: EdgeInsets.only(
                          top: 5, left: 0, bottom: 5, right: 2.5),
                      child: _homeCard("exambjs.png", "বিজিএস\nমডেল টেস্ট"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // width: screenwidth * .1,
                      padding: EdgeInsets.only(
                          top: 5, left: 0, bottom: 5, right: 2.5),
                      child: _homeCard("exambar.png", "বার\nমডেল টেস্ট"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // width: screenwidth * .1,
                      padding: EdgeInsets.only(
                          top: 5, left: 0, bottom: 5, right: 2.5),
                      child: _homeCard("examfree.png", "ফ্রি\nমডেল টেস্ট"),
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
                          top: 5, left: 0, bottom: 5, right: 2.5),
                      child: _homeCard("exambjs.png", "বিজিএস\nমডেল টেস্ট"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // width: screenwidth * .1,
                      padding: EdgeInsets.only(
                          top: 5, left: 0, bottom: 5, right: 2.5),
                      child: _homeCard("exambar.png", "বার\nমডেল টেস্ট"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // width: screenwidth * .1,
                      padding: EdgeInsets.only(
                          top: 5, left: 0, bottom: 5, right: 2.5),
                      child: _homeCard("examfree.png", "ফ্রি\nমডেল টেস্ট"),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 20,
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
                            "assets/images/exambjs.png",
                            height: 60,
                            width: 60,
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'বিজেএস\nমডেল টেস্ট',
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/exambar.png",
                            height: 60,
                            width: 60,
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'বার\nমডেল টেস্ট',
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: () => {},
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/examfree.png",
                            height: 60,
                            width: 60,
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'ফ্রি\nপরীক্ষা',
                            style: TextStyle(fontSize: 13),
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
            Divider(
              color: Colors.grey,
              height: 20,
            ),

            ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                elevation: MaterialStateProperty.all(1),
              ),
              child: Text(
                'Test Payment Gateway',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TestBkashPage(),
                  ),
                );
              },
            ),
            Center(
              child: Text(userdata.toString()),
            ),
            Center(
              child: Text(userdata.toString()),
            ),
            Center(
              child: Text(userdata.toString()),
            ),
          ],
        ),
      ),
    );
  }

  void _getCourses() async {
    try {
      String _softToken = "Rifat.Admin.2022";
      String serviceURL = "http://192.168.0.108:8000/api/getcourses/" +
          _softToken; // https://jsonplaceholder.typicode.com/posts
      var response = await http.get(Uri.parse(serviceURL));
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (body["success"] == true) {
          print("E PORJONTO");
          var data = json.decode(body["courses"]);
          setState(() {
            courses =
                List<Map<String, dynamic>>.from(jsonDecode(body["courses"]));
          });
          // print(courses.toString());
        } else {}
      } else {
        // print(response.body);
      }
    } catch (_) {
      // print(_);
    }
  }

  Widget _scrollCard(String title, String subtitle, double screenwidth) {
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
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kalpurush',
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  subtitle,
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
                  onTap: () {},
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

  Widget _homeCard(String image, String title) {
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => routename,
                  //   ),
                  // );
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
}
