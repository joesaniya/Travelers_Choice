import 'dart:developer';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:gap/gap.dart';
import 'package:hotel_travel/flight_module/views/ticket_view.dart';
import 'package:lottie/lottie.dart';

import '../../card_widgets/customsnackbar.dart';
import '../../localizations/language.dart';
import '../../models/Country_modal.dart';
import '../../services/auth_service.dart';
import '../../theme/app_theme.dart';
import '../controller/flight_checkout_Controller.dart';
import '../utils/app_info_list.dart';
import '../utils/app_styles.dart';
import '../utils/ticket_screen_codes.dart';

class FlightCheckout extends StatefulWidget {
  const FlightCheckout({super.key});

  @override
  State<FlightCheckout> createState() => _FlightCheckoutState();
}

class _FlightCheckoutState extends State<FlightCheckout>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late CustomTheme customTheme;

  late FlightCheckOutController controller;

  late OutlineInputBorder outlineInputBorderenable;
  late OutlineInputBorder outlineInputBorderfocus;
  List? selectedExcursions;
  String? token;
  @override
  void initState() {
    super.initState();

    customTheme = AppTheme.customTheme;

    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(FlightCheckOutController(this));

    outlineInputBorderenable = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.black),
    );
    outlineInputBorderfocus = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Color(0xff1529e8)),
    );
  }

  bool isLoading = true;
  fetchData() {
    Future.delayed(Duration.zero, () async {
      await getCountryList().then((value) {
        if (value) {
          isLoading = false;
          setState(() {});
        }
      });
      // await AuthController().getCountryList().then((value) {
      //   if (value) {
      //     isLoading = false;
      //     setState(() {});
      //   }
      // });
    });
  }

  String? _selectedCountry;

  List<CountryModal> countryList = <CountryModal>[];
  bool isCountryListLoading = true;
  Future getCountryList() async {
    log('get country');
    isCountryListLoading = true;
    try {
      var data = await AuthService().getCountry();
      countryList.clear();
      if (data != null) {
        setState(() {});
        countryList.add(data);
        isCountryListLoading = false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<FlightCheckOutController>(
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
                'Checkout',
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
            body: Column(
              children: [
                FxSpacing.height(8),
                FxContainer(
                  margin: FxSpacing.x(20),
                  paddingAll: 0,
                  color: Colors.transparent,
                  borderRadiusAll: 4,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: buildTabs(),
                ),
                FxSpacing.height(20),
                Expanded(
                  child: PageView(
                    allowImplicitScrolling: true,
                    pageSnapping: true,
                    // physics: const AlwaysScrollableScrollPhysics(),
                    physics: const NeverScrollableScrollPhysics(),
                    // physics: const ClampingScrollPhysics(),
                    controller: controller.pageController,
                    onPageChanged: (int page) {
                      log('Page:$page');
                      controller.onPageChanged(page);
                    },
                    children: [shippingInfo(), paymentInfo(), placedInfo()],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget buildTabs() {
    List<Widget> tabs = [];

    for (int i = 0; i < controller.tabs.length; i++) {
      bool selected = controller.currentPage == i;
      tabs.add(Expanded(
        flex: selected ? 4 : 3,
        child: FxContainer(
          onTap: () {
            // controller.onPageChanged(i, fromUser: true);
          },
          color: selected ? const Color(0xff1529e8) : theme.cardTheme.color,
          paddingAll: 12,
          borderRadiusAll: 0,
          child: Column(
            children: [
              Icon(
                controller.tabs[i].iconData,
                size: 20,
                color: selected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onBackground,
              ),
              FxText.bodySmall(
                controller.tabs[i].name,
                fontWeight: 600,
                color: selected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onBackground,
              ),
            ],
          ),
        ),
      ));
    }

    return Row(
      children: tabs,
    );
  }

  Widget shippingInfo() {
    return Container(
      padding: FxSpacing.x(20),
      child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxText.labelLarge(
              'Personal Details',
              fontWeight: 600,
            ),
            FxSpacing.height(20),
            Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FxText.bodyLarge(
                            'First Name',
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ),
                        ),
                      ),
                    ),
                    FxSpacing.height(10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: theme.cardTheme.color,
                                // color: const Color(0xff1529e8),
                                borderRadius: BorderRadius.circular(4)),
                            // height: 45.0,
                            // width: 80,
                            height: 50,
                            width: 100,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: FxText.labelLarge(
                                        "Choose",
                                        fontWeight: 600,
                                        color: Colors.black,
                                        // color: theme.colorScheme.onPrimary,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ],
                                ),
                                items: controller.nameCodes.map((String value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                        child: Text(
                                          value,
                                          style: FxTextStyle.bodyMedium(),
                                        ),
                                      ));
                                }).toList(),

                                value: controller.selectedname,
                                onChanged: (value) {
                                  setState(() {
                                    controller.selectedname = value.toString();
                                  });
                                },

                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 20,
                                iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.black,
                                buttonHeight: 30,
                                buttonWidth: 200,
                                buttonPadding: const EdgeInsets.only(
                                    left: 14, right: 14, top: 4, bottom: 4),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: theme.cardTheme.color,
                                ),

                                itemHeight: 40,
                                // itemWidth: 200,
                                itemPadding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                dropdownMaxHeight: 200,
                                dropdownPadding: null,

                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 2,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(0, 0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SlideTransition(
                              position: controller.firstnameAnimation,
                              child: TextFormField(
                                style: FxTextStyle.bodyMedium(),
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    isDense: true,
                                    // fillColor: theme.cardTheme.color,
                                    fillColor: Colors.white,
                                    hintText: "First Name",
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    contentPadding: FxSpacing.all(16),
                                    hintStyle: FxTextStyle.bodyMedium(),
                                    isCollapsed: true),
                                maxLines: 1,
                                controller: controller.FnameTE,
                                // validator: controller.validateName,
                                cursorColor: theme.colorScheme.onBackground,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    FxSpacing.height(20),
                    FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FxText.bodyLarge(
                            'Last Name',
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ),
                        ),
                      ),
                    ),
                    FxSpacing.height(10),
                    SlideTransition(
                      position: controller.lastnameAnimation,
                      child: TextFormField(
                        style: FxTextStyle.bodyMedium(),
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            isDense: true,
                            fillColor: Colors.white,
                            // prefixIcon: Icon(
                            //   FeatherIcons.user,
                            //   color: theme.colorScheme.onBackground,
                            // ),
                            hintText: "Last Name",
                            // enabledBorder: outlineInputBorder,
                            // focusedBorder: outlineInputBorder,
                            // border: outlineInputBorder,
                            enabledBorder: outlineInputBorderenable,
                            focusedBorder: outlineInputBorderfocus,
                            border: outlineInputBorderenable,
                            contentPadding: FxSpacing.all(16),
                            hintStyle: FxTextStyle.bodyMedium(),
                            isCollapsed: true),
                        maxLines: 1,
                        controller: controller.LnameTE,
                        // validator: controller.validateName,
                        cursorColor: theme.colorScheme.onBackground,
                      ),
                    ),
                    FxSpacing.height(20),
                    FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FxText.bodyLarge(
                            'Email',
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ),
                        ),
                      ),
                    ),
                    FxSpacing.height(10),
                    SlideTransition(
                      position: controller.emailAnimation,
                      child: TextFormField(
                        style: FxTextStyle.bodyMedium(),
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            isDense: true,
                            fillColor: Colors.white,
                            // prefixIcon: Icon(
                            //   FeatherIcons.user,
                            //   color: theme.colorScheme.onBackground,
                            // ),
                            hintText: "Email",
                            // enabledBorder: outlineInputBorder,
                            // focusedBorder: outlineInputBorder,
                            // border: outlineInputBorder,
                            enabledBorder: outlineInputBorderenable,
                            focusedBorder: outlineInputBorderfocus,
                            border: outlineInputBorderenable,
                            contentPadding: FxSpacing.all(16),
                            hintStyle: FxTextStyle.bodyMedium(),
                            isCollapsed: true),
                        maxLines: 1,
                        controller: controller.emailTE,
                        // validator: controller.validateName,
                        cursorColor: theme.colorScheme.onBackground,
                      ),
                    ),
                    FxSpacing.height(20),
                    FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FxText.bodyLarge(
                            'Select Nationality',
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ),
                        ),
                      ),
                    ),
                    FxSpacing.height(10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.black),
                          // color: const Color(0xff1529e8),
                          borderRadius: BorderRadius.circular(4)),
                      height: 45.0,
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Row(
                            children: [
                              Expanded(
                                child: FxText.labelLarge(
                                  "Choose Your Country",
                                  fontWeight: 600,
                                  color: Colors.black,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                          items: countryList.isNotEmpty &&
                                  countryList.first.countries.isNotEmpty
                              ? countryList.first.countries.map((value) {
                                  return DropdownMenuItem<String>(
                                      value: value.id.toString(),
                                      child: Center(
                                        child: Text(
                                          value.countryName.toString(),
                                          style: FxTextStyle.bodyMedium(),
                                        ),
                                      ));
                                }).toList()
                              : [].map((value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(
                                        child: Text(
                                          value,
                                          style: FxTextStyle.bodyMedium(),
                                        ),
                                      ));
                                }).toList(),
                          // value: controller.selectedCountryCode,
                          // value: controller.selectedCountryCode1,
                          value: controller.selectedCountryName,
                          onChanged: (value) {
                            setState(() {
                              log('Country name:${value.toString()}');
                              controller.selectedCountryName = value.toString();
                              // controller.selectedNameCountry = value.toString();
                              // controller.selectedcountry = value.toString();
                            });
                          },
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 20,
                          iconEnabledColor: Colors.black,
                          iconDisabledColor: Colors.black,
                          buttonHeight: 30,
                          buttonWidth: 200,
                          buttonPadding: const EdgeInsets.only(
                              left: 14, right: 14, top: 4, bottom: 4),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: theme.cardTheme.color,
                          ),
                          itemHeight: 40,
                          itemPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                          dropdownMaxHeight: 200,
                          dropdownPadding: null,
                          scrollbarRadius: const Radius.circular(40),
                          scrollbarThickness: 2,
                          scrollbarAlwaysShow: true,
                          offset: const Offset(0, 0),
                        ),
                      ),
                    ),
                    FxSpacing.height(20),
                    FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FxText.bodyLarge(
                            'Phone',
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ),
                        ),
                      ),
                    ),
                    FxSpacing.height(10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(width: 1, color: Colors.black)),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: theme.cardTheme.color,
                                // color: const Color(0xff1529e8),
                                borderRadius: BorderRadius.circular(4)),
                            // height: 45.0,
                            // width: 80,
                            height: 50,
                            width: 100,
                            // margin: const EdgeInsets.all(3.0),
                            //width: 300.0,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: FxText.labelLarge(
                                        "Code",
                                        fontWeight: 600,
                                        color: Colors.black,
                                        // color: theme.colorScheme.onPrimary,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                  ],
                                ),
                                items:
                                    // controller.countryCodes.map
                                    // _countryCodes.map
                                    countryList.isNotEmpty &&
                                            countryList
                                                .first.countries.isNotEmpty
                                        ? countryList.first.countries
                                            .map((value) {
                                            return DropdownMenuItem<String>(
                                                value: value.id.toString(),
                                                child: Center(
                                                  child: Text(
                                                    value.phonecode.toString(),
                                                    style: FxTextStyle
                                                        .bodyMedium(),
                                                  ),
                                                ));
                                          }).toList()
                                        : [].map((value) {
                                            return DropdownMenuItem<String>(
                                                value: value,
                                                child: Center(
                                                  child: Text(
                                                    value,
                                                    style: FxTextStyle
                                                        .bodyMedium(),
                                                  ),
                                                ));
                                          }).toList(),

                                value: controller.selectedCountryCode,

                                onChanged: (value) {
                                  setState(() {
                                    log(value.toString());
                                    controller.selectedCountryCode =
                                        value.toString();
                                    // _selectedCountryCode = value.toString();
                                  });
                                },

                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 20,
                                iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.black,
                                buttonHeight: 30,
                                buttonWidth: 200,
                                buttonPadding: const EdgeInsets.only(
                                    left: 14, right: 14, top: 4, bottom: 4),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: theme.cardTheme.color,
                                ),
                                // .
                                // copyWith(
                                //   boxShadow:
                                //       kElevationToShadow[
                                //           2],
                                // ),
                                itemHeight: 40,
                                // itemWidth: 200,
                                itemPadding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                dropdownMaxHeight: 200,
                                dropdownPadding: null,

                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 2,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(0, 0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SlideTransition(
                              position: controller.phoneAnimation,
                              child: TextFormField(
                                style: FxTextStyle.bodyMedium(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    filled: true,
                                    isDense: true,
                                    // fillColor: theme.cardTheme.color,
                                    fillColor: Colors.white,
                                    hintText: "Phone Number",
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    contentPadding: FxSpacing.all(16),
                                    hintStyle: FxTextStyle.bodyMedium(),
                                    isCollapsed: true),
                                maxLines: 1,
                                controller: controller.phoneTE,
                                cursorColor: theme.colorScheme.onBackground,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FxSpacing.height(20),
                    FadeTransition(
                      opacity: controller.fadeAnimation,
                      child: Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FxText.bodyLarge(
                            'Special Request',
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ),
                        ),
                      ),
                    ),
                    FxSpacing.height(10),
                    SlideTransition(
                      position: controller.reqAnimation,
                      child: TextFormField(
                        style: FxTextStyle.bodyMedium(),
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            isDense: true,
                            fillColor: Colors.white,
                            // prefixIcon: Icon(
                            //   FeatherIcons.user,
                            //   color: theme.colorScheme.onBackground,
                            // ),
                            hintText: "Special Request",
                            enabledBorder: outlineInputBorderenable,
                            focusedBorder: outlineInputBorderfocus,
                            border: outlineInputBorderenable,
                            // enabledBorder: outlineInputBorder,
                            // focusedBorder: outlineInputBorder,
                            // border: outlineInputBorder,
                            contentPadding: FxSpacing.all(16),
                            hintStyle: FxTextStyle.bodyMedium(),
                            isCollapsed: true),
                        maxLines: 4,
                        controller: controller.reqTE,
                        // validator: controller.validateName,
                        keyboardType: TextInputType.multiline,

                        cursorColor: theme.colorScheme.onBackground,
                      ),
                    ),
                    FxSpacing.height(20),
                  ],
                )),

            //btn
            Row(
              children: [
                Expanded(
                  child: FxButton(
                    padding: FxSpacing.y(12),
                    onPressed: () {
                      controller.nextPage();
                      // controller.nextPage(selectedExcursions, context,
                      //     widget.totalAmount, controller.token);
                    },
                    borderRadiusAll: 4,
                    elevation: 0,
                    splashColor: theme.colorScheme.onPrimary.withAlpha(30),
                    backgroundColor: const Color(0xff1529e8),
                    child: FxText.labelMedium(
                      'Proceed to Payment',
                      color: theme.colorScheme.onPrimary,
                      fontWeight: 600,
                    ),
                  ),
                ),
              ],
            ),
          ]),
    );
  }

  String? rateconversion1;
  Widget paymentInfo() {
    // String? rateconversion;
    // if (widget.totalAmount != null) {
    //   log('amount not equal:${widget.totalAmount}');
    //   if (conversionRate != null) {
    //     log('ConersionRate:$conversionRate');
    //     rateconversion1 =
    //         ((widget.totalAmount! * conversionRate!)).toStringAsFixed(2);
    //     log('Rate:$rateconversion');
    //   }
    // }
    return Container(
      padding: FxSpacing.x(20),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FxSpacing.height(20),

          //bill
          // _billingWidget(),
          Ticket(),
          FxSpacing.height(20),
          FxText.bodyLarge(
            'Select Payment Method',
            fontWeight: 800,
          ),
          FxSpacing.height(12),
          FxDashedDivider(
            dashSpace: 4,
            dashWidth: 8,
            color: theme.colorScheme.onBackground.withAlpha(180),
            height: 1.2,
          ),
          FxSpacing.height(20),

          //tpdo
          getSinglePayment(
              index: 1,
              method: "CCavenue",
              image: 'assets/images/apps/shopping2/icons/cc-avenue.png'),
          // getSinglePayment(
          //     index: 2,
          //     method: "RazorPay",
          //     image: 'assets/images/apps/shopping2/icons/razor_logo.png'),

          //demo
//           payment(
//               "assets/images/apps/shopping2/icons/razor_logo.png", "RazorPay"),
// //cc
//           payment(
//               "assets/images/apps/shopping2/icons/razor_logo.png", "CCavenue"),
          FxSpacing.height(20),
          FxButton.block(
            onPressed: () {
              // controller.selectedPayment == 1
              //     ? controller.nextPage(
              //         selectedExcursions, context, widget.totalAmount)
              //     : ScaffoldMessenger.of(context).showSnackBar(
              //         const SnackBar(content: Text('Select payment method')));
              // controller.selectedPayment == 1
              //     ? controller.nextPage(
              //         selectedExcursions, context, widget.totalAmount)
              //     : controller.selectedPayment == 2
              //         ? controller.nextPage(
              //             selectedExcursions, context, widget.totalAmount)
              //         : ScaffoldMessenger.of(context).showSnackBar(
              //             const SnackBar(
              //                 content: Text('Select payment method')));
              //todo
              token == null
                  ? controller.Login()
                  : controller.selectedPayment == 1
                      ? controller.nextPage()
                      : controller.selectedPayment == 2
                          ? controller.nextPage()
                          : CustomSnackbar.show(
                              context: context,
                              message: 'Select payment method',
                              backgroundColor: const Color(0xff1529e8),
                              duration: const Duration(seconds: 2),
                            );
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
                // conversionRate == null
                //     ? FxText.bodyMedium(
                //         '0 AED',
                //         fontWeight: 700,
                //         color: theme.colorScheme.onPrimary,
                //       )
                //     :
                FxText.bodyMedium(
                  '180 AED',
                  fontWeight: 700,
                  color: theme.colorScheme.onPrimary,
                )
              ],
            ),
          ),

          FxSpacing.height(10),

          //continue
          token == null
              ? FxButton.block(
                  onPressed: () {
                    controller.selectedPayment == 1
                        ? controller.nextPage()
                        : controller.selectedPayment == 2
                            ? controller.nextPage()
                            : CustomSnackbar.show(
                                context: context,
                                message: 'Select payment method',
                                backgroundColor: const Color(0xff1529e8),
                                duration: const Duration(seconds: 2),
                              );
                    // : ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //         content: Text('Select payment method')));
                  },
                  borderRadiusAll: 4,
                  elevation: 0,
                  splashColor: const Color(0xff1529e8).withAlpha(40),
                  backgroundColor: const Color(0xff1529e8).withAlpha(40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Payment Without Login',
                        fontWeight: 600,
                        color: const Color(0xff1529e8),
                        // color: theme.colorScheme.onPrimary,
                      ),
                      FxText.bodyMedium(
                        // ' ${widget.totalAmount} AED',
                        '$rateconversion1 AED',
                        // '${((widget.totalAmount! * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                        // '${widget.selectedtourOption.first.GrandTotalAmount}',
                        // '${widget.totalAmount} AED',
                        // widget.finalAmount.toString(),
                        // widget.TotalCalculation.toString(),
                        // controller1.grandSelectedTourAmount().toString(),
                        fontWeight: 700,
                        color: const Color(0xff1529e8),
                        // color: theme.colorScheme.onPrimary,
                      ),
                    ],
                  ),
                )
              : const SizedBox(),

          FxSpacing.height(80),
        ],
      ),
    );
  }

  Widget placedInfo() {
    return Padding(
      padding: FxSpacing.x(20),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          // Container(
          //     margin: FxSpacing.all(20),
          //     child: Image(
          //       image: AssetImage(Images.shoppingOrderSuccess),
          //     )),
          Lottie.asset('assets/lottie/confirmation.json',
              height: 300, width: 300),
          FxSpacing.height(20),
          FxText.titleLarge(
            'Booking Success!!',
            fontWeight: 700,
            textAlign: TextAlign.center,
          ),
          FxSpacing.height(8),
          FxText.labelLarge(
            'Enjoy Your \nVaccation, thanks for Booking',
            textAlign: TextAlign.center,
            xMuted: true,
          ),
          FxSpacing.height(24),
          FxButton.block(
            onPressed: () {
              controller.goBack();
            },
            borderRadiusAll: 4,
            elevation: 0,
            splashColor: const Color(0xff1529e8).withAlpha(30),
            backgroundColor: const Color(0xff1529e8),
            child: FxText.labelLarge(
              'Back To Home',
              color: theme.colorScheme.onPrimary,
              fontWeight: 600,
            ),
          ),
        ],
      ),
    );
  }

  Widget payment(String image, String title) {
    return FxContainer.bordered(
        paddingAll: 12,
        // color: Colors.white,
        color: controller.selected
            ? const Color(0xff1529e8).withAlpha(40)
            : Colors.white,
        child: controller.selected
            ? Row(
                children: [
                  Image(
                    height: 24,
                    image: AssetImage(image),
                  ),
                  FxSpacing.height(8),
                  FxText.bodySmall(title),
                  Expanded(
                    child: Align(
                      alignment: Language.autoDirection<AlignmentGeometry>(
                          Alignment.centerRight, Alignment.centerLeft)!,
                      child: FxContainer.roundBordered(
                        paddingAll: 4,
                        border: Border.all(
                          // color: theme.colorScheme.primary
                          color: const Color(0xff1529e8),
                        ),
                        color: const Color(0xff1529e8).withAlpha(40),
                        // color: theme.colorScheme.primary.withAlpha(40),
                        child: const Icon(
                          Icons.check,
                          color: Color(0xff1529e8),
                          // color: theme.colorScheme.primary,
                          size: 10,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Row(
                children: [
                  Image(
                    height: 24,
                    image: AssetImage(image),
                  ),
                  FxSpacing.height(8),
                  FxText.bodySmall(title),
                ],
              ));
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

  Widget Ticket() {
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 15),
            child: TicketView(
              ticket_map: ticketList[0],
              iscolorful: true,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          ticket_code(
            bigtext1: "Flutter Dash",
            smalltext1: "Passenger",
            bigtext2: "5456775433",
            smalltext2: "Passport",
          ),
          Container(
              height: 10,
              width: 50,
              // color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(color: Colors.white),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    children: List.generate(
                        (constraints.constrainWidth() / 15).floor(),
                        (index) => SizedBox(
                              height: 1,
                              width: 5,
                              child: DecoratedBox(
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade300),
                              ),
                            )),
                  );
                },
              )),
          ticket_code(
            bigtext1: "0055 9887 6554",
            smalltext1: "Number of  E-tickets",
            bigtext2: "B2SJ28",
            smalltext2: "Booking code",
          ),
          const dash_lines_code(),
          Container(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 50,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/visa.png"))),
                        ),
                        Text(
                          "***2462",
                          style: Styles.headlinestyle3,
                        )
                      ],
                    ),
                    const Gap(5),
                    Text(
                      "Payment Method",
                      style: Styles.headlinestyle4,
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$249.99",
                      style: Styles.headlinestyle3,
                    ),
                    Text(
                      "Price",
                      style: Styles.headlinestyle4,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.white,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(50)

                    ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BarcodeWidget(
                    height: 70,
                    barcode: Barcode.code128(),
                    data:
                        'https://www.linkedin.com/in/abhishek-bhadane-124b13209/',
                    drawText: false,
                  ),
                ),
              )),
          const Gap(20),
          Container(
            padding: const EdgeInsets.only(right: 20, left: 10),
            child: TicketView(ticket_map: ticketList[0]),
          )
        ],
      ),
    );
  }
}
