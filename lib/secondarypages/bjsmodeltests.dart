// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:bjsandbarexam/globals.dart';

class BJSModelTests extends StatefulWidget {
  @override
  _BJSModelTestsState createState() => _BJSModelTestsState();
}

class _BJSModelTestsState extends State<BJSModelTests> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  late User userdata;
  List courses = [];

  @override
  void initState() {
    super.initState();
    userdata = FirebaseAuth.instance.currentUser!;
    _getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('বিজেএস মডেল টেস্ট'),
        flexibleSpace: appBarStyle(),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: Text("বিজেএস মডেল টেস্ট"),
          ),
        ],
      ),
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
