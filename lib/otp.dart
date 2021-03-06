// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bjsandbarexam/globals.dart';
import 'package:bjsandbarexam/home.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(50.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    const borderColor = Color.fromRGBO(30, 60, 87, 1);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 24,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
        // backgroundBlendMode: BlendMode.clear,
      ),
    );
    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 1.5,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    return Scaffold(
      key: _scaffoldkey,
      // appBar: AppBar(
      //   title: Text('OTP ??????????????????????????????'),
      // ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(top: 70),
            child: Center(
              child: Text(
                'OTP ??????????????????????????????',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Center(
              child: Text(
                '+88${widget.phone} ?????????????????? ?????????????????? ?????? ????????????????????? ??????????????? ??????????????? ????????? ??????????????????',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 35, left: 35),
            child: Pinput(
              length: 6,
              focusedPinTheme: defaultPinTheme,
              pinAnimationType: PinAnimationType.slide,
              focusNode: _pinPutFocusNode,
              cursor: cursor,
              showCursor: true,
              onTap: () {
                // print('Tap: Tapping...');
              },
              onCompleted: (pin) async {
                // print('Working...');
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      if (value.user!.displayName == null) {
                        // post the user data through api
                        _postAddUser(value.user);
                      }
                      showSimpleSnackBar(
                          context, '????????????????????? ???????????? ????????????????????? ???????????????!');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                          (route) => false);
                    }
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  // _scaffoldkey.currentState!
                  //     .showSnackBar(SnackBar(content: Text('invalid OTP')));
                  showSimpleSnackBar(context, '???????????? ??????! ???????????? ?????????????????? ???????????????');
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     behavior: SnackBarBehavior.floating,
                  //     content: Text('invalid OTP'),
                  //   ),
                  // );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+88${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              if (value.user!.displayName == null) {
                // post the user data through api
                _postAddUser(value.user);
              }
              showSimpleSnackBar(context, '????????????????????? ???????????? ????????????????????? ???????????????!');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
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
          print(body);
        }
      } else {
        print(response.body);
      }
    } catch (_) {
      // catch e kichu korini ekhono...
      print(_);
    }
  }
}
