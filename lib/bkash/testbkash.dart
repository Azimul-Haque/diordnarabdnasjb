// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, avoid_print, unused_field

import 'dart:async';
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
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // print(userdata);
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = true;
    return Scaffold(
      key: _scaffoldkey,
      // backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Flutter WebView example'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              initialUrl:
                  'https://shop.bkash.com/bjs--bar-exam01837409842/paymentlink',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                print('WebView is loading (progress : $progress%)');
              },
              javascriptChannels: <JavascriptChannel>{
                _toasterJavascriptChannel(context),
              },
              // navigationDelegate: (NavigationRequest request) {
              //   if (request.url.startsWith('https://www.youtube.com/')) {
              //     print('blocking navigation to $request}');
              //     return NavigationDecision.prevent;
              //   }
              //   print('allowing navigation to $request');
              //   return NavigationDecision.navigate;
              // },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
                setState(() {
                  isLoading = false;
                });
              },
              // gestureNavigationEnabled: true,
              // backgroundColor: const Color(0x00000000),
            ),
            isLoading ? LinearProgressIndicator() : Stack(),
          ],
        ),
      ),
      // SafeArea(
      //   child: Stack(
      //     children: <Widget>[
      //       WebView(
      //         initialUrl: this.url,
      //         onWebViewCreated: (WebViewController webViewController) {
      //           _controller.complete(webViewController);
      //         },
      //         onPageFinished: (finish) {
      //           setState(() {
      //             isLoading = false;
      //           });
      //         },
      //         javascriptMode: JavascriptMode.unrestricted,
      //       ),
      //       isLoading
      //           ? Container(
      //               child: LinearProgressIndicator(),
      //             )
      //           : Stack(),
      //     ],
      //   ),
      // ),
      // floatingActionButton: favoriteButton(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          return FloatingActionButton(
            onPressed: () async {
              String? url;
              if (controller.hasData) {
                url = await controller.data!.currentUrl();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    controller.hasData
                        ? 'Favorited $url'
                        : 'Unable to favorite',
                  ),
                ),
              );
            },
            child: const Icon(Icons.favorite),
          );
        });
  }
}
