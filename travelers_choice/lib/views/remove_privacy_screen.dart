import 'dart:developer';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class RemovePrivacyScreen extends StatefulWidget {
  String linkdata;
  RemovePrivacyScreen({super.key, required this.linkdata});

  @override
  State<RemovePrivacyScreen> createState() => _RemovePrivacyScreenState();
}

class _RemovePrivacyScreenState extends State<RemovePrivacyScreen> {
  @override
  void initState() {
    super.initState();

    log('Link:${widget.linkdata}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(''),
      // ),
      body: WebView(
        initialUrl: widget.linkdata,
        // initialUrl: 'https://www.travellerschoice.ae/privacy-policy/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
