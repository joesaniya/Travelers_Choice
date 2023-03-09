import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import '../../controllers/ticket_download_controller.dart';
import '/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class TicketDownload extends StatefulWidget {
  String? downloaddata;
  TicketDownload({super.key, this.downloaddata});

  @override
  _TicketDownloadState createState() => _TicketDownloadState();
}

class _TicketDownloadState extends State<TicketDownload> {
  late ThemeData theme;

  late TicketDownloadController controller;
  String? downloadurl;

  @override
  void initState() {
    super.initState();
    downloadurl = widget.downloaddata;
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.putOrFind(TicketDownloadController());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<TicketDownloadController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
            backgroundColor: const Color(0xfff5f5f5),
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: FxText.titleMedium(
                'Ticket Preview',
                fontWeight: 700,
              ),
              centerTitle: true,
              backgroundColor: const Color(0xfff5f5f5),
            ),
            // body: Padding(
            //   padding: FxSpacing.x(20),
            //   child: ListView(
            //     physics: const BouncingScrollPhysics(),
            //     children: [
            //       Lottie.asset('assets/lottie/confirmation.json',
            //           height: 300, width: 300),
            //       FxSpacing.height(20),
            //       FxText.titleLarge(
            //         'Booking Success!!',
            //         fontWeight: 700,
            //         textAlign: TextAlign.center,
            //       ),
            //       FxSpacing.height(8),
            //       FxText.labelLarge(
            //         'Enjoy Your \nVaccation, thanks for Booking',
            //         textAlign: TextAlign.center,
            //         xMuted: true,
            //       ),
            //       FxSpacing.height(24),
            //       FxButton.block(
            //         onPressed: () {
            //           controller.goBack();
            //         },
            //         borderRadiusAll: 4,
            //         elevation: 0,
            //         splashColor: const Color(0xff1529e8).withAlpha(30),
            //         backgroundColor: const Color(0xff1529e8),
            //         child: FxText.labelLarge(
            //           'Back To Home',
            //           color: theme.colorScheme.onPrimary,
            //           fontWeight: 600,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            body: const PDF().fromUrl(
              downloadurl!,
              placeholder: (double progress) =>
                  Center(child: Text('$progress %')),
              errorWidget: (dynamic error) =>
                  Center(child: Text(error.toString())),
            ),
          );
        });
  }
}
