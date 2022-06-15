// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bjsandbarexam/globals.dart';

class ProfileEditPage extends StatefulWidget {
  final User user;
  ProfileEditPage(this.user);
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // print(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('ব্যবহারকারীর তথ্য'),
        flexibleSpace: appBarStyle(),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                'OTP ভেরিফিকেশন',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
