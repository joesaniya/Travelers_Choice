import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../controllers/Activity_Controller.dart';
import '../controllers/checkout_controller.dart';
import '../models/atteraction_model.dart';
import '../theme/app_theme.dart';
import 'checkout_screen.dart';

class NewCartPage extends StatefulWidget {
  dynamic? length;

  List<Activity> selectedtourOption;

  String textdate;
  String? Transfer;
  double? totalAmount;

  @override
  Key? key;

  NewCartPage(this.length, this.selectedtourOption, this.textdate,
      this.Transfer, this.totalAmount,
      {super.key});

  @override
  State<NewCartPage> createState() => _NewCartPageState();
}

class _NewCartPageState extends State<NewCartPage>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late CustomTheme customTheme;

  late CheckOutController controller;
  late ActivityController controller1;
  List? selectedExcursions;
  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    selectedExcursions = widget.selectedtourOption;
    log('Selected Tour length:${widget.selectedtourOption.first.sId}');
    log('Selected Total Amount:${widget.totalAmount}');

    fetchlog();
    log('Selected Final Amount:${widget.selectedtourOption.first.grandTotal}');

    // fetchData();
    theme = AppTheme.shoppingTheme;
    controller1 = FxControllerStore.put(ActivityController(this));
    controller = FxControllerStore.put(CheckOutController(this));
  }

  fetchlog() async {
    log('fetch log calling');
    log('Excursions:$selectedExcursions');
    // selectedExcursions!.map((e) {
    //   // e.sId;
    //   // e.createdAt;
    //   // e.adultCount;
    //   // e.infantCount;
    //   // e.childCount;
    //   // e.activityType;

    //   log('Sid:${e.sId.toString()}');
    // });
    for (var element in selectedExcursions!) {
      log('Sid:${element.sId.toString()}');
    }
  }

  Widget getSinglePayment(
      {int? index, required String image, required String method}) {
    log('method:$method');
    log('index:$index');
    bool isSelected = index == controller.selectedPayment;

    return FxContainer(
      onTap: () {
        setState(() {
          controller.selectedPayment = index;
        });
      },
      margin: FxSpacing.bottom(16),
      padding: FxSpacing.all(16),
      bordered: !isSelected,
      border: Border.all(
          // color: customTheme.border
          color: Colors.indigo),
      color: isSelected ? Colors.white : Colors.transparent,
      // color: isSelected ? customTheme.card : theme.scaffoldBackgroundColor,
      borderRadiusAll: 8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 48,
            height: 36,
            child: Image.asset(
              image,
            ),
          ),
          FxSpacing.width(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodyMedium(method, fontWeight: 600),
                // FxSpacing.height(8),
                // FxText.labelSmall(
                //     "8765  \u2022\u2022\u2022\u2022  \u2022\u2022\u2022\u2022  7983",
                //     muted: true,
                //     letterSpacing: 0)
              ],
            ),
          ),
          // isSelected ? Space.width(16) : Space.width(20),
          isSelected
              ? Container(
                  padding: FxSpacing.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff1529e8).withAlpha(40)),
                  child: const Icon(
                    FeatherIcons.check,
                    color: Color(0xff1529e8),
                    size: 14,
                  ),
                )
              : Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xff1529e8))),
                ),
        ],
      ),
    );
  }

  Widget _billingWidget() {
    List<Widget> list = [];
    log('message');
    log(widget.length.toString());
    return SizedBox(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return FadeTransition(
            opacity: controller.fadeAnimation,
            child: FxContainer(
              borderRadiusAll: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.bodyMedium(
                    'Billing Information',
                    muted: true,
                    fontWeight: 700,
                  ),
                  FxSpacing.height(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Option',
                        fontWeight: 600,
                      ),
                      FxSpacing.width(20),
                      // Expanded(child: Container()),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FxText.bodyMedium(
                            // '\$' + controller.order.precise,
                            widget.selectedtourOption[index].name.toString(),
                            fontWeight: 700,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FxSpacing.height(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Transfer',
                        fontWeight: 600,
                      ),
                      widget.Transfer == null
                          ? FxText.bodyMedium(
                              'without',
                              fontWeight: 700,
                            )
                          : FxText.bodyMedium(
                              widget.Transfer.toString(),
                              fontWeight: 700,
                            ),
                    ],
                  ),
                  FxSpacing.height(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Date',
                        fontWeight: 600,
                      ),
                      FxText.bodyMedium(
                        widget.selectedtourOption[index].selectedDate
                            .toString(),
                        fontWeight: 700,
                      ),
                    ],
                  ),
                  FxSpacing.height(4),
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
                            color: const Color(0xff1529e8).withAlpha(40),
                            child: Row(
                              children: [
                                FxText.bodyMedium(
                                    widget.selectedtourOption[index].adultCount
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
                            color: const Color(0xff1529e8).withAlpha(40),
                            child: Row(
                              children: [
                                FxText.bodyMedium(
                                    widget.selectedtourOption[index].childCount
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
                            color: const Color(0xff1529e8).withAlpha(40),
                            child: Row(
                              children: [
                                FxText.bodyMedium(
                                    widget.selectedtourOption[index].infantCount
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
                  FxSpacing.height(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Amount',
                        fontWeight: 600,
                      ),
                      FxText.bodyMedium(
                        "${widget.selectedtourOption[index].grandTotal}AED",
                        fontWeight: 700,
                      ),
                    ],
                  ),
                  FxSpacing.height(12),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                      Expanded(
                        child: FxDashedDivider(
                          dashSpace: 4,
                          dashWidth: 8,
                          color: theme.colorScheme.onBackground.withAlpha(180),
                          height: 1.2,
                        ),
                      )
                    ],
                  ),
                  FxSpacing.height(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Grand Total',
                        fontWeight: 700,
                        color: const Color(0xff1529e8),
                      ),
                      FxText.bodyMedium(
                        // '\$' + controller.total.precise,
                        "${widget.selectedtourOption[index].grandTotal}AED",
                        fontWeight: 800,
                        color: const Color(0xff1529e8),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return FxSpacing.height(10);
        },
      ),
    );
  }

  Widget paymentInfo() {
    return Container(
      padding: FxSpacing.x(20),
      child: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FxSpacing.height(20),

          //bill
          _billingWidget(),
          FxSpacing.height(20),
          // FxText.bodyLarge(
          //   'Select Payment Method',
          //   fontWeight: 800,
          // ),
          // FxSpacing.height(12),
          // FxDashedDivider(
          //   dashSpace: 4,
          //   dashWidth: 8,
          //   color: theme.colorScheme.onBackground.withAlpha(180),
          //   height: 1.2,
          // ),
          // FxSpacing.height(20),

          // getSinglePayment(
          //     index: 1,
          //     method: "CCavenue",
          //     image: 'assets/images/apps/shopping2/icons/cc-avenue.png'),
          // // getSinglePayment(
          // //     index: 2,
          // //     method: "RazorPay",
          // //     image: 'assets/images/apps/shopping2/icons/razor_logo.png'),

          // FxSpacing.height(20),

          // MaterialButton(
          //   onPressed: () {
          //     controller.initPlatformState();
          //     // controller.nextPage(
          //     //     selectedExcursions, context, widget.totalAmount);
          //   },
          //   // child: const Text('Button')
          //   child: controller.selectedPayment == 1
          //       ? const Text('ccavenue')
          //       : controller.selectedPayment == 2
          //           ? const Text('razor')
          //           : const Text('select'),
          // ),
          FxButton.block(
            onPressed: () {
              log('book');
              // controller1.goToCheckout1();
              print(widget.selectedtourOption.length);
              print(widget.selectedtourOption);
              print(widget.textdate);
              print(widget.Transfer);
              print(widget.totalAmount);
              Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  transitionsBuilder: (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child,
                  ) =>
                      FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                  pageBuilder: (_, __, ___) => CheckOutScreen(
                      widget.selectedtourOption.length,
                      widget.selectedtourOption,
                      widget.textdate,
                      widget.Transfer,
                      widget.totalAmount)));
            },
            borderRadiusAll: 4,
            elevation: 0,
            splashColor: const Color(0xff1529e8).withAlpha(40),
            backgroundColor: const Color(0xff1529e8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Book Now',
                  fontWeight: 600,
                  color: theme.colorScheme.onPrimary,
                ),
                FxText.bodyMedium(
                  ' ${widget.totalAmount} AED',
                  fontWeight: 700,
                  color: theme.colorScheme.onPrimary,
                ),
              ],
            ),
          ),
          FxSpacing.height(80),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<CheckOutController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
            backgroundColor: const Color(0xfff5f5f5),
            // backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: const Color(0xfff5f5f5),
              elevation: 0,
              centerTitle: true,
              title: FxText.titleMedium(
                'Cart',
                fontWeight: 600,
              ),
              leading: InkWell(
                onTap: () {
                  controller.goBack();
                },
                child: const Icon(
                  FeatherIcons.chevronLeft,
                  size: 20,
                ),
              ),
            ),
            body: paymentInfo(),
          );
        });
  }
}
