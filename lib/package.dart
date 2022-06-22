// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:bjsandbarexam/globals.dart';

class PackagePage extends StatefulWidget {
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
    String html = '''
    <html>
    <head>
      <title>Your Website Title</title> 
    </head>
    <body>

      <!-- Load Facebook SDK for JavaScript -->
      <div id="fb-root"></div>
      <script async defer src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v3.2"></script>

      <!-- Your embedded video player code -->
      <div class="fb-video" data-href="https://www.facebook.com/10msjobs/videos/1657928677897688" data-width="500" data-show-text="false">
      </div>

    </body>
    </html>
     ''';
    return Scaffold(
      key: _scaffoldkey,
      // appBar: AppBar(
      //   title: Text('প্যাকেজ'),
      //   flexibleSpace: appBarStyle(),
      // ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: Text("Package Page"),
          ),
          SingleChildScrollView(
            child: HtmlWidget(
              html,
              // ignore: deprecated_member_use
              webView: true,
            ),
          ),
        ],
      ),
    );
  }
}
