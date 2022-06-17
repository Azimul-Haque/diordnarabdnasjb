// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field

import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/material.dart';
// import 'package:bjsandbarexam/globals.dart';

class TestBkashPage extends StatefulWidget {
  @override
  _TestBkashPageState createState() => _TestBkashPageState();
}

class _TestBkashPageState extends State<TestBkashPage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // print(userdata);
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://flutter.dev',
    );
  }
}
