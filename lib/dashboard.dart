// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:bjsandbarexam/login.dart';
import 'package:bjsandbarexam/profileedit.dart';
import 'package:bjsandbarexam/bkash/testbkash.dart';

import 'package:bjsandbarexam/globals.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String uid;
  late User userdata;

  @override
  void initState() {
    super.initState();
    setState(() {});
    uid = FirebaseAuth.instance.currentUser!.uid;
    userdata = FirebaseAuth.instance.currentUser!;
    _checkUid(userdata);
  }

  @override
  Widget build(BuildContext context) {
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
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    child: Text('Approve'),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: TextButton(
                    child: Text('Reject'),
                    onPressed: () => {},
                  ),
                ),
                Expanded(
                  child: TextButton(
                    child: Text('Need Revise'),
                    onPressed: () => {},
                  ),
                )
              ],
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
          ],
        ),
      ),
    );
  }

  void _checkUid(userdata) async {
    try {
      String _softToken = "Rifat.Admin.2022";
      String serviceURL = "http://192.168.0.108:8000/api/checkuid/" +
          _softToken +
          "/" +
          userdata.uid; // https://jsonplaceholder.typicode.com/posts
      var response = await http.get(Uri.parse(serviceURL));
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (body["success"] == true) {
          // print(body["success"]);
        } else {
          _postAddUser(userdata);
        }
      } else {
        // print(response.body);
      }
    } catch (_) {
      // print(_);
    }
  }

  _postAddUser(user) async {
    var data = {
      'uid': user.uid,
      'name': user.displayName ?? 'No Name',
      'mobile': user.phoneNumber,
      'softtoken': 'Rifat.Admin.2022',
    };
    // print(data);
    try {
      http.Response response = await http.post(
        Uri.parse('http://192.168.0.108:8000/api/adduser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if (body["success"] == true) {
          // print(body);
        }
      } else {
        // print(response.body);
      }
    } catch (_) {
      // print(_);
    }
  }
}
