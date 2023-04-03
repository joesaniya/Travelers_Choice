import 'dart:developer';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart';
import 'package:dio/dio.dart';

import '../../card_widgets/customsnackbar.dart';

class PDFViewerPage extends StatefulWidget {
  final File file;
  String IdOrder;
  String IdActivity;

  PDFViewerPage(
      {Key? key,
      required this.file,
      required this.IdOrder,
      required this.IdActivity})
      : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;
  @override
  void initState() {
    super.initState();
    log('OrderId:${widget.IdOrder}');
    log('Activity Id:${widget.IdActivity}');
  }

  var dio = Dio();
  Future download2(
      Dio dio, String url, String savePath, BuildContext context) async {
    log('2download');
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Your Ticket was downloaded Sucessfully')));
      CustomSnackbar.show(
        context: context,
        message: 'Your Ticket was downloaded Sucessfully',
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );
      await raf.close();
    } catch (e) {
      print(e);
      log('Error:$e');
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(e.toString())));
      CustomSnackbar.show(
        context: context,
        message: e.toString(),
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    } else {
      log('downloaded');
      // ScaffoldMessenger.of(BuildContext context).showSnackBar(const SnackBar(
      //     content: Text('Your Ticket was downloaded Sucessfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: FxText.titleLarge(
          'Ticket Preview',
          fontWeight: 600,
        ),
        backgroundColor: Colors.transparent,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              FeatherIcons.chevronLeft,
              size: 20,
              color: Color(0xff1529e8),
            )),
        actions: [
          IconButton(
            icon: const Icon(
              MdiIcons.download,
              size: 20,
              color: Color(0xff1529e8),
            ),
            onPressed: () async {
              log("downloaded");

              String path =
                  await ExternalPath.getExternalStoragePublicDirectory(
                      ExternalPath.DIRECTORY_DOWNLOADS);

              //
              //String fullPath = tempDir.path + "/boo2.pdf'";
              String fullPath = "$path/${widget.IdActivity}.pdf";
              print('full path $fullPath');

              const ticketimage =
                  "https://secure.mytravellerschoice.com/api/v1/attractions/orders/6401e4f5913789806d34b998/ticket/6401e4f5913789806d34b999";
              // "https://secure.mytravellerschoice.com/api/v1/attractions/orders/${widget.IdOrder}/ticket/${widget.IdActivity}";

              download2(dio, ticketimage, fullPath, context);
              // downloadFile();
            },
          ),
        ],
      ),

      // appBar: AppBar(
      //   title: Text(name),
      //   // actions: pages >= 2
      //   //     ? [
      //   //         Center(child: Text(text)),
      //   //         IconButton(
      //   //           icon: Icon(Icons.chevron_left, size: 32),
      //   //           onPressed: () {
      //   //             final page = indexPage == 0 ? pages : indexPage - 1;
      //   //             controller.setPage(page);
      //   //           },
      //   //         ),
      //   //         IconButton(
      //   //           icon: Icon(Icons.chevron_right, size: 32),
      //   //           onPressed: () {
      //   //             final page = indexPage == pages - 1 ? 0 : indexPage + 1;
      //   //             controller.setPage(page);
      //   //           },
      //   //         ),
      //   //       ]
      //   //     : null,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(
      //         MdiIcons.download,
      //       ),
      //       onPressed: () {
      //         log("downloaded" as num);
      //       },
      //     ),
      //   ],
      // ),

      body: PDFView(
        filePath: widget.file.path,
        // autoSpacing: false,
        // swipeHorizontal: true,
        // pageSnap: false,
        // pageFling: false,
        onRender: (pages) => setState(() => this.pages = pages!),
        onViewCreated: (controller) =>
            setState(() => this.controller = controller),
        onPageChanged: (indexPage, _) =>
            setState(() => this.indexPage = indexPage!),
      ),
    );
  }
}
