// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field
import 'dart:convert';

import 'package:bjsandbarexam/bkash/testbkash.dart';
import 'package:bjsandbarexam/courses/courseexam.dart';
import 'package:bjsandbarexam/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PackagePage extends StatefulWidget {
  @override
  _PackagePageState createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late User userdata;
  bool _showCircle = true;

  @override
  void initState() {
    super.initState();
    userdata = FirebaseAuth.instance.currentUser!;
    // print(widget.courseid);
    _getPackagesData();
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            packages.isNotEmpty
                ? ListView.builder(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: packages.length,
                    itemBuilder: (context, index) {
                      return _scrollCard(packages[index], screenwidth);
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
                            : Text("প্যাকেজ পাওয়া যায়নি!"),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _getPackagesData() async {
    if (packages.isEmpty) {
      try {
        String _softToken = "Rifat.Admin.2022";
        String serviceURL = baseAPIURL + "/api/getpackages/" + _softToken;
        var response = await http.get(Uri.parse(serviceURL));
        if (response.statusCode == 200) {
          var body = json.decode(response.body);
          if (body["success"] == true) {
            // print("E PORJONTO");
            var data = body["packages"];
            setState(() {
              for (var i in data) {
                packages.add(i);
              }
            });
            // print(packages.length);
          } else {}
        } else {
          // print(response.body);
        }
      } catch (_) {
        // print(_);
      }
    }
  }

  Widget _scrollCard(package, double screenwidth) {
    return SizedBox(
      // height: 110,
      width: screenwidth,
      child: Card(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                  child: Text(
                    package['name'].toString() +
                        " (" +
                        package['duration'] +
                        ")",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kalpurush',
                      height: 1,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 15),
                  child: Text(
                    package['tagline'].toString(),
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 13,
                      fontFamily: 'Kalpurush',
                      height: 1,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        '৳' + banglaNumber(package['price'].toString()),
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kalpurush',
                          height: 1,
                        ),
                        // textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '৳' + banglaNumber(package['strike_price'].toString()),
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                            fontFamily: 'Kalpurush',
                            height: 1,
                            decoration: TextDecoration.lineThrough),
                        // textAlign: TextAlign.center,
                      ),
                    ],
                  ),
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
                    //           builder: (context) => CourseExam(packageId),
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
        elevation: package['suggested'] == 1 ? 5 : 2,
        color: package['suggested'] == 1 ? Colors.blueAccent : Colors.white,
      ),
    );
  }
}
