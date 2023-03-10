import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/all_bookings.dart';
import '../loading_effect.dart';
import '../models/product.dart';
import '../services/app_constants.dart';
import '../services/attraction_Service.dart';
import '../theme/app_theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:external_path/external_path.dart';
import '../controllers/pdf_api.dart';

class AllBookings extends StatefulWidget {
  const AllBookings({Key? key}) : super(key: key);

  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings>
    with TickerProviderStateMixin {
  late AllBookingController controller;
  late ThemeData theme, theme1;
  @override
  void initState() {
    super.initState();
    getPermission();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        controller.token =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN)!;
        log("auth token ${controller.token!}");
      });
      fetchData();
      // AttractionService().getAttractionOrders(context,);
    });
    controller = FxControllerStore.put(AllBookingController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  bool isLoading = true;
  fetchData() {
    log('fetcdata');
    Future.delayed(Duration.zero, () async {
      await getOrder(context).then((value) {
        if (value) {
          isLoading = false;
          setState(() {});
        }
      });
    });
  }

  bool isOrdersLoading = true;
  Future getOrder(context) async {
    isOrdersLoading = true;
    try {
      var data = await AttractionService()
          .getAttractionOrders(controller.token!, context);
      if (data != null) {
        setState(() {});
        // countryList.add(data);
        controller.orders = data;

        isOrdersLoading = false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  final imgUrl =
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

  var dio = Dio();

  void getPermission() async {
    print("getPermission");
    await Permission.storage.request();
    // await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    // Map<PermissionGroup, PermissionStatus> permissions =
    //     await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  Future download2(Dio dio, String url, String savePath) async {
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Your Ticket was downloaded Sucessfully')));
      await raf.close();
    } catch (e) {
      print(e);
      log('Error:$e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Your Ticket was downloaded Sucessfully')));
    }
  }

//todo
  var imageUrl =
      "https://secure.mytravellerschoice.com/api/v1/attractions/orders/6401e4f5913789806d34b998/ticket/6401e4f5913789806d34b999";
  // "https://www.itl.cat/pngfile/big/10-100326_desktop-wallpaper-hd-full-screen-free-download-full.jpg";
  bool downloading = true;
  String downloadingStr = "No data";
  String savePath = "";

  Future downloadFile() async {
    log('download');
    try {
      Dio dio = Dio();
      String fileName = 'Jensy';
      // String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);

      savePath = await getFilePath(fileName);
      await dio.download(imageUrl, savePath, onReceiveProgress: (rec, total) {
        setState(() {
          downloading = true;
          // download = (rec / total) * 100;
          downloadingStr = "Downloading Image : $rec";
        });
      });
      setState(() {
        downloading = false;
        downloadingStr = "Completed";
      });
      log('finding Path');
      log('Save Path:$savePath');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  }

  Widget attractionList() {
    if (controller.orders == null) {
      log('loading..');
      return const Text("Loading....!");
    } else {
      if (controller.orders!.result!.data!.isEmpty) {
        log('You have no attractions');
        return const Text("You have no attractions");
      }
      return ListView.builder(
        itemCount: controller.orders!.result!.totalOrders,
        itemBuilder: (BuildContext context, int index) {
          var date = controller.orders!.result!.data![index].activities!.date;
          var newDate = date!.toLocal().toString().substring(0, 10);
          print(newDate);
          return FxContainer(
            margin: FxSpacing.bottom(20),
            borderRadiusAll: 4,
            color: Colors.white,
            paddingAll: 12,
            child: Column(
              children: [
                Row(
                  children: [
                    FxContainer(
                      paddingAll: 0,
                      borderRadiusAll: 4,
                      height: 100,
                      width: 100,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: CachedNetworkImage(
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                          ),
                        ),
                        imageUrl:
                            'https://a.walletbot.online${controller.orders!.result!.data![index].attraction!.images!.first}',
                      ),
                    ),
                    FxSpacing.width(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FxText.titleMedium(
                            controller.orders!.result!.data![index].activities!
                                .activity!.name!,
                            fontWeight: 700,
                          ),
                          FxSpacing.height(8),
                          FxText.bodyMedium(
                            '${controller.orders!.result!.data![index].totalAmount.toString()} AED',
                            fontWeight: 700,
                          ),
                          FxSpacing.height(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FxText.bodyMedium(
                                'Pax',
                                fontWeight: 600,
                              ),
                              Expanded(child: Container()),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  FxContainer(
                                    padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                                    color:
                                        const Color(0xff1529e8).withAlpha(40),
                                    child: Row(
                                      children: [
                                        FxText.bodyMedium(
                                            controller
                                                .orders!
                                                .result!
                                                .data![index]
                                                .activities!
                                                .adultsCount!
                                                .toString(),
                                            color: const Color(0xff1529e8),
                                            // color: customTheme.groceryPrimary,
                                            fontWeight: 500,
                                            letterSpacing: -0.2),
                                        FxSpacing.width(4),
                                        FxText.bodyMedium('Adult',
                                            color: const Color(0xff1529e8),
                                            // color: customTheme.groceryPrimary,
                                            fontWeight: 500,
                                            letterSpacing: -0.2),
                                      ],
                                    ),
                                  ),
                                  FxSpacing.width(10),
                                  FxContainer(
                                    padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                                    color:
                                        const Color(0xff1529e8).withAlpha(40),
                                    child: Row(
                                      children: [
                                        FxText.bodyMedium(
                                            controller
                                                .orders!
                                                .result!
                                                .data![index]
                                                .activities!
                                                .childrenCount!
                                                .toString(),
                                            color: const Color(0xff1529e8),
                                            // color: customTheme.groceryPrimary,
                                            fontWeight: 500,
                                            letterSpacing: -0.2),
                                        FxSpacing.width(4),
                                        FxText.bodyMedium('child',
                                            color: const Color(0xff1529e8),
                                            // color: customTheme.groceryPrimary,
                                            fontWeight: 500,
                                            letterSpacing: -0.2),
                                      ],
                                    ),
                                  ),
                                  FxSpacing.width(10),
                                  FxContainer(
                                    padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                                    color:
                                        const Color(0xff1529e8).withAlpha(40),
                                    child: Row(
                                      children: [
                                        FxText.bodyMedium(
                                            controller
                                                .orders!
                                                .result!
                                                .data![index]
                                                .activities!
                                                .infantCount
                                                .toString(),
                                            color: const Color(0xff1529e8),
                                            // color: customTheme.groceryPrimary,
                                            fontWeight: 500,
                                            letterSpacing: -0.2),
                                        FxSpacing.width(4),
                                        FxText.bodyMedium('Infant',
                                            color: const Color(0xff1529e8),
                                            // color: customTheme.groceryPrimary,
                                            fontWeight: 500,
                                            letterSpacing: -0.2),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          FxText.bodyMedium(
                            "Date: $newDate",
                            fontWeight: 700,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
          body: Padding(
        padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
        child: LoadingEffect.getReviewLoadingScreen(
          context,
          // theme, theme.colorScheme
        ),
      ));
    } else {
      return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: FxText.titleLarge(
            'All Bookings',
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
        ),
        body: controller.token == null
            ? const Text('Login or signup')
            : controller.orders!.result == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        // Lottie.asset('assets/lottie/confirmation.json',
                        //     height: 300, width: 300),
                        Text('No Order History!!',
                            style: TextStyle(
                                fontFamily: 'inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 16))
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: FxSpacing.fromLTRB(
                        20,
                        // FxSpacing.safeAreaTop(context) + 20,
                        // FxSpacing.safeAreaTop(context) + 5,
                        0,
                        20,
                        0),
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (BuildContext context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: controller.orders!.result!.totalOrders!.toInt(),
                    itemBuilder: (BuildContext context, int index) {
                      var date = controller
                          .orders!.result!.data![index].activities!.date;
                      String createdatae = controller
                          .orders!.result!.data![index].createdAt
                          .toString();
                      log('Created Date:$createdatae');
                      DateTime dateTime = DateTime.parse(createdatae);
                      String formattedDatecreate =
                          "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
                      log('Format:$formattedDatecreate');
                      var newDate = date!.toLocal().toString().substring(0, 10);
                      log('New Date:$newDate');
                      return Container(
                        // height: 212,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        // margin: const EdgeInsets.only(
                        //   bottom: 20,
                        // ),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(children: [
                                          FxText.bodyLarge(
                                            'Status:',

                                            // textAlign: TextAlign.left,
                                            letterSpacing: 0,
                                            fontWeight: 600,
                                          ),
                                          FxSpacing.width(10),
                                          FxText.bodyLarge(
                                            controller.orders!.result!
                                                .data![index].orderStatus
                                                .toString(),

                                            color: controller
                                                        .orders!
                                                        .result!
                                                        .data![index]
                                                        .orderStatus ==
                                                    'confirmed'
                                                ? Colors.green
                                                : controller
                                                            .orders!
                                                            .result!
                                                            .data![index]
                                                            .orderStatus ==
                                                        'pending'
                                                    ? Colors.orange
                                                    : Colors.red,
                                            fontWeight: 600,
                                            // color: const Color(0xff1529e8),
                                          )
                                        ]),
                                      ),
                                      Container(
                                        child: Row(children: [
                                          FxText.bodyLarge(
                                            'Date:',

                                            // textAlign: TextAlign.left,
                                            letterSpacing: 0,
                                            fontWeight: 600,
                                          ),
                                          FxSpacing.width(10),
                                          FxText.bodyLarge(
                                            // formattedDatecreate,
                                            newDate,
                                            fontWeight: 600,
                                            color: const Color(0xff1529e8),
                                          )
                                        ]),
                                      )
                                    ],
                                  ),
                                  //controller.updateTours(widget.excursions[i])
                                  FxSpacing.height(10),
                                  // orders!.result!.data!.contains(
                                  //   orders!.result!.data![index]
                                  //       .referenceNumber
                                  //       .toString(),
                                  // )
                                  //     ? const Text('hh')
                                  //     : const SizedBox(),
                                  FxDashedDivider(
                                    dashSpace: 4,
                                    dashWidth: 8,
                                    color: theme.colorScheme.onBackground
                                        .withAlpha(180),
                                    height: 1.2,
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff919EB0),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1)),
                                  child: Row(
                                    children: [
                                      FxSpacing.width(10),
                                      FxText.bodyLarge('Ref No:',

                                          // textAlign: TextAlign.left,
                                          letterSpacing: 0,
                                          fontWeight: 600,
                                          color: Colors.white),
                                      FxSpacing.width(10),
                                      FxText.bodyLarge(
                                        controller.orders!.result!.data![index]
                                            .referenceNumber
                                            .toString(),
                                        color: Colors.white,

                                        fontWeight: 600,
                                        // color: const Color(0xff1529e8),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(child: Container())
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: CachedNetworkImage(
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Center(
                                        child: CircularProgressIndicator(
                                          value: progress.progress,
                                        ),
                                      ),
                                      imageUrl:
                                          'https://a.walletbot.online${controller.orders!.result!.data![index].attraction!.images!.first}',
                                    ),
                                  ),
                                  FxSpacing.width(20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Hero(
                                          tag:
                                              "product_${controller.orders!.result!.data![index].activities!.activity!.name!}",
                                          // child: FxText.bodyLarge(
                                          //   product.name,
                                          //   // fontWeight: 500,
                                          // ),
                                          child: FxText.bodyLarge(
                                            controller
                                                .orders!
                                                .result!
                                                .data![index]
                                                .activities!
                                                .activity!
                                                .name!,
                                            fontWeight: 800,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                        FxSpacing.height(4),
                                        Container(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  FxText.bodySmall(
                                                    'Adult:',
                                                    fontWeight: 900,
                                                    color: Colors.black,
                                                  ),
                                                  FxSpacing.width(10),
                                                  FxText.bodySmall(
                                                    controller
                                                        .orders!
                                                        .result!
                                                        .data![index]
                                                        .activities!
                                                        .adultsCount
                                                        .toString(),
                                                    fontWeight: 600,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  FxText.bodySmall(
                                                    'Child:',
                                                    fontWeight: 900,
                                                    color: Colors.black,
                                                  ),
                                                  FxSpacing.width(10),
                                                  FxText.bodySmall(
                                                    controller
                                                        .orders!
                                                        .result!
                                                        .data![index]
                                                        .activities!
                                                        .childrenCount
                                                        .toString(),
                                                    fontWeight: 600,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  FxText.bodySmall(
                                                    'Infant:',
                                                    fontWeight: 900,
                                                    color: Colors.black,
                                                  ),
                                                  FxSpacing.width(10),
                                                  FxText.bodySmall(
                                                    controller
                                                        .orders!
                                                        .result!
                                                        .data![index]
                                                        .activities!
                                                        .infantCount
                                                        .toString(),
                                                    fontWeight: 600,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        FxSpacing.height(4),
                                        Hero(
                                          tag:
                                              "${controller.orders!.result!.data![index].activities!.activity!.name!}_${controller.orders!.result!.data![index].totalAmount}",
                                          child: FxText.labelLarge(
                                            "${controller.orders!.result!.data![index].totalAmount} AED",
                                            // "\$" + product.price.toString() + "/hour",
                                            fontWeight: 700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //personal details
                            FxContainer(
                              margin: const EdgeInsets.all(8),
                              padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                              color: const Color(0xfff5f5f5),
                              // color: const Color(0xff1529e8).withAlpha(40),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          FxText.bodySmall(
                                            'Name:',
                                            fontWeight: 900,
                                            color: Colors.black,
                                          ),
                                          FxSpacing.width(10),
                                          FxText.bodySmall(
                                            controller.orders!.result!
                                                .data![index].name
                                                .toString(),
                                            fontWeight: 600,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                      // FxSpacing.width(20),
                                      //3
                                      Expanded(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FxText.bodySmall(
                                            'Email:',
                                            fontWeight: 900,
                                            color: Colors.black,
                                          ),
                                          FxSpacing.width(10),
                                          Expanded(
                                            child: FxText.bodySmall(
                                              controller.orders!.result!
                                                  .data![index].email
                                                  .toString(),
                                              fontWeight: 600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                  //2
                                  FxSpacing.height(10),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          FxText.bodySmall(
                                            'Country:',
                                            fontWeight: 900,
                                            color: Colors.black,
                                          ),
                                          FxSpacing.width(10),
                                          FxText.bodySmall(
                                            controller
                                                .orders!
                                                .result!
                                                .data![index]
                                                .country!
                                                .countryName
                                                .toString(),
                                            fontWeight: 600,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                      //3
                                      Expanded(
                                          child: Row(
                                        children: [
                                          FxText.bodySmall(
                                            'Phone:',
                                            fontWeight: 900,
                                            color: Colors.black,
                                          ),
                                          FxSpacing.width(10),
                                          FxText.bodySmall(
                                            controller.orders!.result!
                                                .data![index].phoneNumber
                                                .toString(),
                                            fontWeight: 600,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ))
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            //details
                            controller.orders!.result!.data![index]
                                        .orderStatus ==
                                    'confirmed'
                                ? Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FxContainer(
                                        onTap: () async {
                                          log('preview Screen clicked');
                                          log('id:${controller.orders!.result!.data![index].id}');
                                          String Idorder = controller
                                              .orders!.result!.data![index].id
                                              .toString();
                                          String idactivity = controller
                                              .orders!
                                              .result!
                                              .data![index]
                                              .activities!
                                              .id
                                              .toString();

                                          final url =
                                              'https://secure.mytravellerschoice.com/api/v1/attractions/orders/$Idorder/ticket/$idactivity';
                                          final file =
                                              await PDFApi.loadNetwork(url);
                                          controller.openPDF(context, file,
                                              Idorder, idactivity);
                                        },
                                        padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                                        color: const Color(0xff1529e8)
                                            .withAlpha(40),
                                        child: Row(
                                          // mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            FxText.bodyMedium("View",
                                                color: const Color(0xff1529e8),
                                                fontWeight: 500,
                                                letterSpacing: -0.2),
                                            FxSpacing.width(5),
                                            const Icon(
                                              MdiIcons.eye,
                                              size: 14,
                                              color: Color(0xff1529e8),
                                            )
                                          ],
                                        ),
                                      ),
                                      FxSpacing.width(10),
                                      FxContainer(
                                        // onTap: () async {
                                        //   log('download clicked');
                                        //   log('Order Id:${controller.orders!.result!.data![index].id}');
                                        //   log('Activity Id:${controller.orders!.result!.data![index].activities!.id}');
                                        //   // const url =
                                        //   //     'https://secure.mytravellerschoice.com/api/v1/attractions/orders/6401e4f5913789806d34b998/ticket/6401e4f5913789806d34b999';
                                        //   // final file = await PDFApi.loadNetwork(url);
                                        //   // controller.openPDF(context, file);
                                        //   // controller.downloadBtn(
                                        //   //     controller
                                        //   //         .orders!.result!.data![index].id
                                        //   //         .toString(),
                                        //   //     controller.orders!.result!.data![index]
                                        //   //         .activities!.id
                                        //   //         .toString());

                                        //   //todo
                                        //   // downloadBook(
                                        //   //     downloadLink:
                                        //   //         //     "https://secure.mytravellerschoice.com/api/v1/attractions/orders/${controller.orders!.result!.data![index].id}/ticket/${controller.orders!.result!.data![index].activities!.id}",
                                        //   //         "https://secure.mytravellerschoice.com/api/v1/attractions/orders/6401e4f5913789806d34b998/ticket/6401e4f5913789806d34b999",
                                        //   //     title: "test");
                                        // },
                                        onTap: () async {
                                          log('tap');
                                          // String path = await ExtStorage
                                          //     .getExternalStoragePublicDirectory(
                                          //         ExtStorage.DIRECTORY_DOWNLOADS);
                                          //todo
                                          String path = await ExternalPath
                                              .getExternalStoragePublicDirectory(
                                                  ExternalPath
                                                      .DIRECTORY_DOWNLOADS);

                                          //
                                          //String fullPath = tempDir.path + "/boo2.pdf'";
                                          String fullPath =
                                              "$path/${controller.orders!.result!.data![index].activities!.activity!.name!}.pdf";
                                          print('full path $fullPath');
                                          String Idorder = controller
                                              .orders!.result!.data![index].id
                                              .toString();
                                          String idactivity = controller
                                              .orders!
                                              .result!
                                              .data![index]
                                              .activities!
                                              .id
                                              .toString();

                                          final ticketimage =
                                              // "https://secure.mytravellerschoice.com/api/v1/attractions/orders/6401e4f5913789806d34b998/ticket/6401e4f5913789806d34b999";
                                              "https://secure.mytravellerschoice.com/api/v1/attractions/orders/$Idorder/ticket/$idactivity";

                                          download2(dio, ticketimage, fullPath);
                                          // downloadFile();
                                        },
                                        padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                                        color: const Color(0xff1529e8)
                                            .withAlpha(40),
                                        // color:Color(0xff6874E8),
                                        // customTheme.groceryPrimary.withAlpha(40),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            FxText.bodyMedium("Download",
                                                color: const Color(0xff1529e8),
                                                // color: customTheme.groceryPrimary,
                                                fontWeight: 500,
                                                letterSpacing: -0.2),
                                            const Icon(
                                              MdiIcons.download,
                                              size: 14,
                                              color: Color(0xff1529e8),
                                            )
                                          ],
                                        ),
                                      ),
                                      FxSpacing.width(10),
                                    ],
                                  )
                                : const SizedBox(),
                            FxSpacing.height(15)
                          ],
                        ),
                      );

                      //slimu
                      // return SlimyCard(
                      //   color: const Color(0xff1529e8).withAlpha(40),
                      //   width: MediaQuery.of(context).size.width,
                      //   topCardHeight: 195,
                      //   bottomCardHeight: 150,
                      //   borderRadius: 15,
                      //   topCardWidget: Container(
                      //     // height: 212,
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius:
                      //             const BorderRadius.all(Radius.circular(10)),
                      //         border:
                      //             Border.all(color: Colors.grey.shade300, width: 1)),

                      //     child: Column(
                      //       children: [
                      //         Container(
                      //           margin: const EdgeInsets.all(8),
                      //           child: Column(
                      //             children: [
                      //               Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceBetween,
                      //                 children: [
                      //                   Container(
                      //                     child: Row(children: [
                      //                       FxText.bodyLarge(
                      //                         'Status:',

                      //                         // textAlign: TextAlign.left,
                      //                         letterSpacing: 0,
                      //                         fontWeight: 600,
                      //                       ),
                      //                       FxSpacing.width(10),
                      //                       FxText.bodyLarge(
                      //                         orders!.result!.data![index].orderStatus
                      //                             .toString(),

                      //                         color: orders!.result!.data![index]
                      //                                     .orderStatus ==
                      //                                 'confirmed'
                      //                             ? Colors.green
                      //                             : Colors.red,
                      //                         fontWeight: 600,
                      //                         // color: const Color(0xff1529e8),
                      //                       )
                      //                     ]),
                      //                   ),
                      //                   Container(
                      //                     child: Row(children: [
                      //                       FxText.bodyLarge(
                      //                         'Date:',

                      //                         // textAlign: TextAlign.left,
                      //                         letterSpacing: 0,
                      //                         fontWeight: 600,
                      //                       ),
                      //                       FxSpacing.width(10),
                      //                       FxText.bodyLarge(
                      //                         newDate,
                      //                         // formattedDatecreate,
                      //                         fontWeight: 600,
                      //                         color: const Color(0xff1529e8),
                      //                       )
                      //                     ]),
                      //                   )
                      //                 ],
                      //               ),
                      //               FxSpacing.height(10),
                      //               FxDashedDivider(
                      //                 dashSpace: 4,
                      //                 dashWidth: 8,
                      //                 color: theme.colorScheme.onBackground
                      //                     .withAlpha(180),
                      //                 height: 1.2,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         Container(
                      //           margin: const EdgeInsets.all(8),
                      //           child: Row(
                      //             children: [
                      //               Container(
                      //                 decoration: BoxDecoration(
                      //                   borderRadius: BorderRadius.circular(10),
                      //                 ),
                      //                 clipBehavior: Clip.antiAliasWithSaveLayer,
                      //                 child: CachedNetworkImage(
                      //                   height: 100,
                      //                   width: 100,
                      //                   fit: BoxFit.cover,
                      //                   progressIndicatorBuilder:
                      //                       (context, url, progress) => Center(
                      //                     child: CircularProgressIndicator(
                      //                       value: progress.progress,
                      //                     ),
                      //                   ),
                      //                   imageUrl:
                      //                       'https://a.walletbot.online${orders!.result!.data![index].attraction!.images!.first}',
                      //                 ),
                      //               ),
                      //               FxSpacing.width(20),
                      //               Expanded(
                      //                 child: Column(
                      //                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                   mainAxisAlignment: MainAxisAlignment.start,
                      //                   children: [
                      //                     Hero(
                      //                       tag:
                      //                           "product_${orders!.result!.data![index].activities!.activity!.name!}",
                      //                       child: FxText.bodyLarge(
                      //                         orders!.result!.data![index].activities!
                      //                             .activity!.name!,
                      //                         fontWeight: 800,
                      //                         overflow: TextOverflow.ellipsis,
                      //                         maxLines: 2,
                      //                       ),
                      //                     ),
                      //                     FxSpacing.height(4),
                      //                     Container(
                      //                       child: Column(
                      //                         children: [
                      //                           Row(
                      //                             children: [
                      //                               FxText.bodySmall(
                      //                                 'Adult:',
                      //                                 fontWeight: 900,
                      //                                 color: Colors.black,
                      //                               ),
                      //                               FxSpacing.width(10),
                      //                               FxText.bodySmall(
                      //                                 orders!.result!.data![index]
                      //                                     .activities!.adultsCount
                      //                                     .toString(),
                      //                                 fontWeight: 600,
                      //                                 color: Colors.black,
                      //                               ),
                      //                             ],
                      //                           ),
                      //                           Row(
                      //                             children: [
                      //                               FxText.bodySmall(
                      //                                 'Child:',
                      //                                 fontWeight: 900,
                      //                                 color: Colors.black,
                      //                               ),
                      //                               FxSpacing.width(10),
                      //                               FxText.bodySmall(
                      //                                 orders!.result!.data![index]
                      //                                     .activities!.childrenCount
                      //                                     .toString(),
                      //                                 fontWeight: 600,
                      //                                 color: Colors.black,
                      //                               ),
                      //                             ],
                      //                           ),
                      //                           Row(
                      //                             children: [
                      //                               FxText.bodySmall(
                      //                                 'Infant:',
                      //                                 fontWeight: 900,
                      //                                 color: Colors.black,
                      //                               ),
                      //                               FxSpacing.width(10),
                      //                               FxText.bodySmall(
                      //                                 orders!.result!.data![index]
                      //                                     .activities!.infantCount
                      //                                     .toString(),
                      //                                 fontWeight: 600,
                      //                                 color: Colors.black,
                      //                               ),
                      //                             ],
                      //                           ),
                      //                         ],
                      //                       ),
                      //                     ),
                      //                     FxSpacing.height(4),
                      //                     Hero(
                      //                       tag:
                      //                           "${orders!.result!.data![index].activities!.activity!.name!}_${orders!.result!.data![index].totalAmount}",
                      //                       child: FxText.labelLarge(
                      //                         "${orders!.result!.data![index].totalAmount} AED",
                      //                         // "\$" + product.price.toString() + "/hour",
                      //                         fontWeight: 700,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      //   bottomCardWidget: Container(
                      //     child: Column(
                      //       children: [
                      //         Container(
                      //           decoration: BoxDecoration(
                      //               color: const Color(0xff919EB0),
                      //               borderRadius:
                      //                   const BorderRadius.all(Radius.circular(10)),
                      //               border: Border.all(
                      //                   color: Colors.grey.shade300, width: 1)),
                      //           child: Row(
                      //             children: [
                      //               FxSpacing.width(10),
                      //               FxText.bodyLarge('Ref No:',

                      //                   // textAlign: TextAlign.left,
                      //                   letterSpacing: 0,
                      //                   fontWeight: 600,
                      //                   color: Colors.white),
                      //               FxSpacing.width(10),
                      //               FxText.bodyLarge(
                      //                 orders!.result!.data![index].referenceNumber
                      //                     .toString(),
                      //                 color: Colors.white,

                      //                 fontWeight: 600,
                      //                 // color: const Color(0xff1529e8),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         Container(
                      //           child: Column(
                      //             children: [
                      //               Align(
                      //                 alignment: Alignment.centerLeft,
                      //                 child: FxText.bodyLarge(
                      //                   'Billing Details',
                      //                   color: Colors.black,

                      //                   fontWeight: 600,
                      //                   // color: const Color(0xff1529e8),
                      //                 ),
                      //               ),
                      //               FxSpacing.height(10),
                      //               Row(
                      //                 children: [
                      //                   Expanded(
                      //                     child: Row(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         FxText.bodyLarge(
                      //                           'Name:',
                      //                           color: Colors.black,

                      //                           fontWeight: 600,
                      //                           // color: const Color(0xff1529e8),
                      //                         ),
                      //                         FxText.bodySmall(
                      //                           orders!.result!.data![index].name
                      //                               .toString(),
                      //                           color: const Color(0xff1529e8),

                      //                           fontWeight: 600,
                      //                           // color: const Color(0xff1529e8),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                   Expanded(
                      //                     child: Row(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         FxText.bodyLarge(
                      //                           'Email:',
                      //                           color: Colors.black,

                      //                           fontWeight: 600,
                      //                           // color: const Color(0xff1529e8),
                      //                         ),
                      //                         Expanded(
                      //                           child: FxText.bodySmall(
                      //                             orders!.result!.data![index].email
                      //                                 .toString(),
                      //                             color: const Color(0xff1529e8),

                      //                             fontWeight: 600,
                      //                             // color: const Color(0xff1529e8),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),

                      //               //a
                      //               FxSpacing.height(5),
                      //               Row(
                      //                 children: [
                      //                   Expanded(
                      //                     child: Row(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         FxText.bodyLarge(
                      //                           'Country:',
                      //                           color: Colors.black,

                      //                           fontWeight: 600,
                      //                           // color: const Color(0xff1529e8),
                      //                         ),
                      //                         FxText.bodySmall(
                      //                           orders!.result!.data![index].country!
                      //                               .countryName
                      //                               .toString(),

                      //                           color: const Color(0xff1529e8),

                      //                           fontWeight: 600,
                      //                           // color: const Color(0xff1529e8),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                   Expanded(
                      //                     child: Row(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.start,
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         FxText.bodyLarge(
                      //                           'Phone:',
                      //                           color: Colors.black,

                      //                           fontWeight: 600,
                      //                           // color: const Color(0xff1529e8),
                      //                         ),
                      //                         Expanded(
                      //                           child: FxText.bodySmall(
                      //                             orders!.result!.data![index]
                      //                                 .phoneNumber
                      //                                 .toString(),
                      //                             color: const Color(0xff1529e8),

                      //                             fontWeight: 600,
                      //                             // color: const Color(0xff1529e8),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ],
                      //               )
                      //             ],
                      //           ),
                      //         )
                      //       ],
                      //     ),
                      //   ),
                      //   slimeEnabled: true,
                      // );
                    },
                  ),
      );
    }
  }

  Widget _buildProductList() {
    List<Widget> list = [];

    // for (var  product in orders!.result!.totalOrders)
    for (Product product in controller.products!) {
      //orders!.result!.totalOrders
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: InkWell(
          onTap: () {
            controller.goToSingleProduct(product);
          },
          child: Container(
            height: 212,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            margin: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(children: [
                              FxText.bodyLarge(
                                'Status:',

                                // textAlign: TextAlign.left,
                                letterSpacing: 0,
                                fontWeight: 600,
                              ),
                              FxSpacing.width(10),
                              FxText.bodyLarge(
                                product.status,
                                color: product.status == 'confirmed'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: 600,
                                // color: const Color(0xff1529e8),
                              )
                            ]),
                          ),
                          Container(
                            child: Row(children: [
                              FxText.bodyLarge(
                                'Date:',

                                // textAlign: TextAlign.left,
                                letterSpacing: 0,
                                fontWeight: 600,
                              ),
                              FxSpacing.width(10),
                              FxText.bodyLarge(
                                '15-02-2023',
                                fontWeight: 600,
                                color: const Color(0xff1529e8),
                              )
                            ]),
                          )
                        ],
                      ),
                      FxSpacing.height(10),
                      FxDashedDivider(
                        dashSpace: 4,
                        dashWidth: 8,
                        color: theme.colorScheme.onBackground.withAlpha(180),
                        height: 1.2,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        // margin: EdgeInsets.all(8),
                        // paddingAll: 0,
                        // borderRadiusAll: 4,
                        // margin: EdgeInsets.all(8),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Hero(
                          tag: "product_image_${product.name}",
                          child: Image(
                            image: AssetImage(product.image),
                            // height: 100,
                            height: 132,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      FxSpacing.width(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                FxContainer(
                                  borderRadiusAll: 10,
                                  // padding: FxSpacing.xy(8, 4),
                                  padding: FxSpacing.xy(6, 2),
                                  // color: Color(0xff1529e8),
                                  color: Colors.blueGrey,
                                  child: FxText.bodySmall(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    // 'Theme Park',
                                    'Park',
                                    fontWeight: 300,
                                    color: Colors.white,
                                    // color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                FxContainer(
                                  borderRadiusAll: 10,
                                  // padding: FxSpacing.xy(8, 4),
                                  padding: FxSpacing.xy(6, 2),
                                  // color: Color(0xff1529e8),
                                  color: Colors.blueGrey,
                                  child: FxText.bodySmall(
                                    'Ticket',
                                    fontWeight: 300,
                                    color: Colors.white,
                                    // color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                FxContainer(
                                  borderRadiusAll: 10,
                                  // padding: FxSpacing.xy(8, 4),
                                  padding: FxSpacing.xy(6, 2),
                                  // color: Color(0xff1529e8),
                                  color: Colors.blueGrey,
                                  child: FxText.bodySmall(
                                    'Offer',
                                    fontWeight: 300,
                                    color: Colors.white,
                                    // color: theme.colorScheme.onPrimary,
                                  ),
                                ),
                              ],
                            ),
                            FxSpacing.height(8),
                            Hero(
                              tag: "product_${product.name}",
                              // child: FxText.bodyLarge(
                              //   product.name,
                              //   // fontWeight: 500,
                              // ),
                              child: FxText.bodyLarge(
                                product.name,
                                fontWeight: 800,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            FxSpacing.height(4),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      FxText.bodySmall(
                                        'Adult:',
                                        fontWeight: 900,
                                        color: Colors.black,
                                      ),
                                      FxSpacing.width(10),
                                      FxText.bodySmall(
                                        '4',
                                        fontWeight: 600,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FxText.bodySmall(
                                        'Child:',
                                        fontWeight: 900,
                                        color: Colors.black,
                                      ),
                                      FxSpacing.width(10),
                                      FxText.bodySmall(
                                        '0',
                                        fontWeight: 600,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      FxText.bodySmall(
                                        'Infant:',
                                        fontWeight: 900,
                                        color: Colors.black,
                                      ),
                                      FxSpacing.width(10),
                                      FxText.bodySmall(
                                        '0',
                                        fontWeight: 600,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            FxSpacing.height(4),
                            Hero(
                              tag: "${product.name}_${product.price}",
                              child: FxText.labelLarge(
                                // '\$' + product.price.toString(),
                                "${product.price} AED",
                                // "\$" + product.price.toString() + "/hour",
                                fontWeight: 700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }

    return Column(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<AllBookingController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  downloadBook({String? downloadLink, String? title}) async {
    log('downloading...');
    Dio dio;
    if (await Permission.storage.request().isGranted) {
      log('permissionif..');
      final downloadPath = await path.getExternalStorageDirectory();
      var filePath = '${downloadPath!.path}/$title.pdf';

      dio = Dio();
      await dio.download(downloadLink!, filePath).then((value) {
        dio.close();
        log('downloaded');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Your Ticket was downloaded Sucessfully')));
      }).catchError((Object e) {
        log('error:$e');
        // Fluttertoast.showToast(
        //     msg: "Terjadi kesalahan. Download gagal.", timeInSecForIosWeb: 1);
      });
    } else {}
  }
}
