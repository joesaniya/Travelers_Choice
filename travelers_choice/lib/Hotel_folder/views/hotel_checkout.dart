import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/hotel_checkout_controller.dart';
import '/card_widgets/customsnackbar.dart';
import '/localizations/language.dart';
import '/models/Country_modal.dart';
import '/models/shipping_address.dart';
import '/services/app_constants.dart';
import '/services/auth_service.dart';
import '/theme/app_theme.dart';
import 'package:lottie/lottie.dart';

class HotelCheckOutScreen extends StatefulWidget {
  @override
  Key? key;
  // VoidCallback finalAmount;

  HotelCheckOutScreen({super.key});

  @override
  _HotelCheckOutScreenState createState() => _HotelCheckOutScreenState();
}

class _HotelCheckOutScreenState extends State<HotelCheckOutScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late CustomTheme customTheme;

  late HotelCheckOutController controller;
  // late ActivityController controller1;
  // late OutlineInputBorder outlineInputBorder;
  late OutlineInputBorder outlineInputBorderenable;
  late OutlineInputBorder outlineInputBorderfocus;
  List? selectedExcursions;
  String? token;
  @override
  void initState() {
    super.initState();
    initializingData();
    customTheme = AppTheme.customTheme;

    fetchData();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(HotelCheckOutController(this));

    outlineInputBorderenable = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.black),
    );
    outlineInputBorderfocus = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Color(0xff1529e8)),
    );
  }

  String? currencySymbol;
  double? conversionRate;

  void initializingData() {
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        token = sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN);
        log('checkout Toen:$token');
        conversionRate = sharedPrefValue.getDouble(AppConstants.rate);
        log('conversionRate:$conversionRate');
        currencySymbol = sharedPrefValue.getString(AppConstants.symbol);
        log('currencySymbol:$currencySymbol');
      });
    });
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

  String? rateconversion;
  String? rateselectedtourOption;
  Widget _billingWidget() {
    List<Widget> list = [];
    log('message');
    // log(widget.length.toString());
    return SizedBox(
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        // itemCount: widget.length,
        itemCount: 2,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // String? rateconversion;
          // String? rateselectedtourOption;
          // log('amount not equal:${widget.totalAmount}');
          if (conversionRate != null) {
            log('ConersionRate:$conversionRate');
            // rateconversion = ((widget.selectedtourOption[index].grandTotal *
            //         conversionRate!))
            //     .toStringAsFixed(2);
            // log('Rate:$rateconversion');
            // rateselectedtourOption =
            //     ((widget.selectedtourOption[index].grandTotal *
            //             conversionRate!))
            //         .toStringAsFixed(2);
          }
          return FadeTransition(
            opacity: controller.fadeAnimation,
            child: FxContainer(
              borderRadiusAll: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.bodyMedium(
                    'Your Booking Details',
                    muted: true,
                    fontWeight: 700,
                  ),
                  FxSpacing.height(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Check-in',
                        fontWeight: 600,
                      ),
                      // FxSpacing.width(20),
                      // Expanded(child: Container()),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyMedium(
                          'June 14,2023',
                          fontWeight: 700,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  FxSpacing.height(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Check-Out',
                        fontWeight: 600,
                      ),
                      FxText.bodyMedium(
                        'June 16,2023',
                        fontWeight: 700,
                      ),
                    ],
                  ),
                  FxSpacing.height(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Total length of Stay:',
                        fontWeight: 600,
                      ),
                      FxText.bodyMedium(
                        '2 Nights & 3 Days',
                        fontWeight: 700,
                      ),
                    ],
                  ),
                  FxSpacing.height(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'You Selected:',
                        fontWeight: 600,
                      ),
                      Expanded(child: Container()),
                      FxContainer(
                        padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                        color: const Color(0xff1529e8).withAlpha(40),
                        child:
                            FxText.bodyMedium('twin guest room with room only',
                                color: const Color(0xff1529e8),
                                // color: customTheme.groceryPrimary,
                                fontWeight: 500,
                                letterSpacing: -0.2),
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
                        // rateconversion.toString(),
                        '1317.57 AED',
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
                        // '$rateconversion $currencySymbol',
                        '1317.57 AED',
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

    // for (var dataselect in controller1.selectedtour.length) {
    //   list.add(FadeTransition);
    // }
    // return Column(
    //   children: list,
    // );
  }

  Widget _buildSingleShippingAddress(ShippingAddress shippingAddress) {
    bool selected = controller.addressSelected == shippingAddress;
    return FxContainer.bordered(
      onTap: () {
        controller.selectShippingAddress(shippingAddress);
      },
      borderRadiusAll: 4,
      margin: FxSpacing.bottom(20),
      border: Border.all(
          color: selected
              ? const Color(0xff1529e8)
              : theme.colorScheme.onBackground),
      color: selected
          ? const Color(0xff1529e8).withAlpha(40)
          : theme.scaffoldBackgroundColor,
      child: Row(
        children: [
          // Image(
          //   height: 24,
          //   image: AssetImage(image),
          // ),
          FxSpacing.height(8),
          FxText.bodySmall(
            shippingAddress.name,
          ),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<HotelCheckOutController>(
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
                      controller.nextPage(context, controller.token);
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
    // if (widget.totalAmount = null) {
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
          _billingWidget(),
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
          //delivery
          // ...controller.addressList!
          //     .map((shippingAddress) =>
          //         _buildSingleShippingAddress(shippingAddress))
          //     .toList(),

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
              token == null
                  ? controller.Login()
                  : controller.selectedPayment == 1
                      ? controller.nextPage(context, controller.token)
                      : controller.selectedPayment == 2
                          ? controller.nextPage(context, controller.token)
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
                conversionRate == null
                    ? FxText.bodyMedium(
                        '0 AED',
                        fontWeight: 700,
                        color: theme.colorScheme.onPrimary,
                      )
                    : FxText.bodyMedium(
                        '1317.57 AED',
                        // '$rateconversion1 $currencySymbol',

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
                        ? controller.nextPage(context, controller.token)
                        : controller.selectedPayment == 2
                            ? controller.nextPage(context, controller.token)
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
                        '1317.57 AED',
                        // '$rateconversion1 $currencySymbol',

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
}
