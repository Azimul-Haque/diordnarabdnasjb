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
    // return Scaffold(
    //   appBar: AppBar(
    //     elevation: 2,
    //     title: Text('বিজেএস ও বার এক্সাম'),
    //     flexibleSpace: appBarStyle(),
    //     actions: [
    //       IconButton(
    //         icon: Icon(Icons.logout),
    //         onPressed: () async {
    //           await FirebaseAuth.instance.signOut();
    //           Navigator.pushAndRemoveUntil(
    //               context,
    //               MaterialPageRoute(builder: (context) => LoginScreen()),
    //               (route) => false);
    //         },
    //       )
    //     ],
    //   ),
      drawer: _homeDrawer(),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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
    );
  }

  Widget _homeDrawer() {
    return Drawer(
        child: ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.asset("assets/images/drawer.jpg"),
            Positioned(
              left: 30,
              bottom: 70,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  boxShadow: [_boxShadow1()],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text("A", style: TextStyle(fontSize: 25)),
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(50.0),
                //   child: Image.asset("assets/images/withouttext.png"),
                // ),
              ),
            ),
            Positioned(
              left: 30,
              bottom: 40,
              child: Text(
                  userdata.displayName.toString() == 'null' ||
                          userdata.displayName == null
                      ? 'No Name'
                      : userdata.displayName.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
            Positioned(
              left: 30,
              bottom: 25,
              child: Text(userdata.phoneNumber ?? '',
                  style: TextStyle(color: Colors.white70, fontSize: 13)),
            ),
            Positioned(
              right: 10,
              bottom: 30,
              child: IconButton(
                padding: EdgeInsets.all(0.0),
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.popUntil(context, (route) => false);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileEditPage(userdata),
                    ),
                  );
                },
              ),
            ),
            Positioned(
              right: 3,
              bottom: 3,
              child: Text("Version: 1.0.0",
                  style: TextStyle(color: Colors.white60, fontSize: 11)),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.black87,
          ),
          title: Text("নীড়"),
          onTap: () {
            Navigator.pop(context); // this line closes the drawer
          },
        ),
        // ListTile(
        //   leading: Icon(
        //     Icons.add_to_photos,
        //     color: Colors.black87,
        //   ),
        //   title: Text("প্রশ্ন যোগ করুন"),
        //   onTap: () {
        //     Navigator.pop(context);
        //     // Route route = MaterialPageRoute(builder: (context) => NotificationPage(["1", "2"]));
        //     // Navigator.push(context, route);
        //     Navigator.pushNamed(context, '/formpage');
        //   },
        // ),
        // ListTile(
        //   leading: Icon(
        //     Icons.favorite,
        //     color: Colors.black87,
        //   ),
        //   title: Text("প্রিয় তালিকা"),
        //   onTap: () {
        //     Navigator.pop(context);
        //     // Route route = MaterialPageRoute(builder: (context) => NotificationPage(["1", "2"]));
        //     // Navigator.push(context, route);
        //     Navigator.pushNamed(context, '/favorites');
        //   },
        // ),
        // Divider(
        //   color: Colors.black26,
        // ),
        // ListTile(
        //   leading: Icon(
        //     Icons.settings,
        //     color: Colors.black87,
        //   ),
        //   title: Text("সেটিংস"),
        //   onTap: () {
        //     Navigator.pop(context);
        //     Route route =
        //         MaterialPageRoute(builder: (context) => SettingsPage());
        //     Navigator.push(context, route).then((value) {
        //       setState(() {
        //         userName = value[0];
        //         userDesig = value[1];
        //         userOrg = value[2];
        //       });
        //     });
        //   },
        // ),
        // ListTile(
        //   leading: Icon(
        //     Icons.mail,
        //     color: Colors.black87,
        //   ),
        //   title: Text("মতামত জানান"),
        //   onTap: () {
        //     Navigator.pop(context);
        //     Route route =
        //         MaterialPageRoute(builder: (context) => ContactPage(userName));
        //     Navigator.push(context, route);
        //   },
        // ),
        // ListTile(
        //   leading: Icon(
        //     Icons.info,
        //     color: Colors.black87,
        //   ),
        //   title: Text("আমাদের সম্পর্কে"),
        //   onTap: () {
        //     Navigator.pop(context);
        //     _showDialog();
        //   },
        // ),
        // ListTile(
        //   leading: Icon(
        //     Icons.share,
        //     color: Colors.black87,
        //   ),
        //   title: Text("শেয়ার করুন"),
        //   onTap: () {
        //     Navigator.pop(context);
        //     share();
        //     // final RenderBox box = context.findRenderObject();
        //     // Share.share("https://orbachinujbuk.com/",
        //     //   subject: "অ্যাপটি শেয়ার করুন!",
        //     //   sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
        //     // );
        //     // Share.share('check out my website https://example.com', subject: 'Look what I made!');
        //   },
        // ),
        Divider(
          color: Colors.black26,
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.black87,
          ),
          title: Text("লগ আউট"),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false);
          },
        ),
      ],
    ));
  }

  BoxShadow _boxShadow1() {
    return BoxShadow(
      color: Colors.grey[700]!,
      blurRadius: 10.0, // has the effect of softening the shadow
      spreadRadius: 1.0, // has the effect of extending the shadow
      offset: Offset(
        3.0, // horizontal, move right 10
        3.0, // vertical, move down 10
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
