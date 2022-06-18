// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field

import 'package:bjsandbarexam/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('প্যাকেজ'),
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
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Page 1',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_online),
          label: 'Page 1',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.read_more),
          label: 'Page 2',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        )
      ],
      onTap: onTap,
      currentIndex: currentGTabIndex,
      // elevation: 50,
    );
  }

  onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
        break;
      case 1:
        // Notifications();
        //  _navigatorKey.currentState.pushReplacementNamed("Page 2");
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PackagePage(),
          ),
        );
        break;
      case 3:
        break;
    }
    setState(() {
      currentGTabIndex = tabIndex;
      pageController.animateToPage(currentGTabIndex,
          duration: Duration(milliseconds: 200), curve: Curves.linear);
    });
    print(currentGTabIndex);
  }
}
