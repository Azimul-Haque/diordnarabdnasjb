// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:bjsandbarexam/globals.dart';

class PackagePage extends StatefulWidget {
  final User user;
  PackagePage(this.user);
  @override
  _PackagePageState createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  late User userdata;

  @override
  void initState() {
    super.initState();
    userdata = FirebaseAuth.instance.currentUser!;

    // print(userdata);
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
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: Text("Package Page"),
          ),
        ],
      ),
    );
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      showAlertDialog(context, 'সার্ভারে পাঠানো হচ্ছে...');
      FocusScope.of(context).unfocus();
      _formKey.currentState!.save();
      try {
        userdata.updateDisplayName(_nameController.text).then(
              (value) => showSnackBarandPop(context, "হালনাগাদ হয়েছে!"),
            );
        _postUpdateUser(_nameController.text);
      } on FirebaseAuthException catch (e) {
        print('Failed with error code: ${e.code}');
        print(e.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text("Error! Try again."),
            // content: Text(e.message),
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  _postUpdateUser(name) async {
    var data = {
      'uid': userdata.uid,
      'name': name,
      'softtoken': 'Rifat.Admin.2022',
    };
    // print(data);
    try {
      http.Response response = await http.post(
        Uri.parse('http://192.168.0.108:8000/api/updateuser'),
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
