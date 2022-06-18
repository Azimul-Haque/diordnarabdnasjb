// ignore_for_file: prefer_const_literals_to_create_immutables

library bjsandbarexam.globals;

import 'dart:async';
import 'dart:js';
import 'package:bjsandbarexam/home.dart';
import 'package:bjsandbarexam/profileedit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// appBarStyle() {
//   return Ink(
//     decoration: new BoxDecoration(
//       gradient: new LinearGradient(
//         colors: [
//           Colors.red[800],
//           Colors.red[600],
//         ],
//         begin: const FractionalOffset(0.0, 0.0),
//         end: const FractionalOffset(1.0, 0.0),
//         stops: [0.0, 1.0],
//         tileMode: TileMode.clamp,
//       ),
//     ),
//   );
// }

showAlertDialog(BuildContext context, String message) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(child: Text(message)),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const CircularProgressIndicator(),
      ],
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// Future<void> share(textorurl, subject) async {
//   await Share.share(
//     subject + ': ' + textorurl,
//     subject: subject,
//   );
// }

int currentGTabIndex = 0;

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
      if (currentGTabIndex == tabIndex) {
      } else {
        Navigator.popUntil(context, (route) => false);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      }
      break;
    // case 1:
    //   Notifications();
    //   //  _navigatorKey.currentState.pushReplacementNamed("Page 2");
    //   break;
    case 2:
      User userdata;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProfileEditPage(userdata),
        ),
      );
      break;
  }
  currentGTabIndex = tabIndex;
  // print(currentGTabIndex);
}

showSimpleSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
    ),
  );
}

showSnackBarandPop(BuildContext context, String message) {
  Timer(const Duration(seconds: 1), () {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
    // Navigator.of(context).pop();
    // IT NAVIGATES TO HOME PAGE!!!
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  });
}

appBarStyle() {
  return Ink(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lightBlue[600]!, Colors.lightBlue[200]!],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 0.0),
        stops: [0.0, 1.0],
        tileMode: TileMode.clamp,
      ),
    ),
  );
}
