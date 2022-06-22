import 'package:bjsandbarexam/login.dart';
import 'package:bjsandbarexam/profileedit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bjsandbarexam/dashboard.dart';
import 'package:bjsandbarexam/package.dart';
import 'package:bjsandbarexam/result.dart';
import 'package:bjsandbarexam/settings.dart';

import 'globals.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedItem = 0;
  final _pages = [
    const Dashboard(),
    PackagePage(),
    ResultPage(),
    SettingsPage()
  ];
  final _pageController = PageController();
  late User userdata;
  int? get currentIndex => null;

  @override
  void initState() {
    super.initState();
    userdata = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: commonAppBar(
          _selectedItem == 0
              ? 'বিজেএস ও বার এক্সাম'
              : _selectedItem == 1
                  ? 'প্যাকেজ'
                  : _selectedItem == 2
                      ? 'ফলাফল'
                      : _selectedItem == 3
                          ? 'সেটিংস'
                          : '',
          this.context),
      drawer: _homeDrawer(),
      body: PageView(
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _selectedItem = index;
          });
        },
        controller: _pageController,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(CupertinoIcons.checkmark_shield),
        onPressed: () {
          // Route route = MaterialPageRoute(builder: (context) => Addperiod());
          // Navigator.push(context, route);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        // shape: const CircularNotchedRectangle(),
        notchMargin: 7,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: screenwidth * .2,
                    onPressed: () {
                      setState(() {
                        _selectedItem = 0;
                        _pageController.animateToPage(_selectedItem,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.home,
                          // Icons.dashboard,
                          color: _selectedItem == 0
                              ? Colors.blue
                              : Colors.grey[600],
                        ),
                        Text(
                          'নীড়',
                          style: TextStyle(
                              color: _selectedItem == 0
                                  ? Colors.blue
                                  : Colors.grey[600],
                              fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: screenwidth * .2,
                    onPressed: () {
                      setState(() {
                        _selectedItem = 1;
                        _pageController.animateToPage(_selectedItem,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.list_bullet_indent,
                          // Icons.format_list_numbered_sharp,
                          color: _selectedItem == 1
                              ? Colors.blue
                              : Colors.grey[600],
                        ),
                        Text(
                          'প্যাকেজ',
                          style: TextStyle(
                              color: _selectedItem == 1
                                  ? Colors.blue
                                  : Colors.grey[600],
                              fontSize: 11),
                        ),
                      ],
                    ),
                  )
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: screenwidth * .2,
                    onPressed: () {
                      setState(() {
                        _selectedItem = 2;
                        _pageController.animateToPage(_selectedItem,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.calendar_today,
                          // Icons.calendar_today_outlined,
                          color: _selectedItem == 2
                              ? Colors.blue
                              : Colors.grey[600],
                        ),
                        Text(
                          'Calendar',
                          style: TextStyle(
                              color: _selectedItem == 2
                                  ? Colors.blue
                                  : Colors.grey[600],
                              fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: screenwidth * .2,
                    onPressed: () {
                      setState(() {
                        _selectedItem = 3;
                        _pageController.animateToPage(_selectedItem,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linear);
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.person,
                          // Icons.person,
                          color: _selectedItem == 3
                              ? Colors.blue
                              : Colors.grey[600],
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: _selectedItem == 3
                                  ? Colors.blue
                                  : Colors.grey[600],
                              fontSize: 11),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
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
                child: const CircleAvatar(
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
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
            Positioned(
              left: 30,
              bottom: 25,
              child: Text(userdata.phoneNumber ?? '',
                  style: const TextStyle(color: Colors.white70, fontSize: 13)),
            ),
            Positioned(
              right: 10,
              bottom: 30,
              child: IconButton(
                padding: const EdgeInsets.all(0.0),
                icon: const Icon(
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
            const Positioned(
              right: 3,
              bottom: 3,
              child: Text("Version: 1.0.0",
                  style: TextStyle(color: Colors.white60, fontSize: 11)),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: const Icon(
            Icons.home,
            color: Colors.black87,
          ),
          title: const Text("নীড়"),
          onTap: () {
            Navigator.pop(context); // this line closes the drawer
          },
        ),

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

        const Divider(
          color: Colors.black26,
        ),
        ListTile(
          leading: const Icon(
            Icons.logout,
            color: Colors.black87,
          ),
          title: const Text("লগ আউট"),
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
      offset: const Offset(
        3.0, // horizontal, move right 10
        3.0, // vertical, move down 10
      ),
    );
  }
}
