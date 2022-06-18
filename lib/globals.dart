// ignore_for_file: prefer_const_literals_to_create_immutables

library bjsandbarexam.globals;

import 'dart:async';
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

Widget _bottomNavigationBar() {
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
    onTap: _onTap,
    currentIndex: _currentTabIndex,
    elevation: 0,
  );
}

_onTap(int tabIndex) {
  switch (tabIndex) {
    // case 0:
    //   Notifications();
    //   // _navigatorKey.currentState.pushReplacementNamed("Page 1");
    //   break;
    // case 1:
    //   Notifications();
    //   //  _navigatorKey.currentState.pushReplacementNamed("Page 2");
    //   break;
    // case 2:
    //   Notifications();
    //   // _navigatorKey.currentState.pushReplacementNamed("Profile");
    //   break;
  }
  _currentTabIndex = tabIndex;
}
