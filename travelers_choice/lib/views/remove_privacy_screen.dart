import 'dart:developer';

import 'package:flutx/widgets/text/text.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class RemovePrivacyScreen extends StatefulWidget {
  String pageTitle;
  String linkdata;
  RemovePrivacyScreen(
      {super.key, required this.pageTitle, required this.linkdata});

  @override
  State<RemovePrivacyScreen> createState() => _RemovePrivacyScreenState();
}

class _RemovePrivacyScreenState extends State<RemovePrivacyScreen> {
  @override
  void initState() {
    super.initState();

    log('Link:${widget.linkdata}');
    log('Title:${widget.pageTitle}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(''),
      // ),
      backgroundColor: const Color(0xfff5f5f5),
      // backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xfff5f5f5),
        elevation: 0,
        centerTitle: true,
        title: FxText.titleMedium(
          widget.pageTitle,
          fontWeight: 600,
        ),
        // leading: InkWell(
        //   onTap: () {
        //     // controller.goBack();
        //     Navigator.pop(context);
        //   },
        //   child: const Icon(
        //     FeatherIcons.chevronLeft,
        //     size: 20,
        //   ),
        // ),
      ),
      body: widget.linkdata.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : WebView(
              initialUrl: widget.linkdata,
              // initialUrl: 'https://www.travellerschoice.ae/privacy-policy/',
              javascriptMode: JavascriptMode.unrestricted,
            ),
    );
  }
}
