import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/extensions/extensions.dart';

import '../../controllers/Activity_controller.dart';
import '../../loading_effect.dart';
import '../../models/cart.dart';
import '../../theme/app_theme.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late ActivityController controller;
  bool clickedExcursion = true;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(ActivityController(this));
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ActivityController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildCartList() {
    List<Widget> list = [];

    for (Cart cart in controller.carts!) {
      bool increaseAble = controller.increaseAble(cart);
      bool decreaseAble = controller.decreaseAble(cart);
      list.add(FadeTransition(
        opacity: controller.fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxSpacing.height(20),
            Row(
              children: [
                Expanded(child: Container()),
                InkWell(
                  onTap: () {
                    clickedExcursion = !clickedExcursion;
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: clickedExcursion
                            ? const Text("Added this Excursion!!")
                            : const Text("Removed this Excursion!!")));
                    // Navigator.pop(context);
                  },
                  child: FxContainer.bordered(
                    paddingAll: 4,
                    color: theme.colorScheme.onPrimary,
                    borderColor: Colors.black,
                    child: clickedExcursion
                        ? Icon(
                            FeatherIcons.plus,
                            color: Colors.indigo.withAlpha(200),
                            size: 12,
                          )
                        : Icon(
                            FeatherIcons.minus,
                            color: Colors.red.withAlpha(200),
                            size: 12,
                          ),
                  ),
                ),
              ],
            ),
            FxSpacing.height(10),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey.shade300, width: 1)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // FxSpacing.height(10),
                    FxText.bodyMedium(
                      'Tour Options',
                      muted: true,
                      fontWeight: 700,
                    ),
                    FxSpacing.height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText.bodyMedium(
                          'Tour',
                          fontWeight: 600,
                        ),
                        FxText.bodyMedium(
                          'Ferrari',
                          fontWeight: 700,
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
                        // FxText.bodyMedium(
                        //   // '\$' + controller.order.precise,
                        //   'without',
                        //   fontWeight: 700,
                        // ),
                        Expanded(child: Container()),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: theme.cardTheme.color,
                                // color: const Color(0xff1529e8),
                                borderRadius: BorderRadius.circular(4)),
                            height: 45.0,
                            width: MediaQuery.of(context).size.width,
                            // margin: const EdgeInsets.all(3.0),
                            //width: 300.0,
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  iconSize: 25.0,

                                  // dropdownColor: theme.cardTheme.color,
                                  dropdownColor: Colors.white,
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                  ),
                                  value: controller.selectedtransfer,
                                  // value: _selectedCountryCode,
                                  hint: Center(
                                    child: FxText.labelLarge(
                                      "Choose",
                                      fontWeight: 600,
                                      color: Colors.black,
                                      // color: theme.colorScheme.onPrimary,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                  items: controller.TransferCodes.map(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value,
                                        child: Center(
                                          child: Text(
                                            value,
                                            style: FxTextStyle.bodyMedium(),
                                          ),
                                        ));
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      controller.selectedtransfer =
                                          value.toString();
                                    });
                                  },

                                  style: FxTextStyle.bodyMedium(),
                                  // style: const TextStyle(
                                  //     color: Colors.black,
                                  //     fontSize: 20,
                                  //     fontWeight: FontWeight.w500),
                                ),
                              ),
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
                          'Date',
                          fontWeight: 600,
                        ),
                        // Expanded(child: Container()),
                        FxSpacing.width(50),
                        Expanded(
                          child: SlideTransition(
                            position: controller.dateAnimation,
                            child: SizedBox(
                              height: 45,
                              child: TextFormField(
                                style: FxTextStyle.bodyMedium(),
                                controller: controller.dateTE,
                                readOnly:
                                    true, //set it true, so that user will not able to edit text

                                onTap: controller.dateselect,
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    isDense: true,
                                    fillColor: theme.cardTheme.color,
                                    suffixIcon: Icon(
                                      FeatherIcons.calendar,
                                      color: theme.colorScheme.onBackground,
                                    ),
                                    hintText: "yyyy-mm-dd",
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    // enabledBorder: outlineInputBorder,
                                    // focusedBorder: outlineInputBorder,
                                    // border: outlineInputBorder,
                                    contentPadding: FxSpacing.all(16),
                                    hintStyle: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      letterSpacing: 0.4,
                                    ),
                                    // hintStyle: FxTextStyle.bodyMedium(),
                                    isCollapsed: true),
                                autofocus: false,
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ),
                        ),
                        // FxText.bodyMedium(
                        //   // '\$' + controller.order.precise,
                        //   '2023-01-31',
                        //   fontWeight: 700,
                        // ),
                      ],
                    ),
                    FxSpacing.height(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText.bodyMedium(
                          'Adult',
                          fontWeight: 600,
                        ),
                        // FxText.bodyMedium(
                        //   // '\$' + controller.order.precise,
                        //   '1 adult',
                        //   fontWeight: 700,
                        // ),
                        Expanded(child: Container()),
                        Row(
                          children: [
                            FxContainer(
                              onTap: () {
                                // controller.increment(controller.product);
                              },
                              bordered: controller.increaseAble(cart),
                              paddingAll: 4,
                              borderRadiusAll: 2,
                              border:
                                  Border.all(color: const Color(0xff1529e8)),
                              color: controller.increaseAble(cart)
                                  ? const Color(0xff1529e8)
                                  : theme.colorScheme.onBackground
                                      .withAlpha(200),
                              child: Icon(
                                FeatherIcons.plus,
                                size: 12,
                                color: controller.increaseAble(cart)
                                    ? theme.colorScheme.onPrimary
                                    : theme.colorScheme.onPrimary,
                              ),
                            ),
                            FxSpacing.width(15),
                            FxSpacing.height(8),
                            FxText.bodyMedium(
                              '1',
                              fontWeight: 700,
                            ),
                            FxSpacing.height(8),
                            FxSpacing.width(15),
                            FxContainer(
                              onTap: () {
                                controller.decrement;
                              },
                              paddingAll: 4,
                              borderRadiusAll: 2,
                              bordered: controller.decreaseAble(cart),
                              border: Border.all(
                                  color:
                                      const Color(0xff1529e8).withAlpha(120)),
                              color: controller.decreaseAble(cart)
                                  ? const Color(0xff1529e8).withAlpha(28)
                                  : theme.colorScheme.onBackground
                                      .withAlpha(200),
                              child: Icon(
                                FeatherIcons.minus,
                                size: 12,
                                color: controller.decreaseAble(cart)
                                    ? const Color(0xff1529e8)
                                    // theme.colorScheme.primary
                                    : theme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
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
                          '345.00 AED',
                          // 'IMG Worlds of Adventure',
                          fontWeight: 700,
                        ),
                      ],
                    ),
                    FxSpacing.height(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText.bodyMedium(
                          'Tax',
                          fontWeight: 600,
                        ),
                        FxText.bodyMedium(
                          // '\$' + controller.tax.precise,
                          '\$ 33',
                          fontWeight: 700,
                        ),
                      ],
                    ),
                    FxSpacing.height(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FxText.bodyMedium(
                          'Offer',
                          fontWeight: 600,
                        ),
                        FxText.bodyMedium(
                          // '- \$' + controller.offer.precise,
                          '- \$ 50',
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
                            color:
                                theme.colorScheme.onBackground.withAlpha(180),
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
                          '345.00 AED',
                          // controller.products.
                          fontWeight: 800,
                          color: const Color(0xff1529e8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        // child: Column(
        //   children: [
        //     Row(
        //       children: [
        //         Expanded(child: Container()),
        //         InkWell(
        //           onTap: () {
        //             // Navigator.pop(context);
        //           },
        //           child: FxContainer.bordered(
        //             paddingAll: 4,
        //             color: theme.colorScheme.onPrimary,
        //             borderColor: Colors.black,
        //             child: Icon(
        //               FeatherIcons.minus,
        //               color: Colors.red.withAlpha(200),
        //               size: 12,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //     FxSpacing.height(10),
        //     FxContainer(
        //       margin: FxSpacing.bottom(20),
        //       borderRadiusAll: 4,
        //       paddingAll: 12,
        //       child: Column(
        //         children: [
        //           Row(
        //             children: [
        //               FxContainer(
        //                 paddingAll: 0,
        //                 borderRadiusAll: 4,
        //                 height: 80,
        //                 width: 80,
        //                 clipBehavior: Clip.antiAliasWithSaveLayer,
        //                 child: Image(
        //                   fit: BoxFit.cover,
        //                   image: AssetImage(cart.product.image),
        //                 ),
        //               ),
        //               FxSpacing.width(16),
        //               Expanded(
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     FxText.titleMedium(
        //                       cart.product.name,
        //                       fontWeight: 700,
        //                     ),
        //                     FxSpacing.height(8),
        //                     FxText.bodyMedium(
        //                       '\$${cart.product.price}',
        //                       fontWeight: 700,
        //                     ),
        //                     FxSpacing.height(8),
        //                   ],
        //                 ),
        //               ),
        //               FxSpacing.width(20),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ));
    }
    return Column(
      children: list,
    );
  }

  Widget _billingWidget() {
    log('billing Widget');
    // bool increaseAble = controller.increaseAble(controller.product);
    // bool decreaseAble = controller.decreaseAble(controller.product);
    return FadeTransition(
      opacity: controller.cartAnimation,
      // opacity: controller.fadeAnimation,
      child: FxContainer(
        borderRadiusAll: 4,
        // color: Colors.red,
        color: Colors.white,
        // color: Color(0xffe5fdfd),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxText.bodyMedium(
              'Tour Options',
              muted: true,
              fontWeight: 700,
            ),
            FxSpacing.height(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Tour',
                  fontWeight: 600,
                ),
                FxText.bodyMedium(
                  'Ferrari',
                  fontWeight: 700,
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
                // FxText.bodyMedium(
                //   // '\$' + controller.order.precise,
                //   'without',
                //   fontWeight: 700,
                // ),
                Expanded(child: Container()),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        // color: const Color(0xff1529e8),
                        borderRadius: BorderRadius.circular(4)),
                    height: 45.0,
                    width: MediaQuery.of(context).size.width,
                    // margin: const EdgeInsets.all(3.0),
                    //width: 300.0,
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          iconSize: 25.0,

                          // dropdownColor: theme.cardTheme.color,
                          dropdownColor: Colors.white,
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          value: controller.selectedtransfer,
                          // value: _selectedCountryCode,
                          hint: Center(
                            child: FxText.labelLarge(
                              "Choose",
                              fontWeight: 600,
                              color: Colors.black,
                              // color: theme.colorScheme.onPrimary,
                              letterSpacing: 0.4,
                            ),
                          ),
                          items: controller.TransferCodes.map((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Center(
                                  child: Text(
                                    value,
                                    style: FxTextStyle.bodyMedium(),
                                  ),
                                ));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              controller.selectedtransfer = value.toString();
                            });
                          },
                          // items:
                          //     // controller.countryCodes.map
                          //     // _countryCodes.map
                          //     // countryList.isNotEmpty &&
                          //     //         countryList.first.countries!.isNotEmpty
                          //     //     ? countryList.first.countries!.map((value) {
                          //     //         return DropdownMenuItem<String>(
                          //     //             value: value!.phonecode.toString(),
                          //     //             child: Center(
                          //     //               child: Text(
                          //     //                 value.phonecode.toString(),
                          //     //                 style: const TextStyle(
                          //     //                     color: Colors.black,
                          //     //                     fontSize: 20,
                          //     //                     fontWeight: FontWeight.w500),
                          //     //               ),
                          //     //             ));
                          //     //       }).toList()
                          //     //     : [].map((value) {
                          //     //         return DropdownMenuItem<String>(
                          //     //             value: value,
                          //     //             child: Center(
                          //     //               child: Text(
                          //     //                 value,
                          //     //                 style: const TextStyle(
                          //     //                     color: Colors.black,
                          //     //                     fontSize: 20,
                          //     //                     fontWeight: FontWeight.w500),
                          //     //               ),
                          //     //             ));
                          //     //       }).toList(),
                          // onChanged: (value) {
                          //   setState(() {
                          //     log(value.toString());
                          //     controller.selectedCountryCode = value.toString();
                          //     // _selectedCountryCode = value.toString();
                          //   });
                          // },
                          style: FxTextStyle.bodyMedium(),
                          // style: const TextStyle(
                          //     color: Colors.black,
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.w500),
                        ),
                      ),
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
                  'Date',
                  fontWeight: 600,
                ),
                Expanded(child: Container()),
                Expanded(
                  child: SlideTransition(
                    position: controller.dateAnimation,
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        style: FxTextStyle.bodyMedium(),
                        controller: controller.dateTE,
                        readOnly:
                            true, //set it true, so that user will not able to edit text

                        onTap: controller.dateselect,
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            isDense: true,
                            fillColor: theme.cardTheme.color,
                            suffixIcon: Icon(
                              FeatherIcons.calendar,
                              color: theme.colorScheme.onBackground,
                            ),
                            hintText: "yyyy-mm-dd",
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            // enabledBorder: outlineInputBorder,
                            // focusedBorder: outlineInputBorder,
                            // border: outlineInputBorder,
                            contentPadding: FxSpacing.all(16),
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              letterSpacing: 0.4,
                            ),
                            // hintStyle: FxTextStyle.bodyMedium(),
                            isCollapsed: true),
                        autofocus: false,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                  ),
                ),
                // FxText.bodyMedium(
                //   // '\$' + controller.order.precise,
                //   '2023-01-31',
                //   fontWeight: 700,
                // ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Adult',
                  fontWeight: 600,
                ),
                // FxText.bodyMedium(
                //   // '\$' + controller.order.precise,
                //   '1 adult',
                //   fontWeight: 700,
                // ),
                Expanded(child: Container()),
                // Row(
                //   children: [
                //     FxContainer(
                //       onTap: () {
                //         // controller.increment(controller.product);
                //       },
                //       bordered: controller.increaseAble(controller.product),
                //       paddingAll: 4,
                //       borderRadiusAll: 2,
                //       border: Border.all(color: const Color(0xff1529e8)),
                //       color: controller.increaseAble(controller.product)
                //           ? const Color(0xff1529e8)
                //           : theme.colorScheme.onBackground.withAlpha(200),
                //       child: Icon(
                //         FeatherIcons.plus,
                //         size: 12,
                //         color: controller.increaseAble(controller.product)
                //             ? theme.colorScheme.onPrimary
                //             : theme.colorScheme.onPrimary,
                //       ),
                //     ),
                //     FxSpacing.width(15),
                //     FxSpacing.height(8),
                //     FxText.bodyMedium(
                //       controller.product.person.toString(),
                //       fontWeight: 700,
                //     ),
                //     FxSpacing.height(8),
                //     FxSpacing.width(15),
                //     FxContainer(
                //       onTap: () {
                //         controller.decrement(controller.product);
                //       },
                //       paddingAll: 4,
                //       borderRadiusAll: 2,
                //       bordered: controller.decreaseAble(controller.product),
                //       border: Border.all(
                //           color: const Color(0xff1529e8).withAlpha(120)),
                //       color: controller.decreaseAble(controller.product)
                //           ? const Color(0xff1529e8).withAlpha(28)
                //           : theme.colorScheme.onBackground.withAlpha(200),
                //       child: Icon(
                //         FeatherIcons.minus,
                //         size: 12,
                //         color: controller.decreaseAble(controller.product)
                //             ? const Color(0xff1529e8)
                //             // theme.colorScheme.primary
                //             : theme.colorScheme.onPrimary,
                //       ),
                //     ),
                //   ],
                // ),
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
                  '345.00 AED',
                  // 'IMG Worlds of Adventure',
                  fontWeight: 700,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Tax',
                  fontWeight: 600,
                ),
                FxText.bodyMedium(
                  // '\$' + controller.tax.precise,
                  '\$ 33',
                  fontWeight: 700,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Offer',
                  fontWeight: 600,
                ),
                FxText.bodyMedium(
                  // '- \$' + controller.offer.precise,
                  '- \$ 50',
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
                  '345.00 AED',
                  // controller.products.
                  fontWeight: 800,
                  color: const Color(0xff1529e8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
        body: Container(
            padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
            child: LoadingEffect.getCartLoadingScreen(
              context,
            )),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              controller.goBack();
            },
            child: Icon(
              FeatherIcons.chevronLeft,
              size: 20,
              color: theme.colorScheme.onBackground,
            ).autoDirection(),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: FxText.titleMedium(
            'Excursions',
            fontWeight: 700,
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xfff5f5f5),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
        //   child: FxButton.block(
        //     onPressed: () {
        //       // controller.bookNow();
        //       // cartController.carts.add(Cart());
        //     },
        //     backgroundColor: const Color(0xff1529e8),
        //     // backgroundColor: customTheme.estatePrimary,
        //     borderRadiusAll: 12,

        //     elevation: 0,
        //     child: FxText.bodyMedium(
        //       'Add to Cart',
        //       color: Colors.white,
        //       // color: customTheme.estateOnPrimary,
        //       fontWeight: 700,
        //     ),
        //   ),
        // ),
        body: ListView(
          padding: FxSpacing.nTop(20),
          children: [
            //todo
            // _billingWidget(),
            _buildCartList(),
            FxSpacing.height(20),
            FadeTransition(
              opacity: controller.fadeAnimation,
              child: FxButton.block(
                  onPressed: () {
                    controller.goToCheckout();
                  },
                  backgroundColor: const Color(0xff1529e8),
                  // backgroundColor: theme.colorScheme.primary,
                  elevation: 0,
                  borderRadiusAll: 4,
                  child: Row(
                    children: [
                      SlideTransition(
                        position: controller.animation,
                        child: Image(
                          height: 22,
                          width: 22,
                          color: theme.colorScheme.onPrimary,
                          image: const AssetImage(
                              'assets/images/apps/shopping2/icons/clear_cart_outline.png'),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: FxText.bodyMedium(
                            'Checkout',
                            fontWeight: 600,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            FxSpacing.height(80),
          ],
        ),
      );
    }
  }
}
