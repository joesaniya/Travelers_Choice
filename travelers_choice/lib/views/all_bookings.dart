import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../card_widgets/customsnackbar.dart';
import '../controllers/all_bookings.dart';
import '../controllers/pdf_api.dart';
import '../loading_effect.dart';
import '../services/app_constants.dart';
import '../services/attraction_Service.dart';
import '../theme/app_theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as path;

import 'bottomSheet/filter_bookings.dart';
import 'bottomSheet/sort_allbooking.dart';

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
    controller = FxControllerStore.put(AllBookingController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        controller.token =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN)!;
        log("auth token ${controller.token!}");
      });
    });
    getOrder1(context);
  }

  bool isLoading = true;

  getOrder1(context) async {
    Future.delayed(Duration.zero, () async {
      await AttractionService()
          .getAttractionOrders(controller.token!, context)
          .then((value) {
        if (value != null) {
          log('first data');
          isLoading = false;
          controller.orders = [];
          controller.orders!.add(value);
          log('All Orders:${controller.orders}');

          setState(() {});
        }
      });
    });
  }

  final imgUrl =
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

  var dio = Dio();

  void getPermission() async {
    log("getPermission");
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
      log(response.headers.toString());
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
      log(e.toString());
      log('Error:$e');
      CustomSnackbar.show(
        context: context,
        message: e.toString(),
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      log((received / total * 100).toStringAsFixed(0) + "%");
    } else {
      CustomSnackbar.show(
        context: context,
        message: 'Your Ticket was downloaded Sucessfully',
        backgroundColor: const Color(0xff1529e8),
        duration: const Duration(seconds: 2),
      );
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Your Ticket was downloaded Sucessfully')));
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
      log(e.toString());
    }
  }

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FxBuilder<AllBookingController>(
        controller: controller,
        builder: (controller) {
          // return _buildBody();
          return _buildBodyDemo();
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
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text('Your Ticket was downloaded Sucessfully')));
        CustomSnackbar.show(
          context: context,
          message: 'Your Ticket was downloaded Sucessfully',
          backgroundColor: const Color(0xff1529e8),
          duration: const Duration(seconds: 2),
        );
      }).catchError((Object e) {
        log('error:$e');
        CustomSnackbar.show(
          context: context,
          message: e.toString(),
          backgroundColor: const Color(0xff1529e8),
          duration: const Duration(seconds: 2),
        );
        // Fluttertoast.showToast(
        //     msg: "Terjadi kesalahan. Download gagal.", timeInSecForIosWeb: 1);
      });
    } else {}
  }

  Widget _buildBodyDemo() {
    if (controller.uiLoading)
    // if (allattractionList == null)
    {
      return Scaffold(
          body: Padding(
        padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
        child: LoadingEffect.getHomeLoadingScreen
            // getProductLoadingScreen->profile
            //getDatingHomeScreen->detail

            (
          context,
          // theme, theme.colorScheme
        ),
      ));
    } else {
      if (controller.uiLoading) {
        return const Scaffold(body: Center(child: Text("No Data found")));
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
                : ListView(
                    padding: FxSpacing.fromLTRB(20, 0, 20, 20),
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                // padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade300),
                                  boxShadow: [
                                    BoxShadow(
                                      // color: Colors.grey.shade400,
                                      color: const Color(0xff1529e8)
                                          .withOpacity(0.4),
                                      blurRadius: 2,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  style: FxTextStyle.bodyMedium(),
                                  controller: controller.SearchTE,
                                  cursorColor: theme.colorScheme.primary,

                                  //2
                                  onChanged: (value) {},

                                  decoration: InputDecoration(
                                    hintText: "Search your Order ...",
                                    hintStyle: FxTextStyle.bodySmall(
                                        color: theme.colorScheme.onBackground),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                        borderSide: BorderSide.none),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                        borderSide: BorderSide.none),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    // fillColor: const Color(0xffcfd2ff),
                                    fillColor: theme.cardTheme.color,
                                    prefixIcon: Icon(
                                      FeatherIcons.search,
                                      size: 16,
                                      color: theme.colorScheme.onBackground
                                          .withAlpha(150),
                                    ),
                                    isDense: true,
                                  ),
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                ),
                              ),
                            ),
                            FxSpacing.width(4),
                            FxContainer(
                              paddingAll: 12,
                              borderRadiusAll: 4,
                              onTap: () async {
                                var data = await showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext buildContext) {
                                      return const SortAllBooking();
                                    });
                                setState(() {});
                              },
                              color: const Color(0xff1529e8).withAlpha(40),
                              child: const Icon(
                                Iconsax.sort,
                                color: Color(0xff1529e8),
                                size: 20,
                              ),
                            ),
                            FxSpacing.width(4),
                            FxContainer(
                              paddingAll: 12,
                              borderRadiusAll: 4,
                              onTap: () async {
                                var data = await showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext buildContext) {
                                      return const FilterAllBooking();
                                    });
                                setState(() {});
                              },
                              color: const Color(0xff1529e8).withAlpha(40),
                              child: const Icon(
                                FeatherIcons.sliders,
                                color: Color(0xff1529e8),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        FxSpacing.height(10),
                        controller.orders == null ||
                                controller.orders!.first.result!.data!.isEmpty
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.8, // 80% of the screen width
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                // height: double.infinity,
                                // width: double.infinity,
                                child: Center(
                                  child: FxText.bodySmall(
                                    "No Order History!!",
                                  ),
                                ),
                              )
                            : CustomList()
                      ]));
      }
    }
  }

  String? oId;

  Widget CustomList() {
    return ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, index) {
          log('All book');
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: controller.orders!.first.result!.data!.length,
        itemBuilder: (BuildContext context, int index) {
          // log('booking length:${bookinglength!.length}');
          log('data length:${controller.orders!.first.result!.data!.length}');
          log('index data length:${controller.orders!.first.result!.data!.length}');
          log('index:$index');
          var date =
              controller.orders!.first.result!.data![index].activities!.date;
          String createdatae = controller
              .orders!.first.result!.data![index].createdAt
              .toString();

          log('Created Date:$createdatae');
          DateTime dateTime = DateTime.parse(createdatae);

          var newDate = date!.toLocal().toString().substring(0, 10);
          log('New Date book:$newDate');
          log('data length:${controller.orders!.first.result!.data!.length}');
          return GestureDetector(
            onTap: () {
              setState(() {
                oId = controller.orders!.first.result!.data![index].id;
              });
              log('Order Id:$oId');
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey.shade300, width: 1)),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        // // controller.orders!.first.result!.data![index].id!
                        // //         .contains(oId.toString())
                        // controller.orders!.first.result!.data![index].id == oId
                        //     ? const Text('hhh')
                        //     : const Text('no'),
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
                                  controller.orders!.first.result!.data![index]
                                      .orderStatus
                                      .toString(),

                                  color: controller.orders!.first.result!
                                              .data![index].orderStatus ==
                                          'confirmed'
                                      ? Colors.green
                                      : controller.orders!.first.result!
                                                  .data![index].orderStatus ==
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

                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: const Color(0xff919EB0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
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
                              controller.orders!.first.result!.data![index]
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
                                'https://a.walletbot.online${controller.orders!.first.result!.data![index].attraction!.images!.first}',
                          ),
                        ),
                        FxSpacing.width(20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Hero(
                                tag:
                                    "product_${controller.orders!.first.result!.data![index].activities!.activity!.name!}",
                                child: FxText.bodyLarge(
                                  controller.orders!.first.result!.data![index]
                                      .activities!.activity!.name!,
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
                                              .first
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
                                              .first
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
                                              .first
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
                                    "${controller.orders!.first.result!.data![index].activities!.activity!.name!}_${controller.orders!.first.result!.data![index].totalAmount}",
                                child: FxText.labelLarge(
                                  "${controller.orders!.first.result!.data![index].totalAmount} AED",
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  controller
                                      .orders!.first.result!.data![index].name
                                      .toString(),
                                  fontWeight: 600,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            FxSpacing.width(20),
                            //3
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FxText.bodySmall(
                                  'Email:',
                                  fontWeight: 900,
                                  color: Colors.black,
                                ),
                                FxSpacing.width(10),
                                Expanded(
                                  child: FxText.bodySmall(
                                    controller.orders!.first.result!
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                  controller.orders!.first.result!.data![index]
                                      .country!.countryName
                                      .toString(),
                                  fontWeight: 600,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            FxSpacing.width(20),
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
                                  controller.orders!.first.result!.data![index]
                                      .phoneNumber
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
                  controller.orders!.first.result!.data![index].orderStatus ==
                          'confirmed'
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FxContainer(
                              onTap: () async {
                                log('preview Screen clicked');
                                log('id:${controller.orders!.first.result!.data![index].id}');
                                String Idorder = controller
                                    .orders!.first.result!.data![index].id
                                    .toString();
                                String idactivity = controller.orders!.first
                                    .result!.data![index].activities!.id
                                    .toString();

                                final url =
                                    'https://secure.mytravellerschoice.com/api/v1/attractions/orders/$Idorder/ticket/$idactivity';
                                final file = await PDFApi.loadNetwork(url);
                                controller.openPDF(
                                    context, file, Idorder, idactivity);
                              },
                              padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                              color: const Color(0xff1529e8).withAlpha(40),
                              child: Row(
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                              onTap: () async {
                                log('tap');
                                // String path = await ExtStorage
                                //     .getExternalStoragePublicDirectory(
                                //         ExtStorage.DIRECTORY_DOWNLOADS);
                                //todo
                                String path = await ExternalPath
                                    .getExternalStoragePublicDirectory(
                                        ExternalPath.DIRECTORY_DOWNLOADS);

                                //
                                //String fullPath = tempDir.path + "/boo2.pdf'";
                                String fullPath =
                                    "$path/${controller.orders!.first.result!.data![index].activities!.activity!.name!}.pdf";
                                log('full path $fullPath');
                                String Idorder = controller
                                    .orders!.first.result!.data![index].id
                                    .toString();
                                String idactivity = controller.orders!.first
                                    .result!.data![index].activities!.id
                                    .toString();

                                final ticketimage =
                                    // "https://secure.mytravellerschoice.com/api/v1/attractions/orders/6401e4f5913789806d34b998/ticket/6401e4f5913789806d34b999";
                                    "https://secure.mytravellerschoice.com/api/v1/attractions/orders/$Idorder/ticket/$idactivity";

                                download2(dio, ticketimage, fullPath);
                                // downloadFile();
                              },
                              padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                              color: const Color(0xff1529e8).withAlpha(40),
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
            ),
          );
        });
  }
}
