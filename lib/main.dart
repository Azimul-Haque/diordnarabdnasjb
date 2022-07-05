// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/material.dart';
import 'package:bjsandbarexam/extra/privacy.dart';
import 'package:bjsandbarexam/home.dart';
import 'package:bjsandbarexam/profileedit.dart';

import 'login.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Firebase.initializeApp();
//   runApp(MaterialApp(
//     home: MyApp(),
//     debugShowCheckedModeBanner: false,
//   ));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BJS & Bar Exam',
      theme: ThemeData(
        // primarySwatch: Colors.green,
        fontFamily: 'Kalpurush',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => InitializerWidget(),
        // '/profileedit': (context) => ProfileEditPage(),
        // '/favorites': (context) => FavoritesPage(),
        // '/qstnanswer': (context) => QuestionAnswerPage(),
        // '/constitution': (context) => ConstituionPage(),
        // '/history': (context) => HistoryPage(),
        // '/exam': (context) => ExamPage(),
        // '/ammendments': (context) => AmmendmentsPage(),
        '/privacy': (context) => PrivacyPage(),
      },
    );
  }
}

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  late FirebaseAuth _auth;

  // late User _user;

  String uid = '0';

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    uid = _auth.currentUser?.uid ?? '0';
    isLoading = false;
    configOneSignal();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : uid == '0'
            ? LoginScreen()
            : Home();
  }

  void configOneSignal() {
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId("681ffdc9-4dc1-49d7-a5d7-8bbeb85f5e77");

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt.
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      // print("Accepted permission: $accepted");
    });
  }
}
