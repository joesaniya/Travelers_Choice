import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../card_widgets/customsnackbar.dart';
import '../../controllers/visa_enquire_bottom_controller.dart';
import '../../models/Country_modal.dart';
import '../../services/auth_service.dart';
import '../../theme/app_theme.dart';

class VisaEnquireBottom extends StatefulWidget {
  const VisaEnquireBottom({super.key});

  @override
  State<VisaEnquireBottom> createState() => _VisaEnquireBottomState();
}

class _VisaEnquireBottomState extends State<VisaEnquireBottom>
    with TickerProviderStateMixin {
  late VisaEnquireBottomController controller;
  late ThemeData theme, theme1;
  late CustomTheme customTheme;
  late OutlineInputBorder outlineInputBorderenable;
  late OutlineInputBorder outlineInputBorderfocus;

  @override
  void initState() {
    super.initState();
    fetchData();
    theme = AppTheme.shoppingTheme;
    theme1 = AppTheme.learningTheme;
    customTheme = AppTheme.customTheme;
    controller = FxControllerStore.put(VisaEnquireBottomController(this));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // addCategories();
    });
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
    Size size = MediaQuery.of(context).size;
    return FxBuilder<VisaEnquireBottomController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    return Container(
        height: MediaQuery.of(context).size.height * 65 / 100,
        padding: FxSpacing.xy(24, 16),
        decoration: const BoxDecoration(
            // color: customTheme.card,
            color: Color(0xfff5f5f5),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FxText.bodyLarge(
                  'Enquire',
                  fontWeight: 800,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    FeatherIcons.x,
                  ),
                )
              ],
            ),
            FxSpacing.height(10),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    // color: customTheme.card,
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13))),
                padding: FxSpacing.xy(6, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView(
                        padding: FxSpacing.all(20),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff31C631)),
                                child: const Icon(
                                  FontAwesomeIcons.whatsapp,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff1529e8)),
                                child: const Icon(
                                  Icons.mail,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: const Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          FxSpacing.height(20),
                          FadeTransition(
                            opacity: controller.fadeAnimation,
                            child: Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: FxText.bodyLarge(
                                  'Name',
                                  // textAlign: TextAlign.left,
                                  letterSpacing: 0,
                                  fontWeight: 600,
                                ),
                              ),
                            ),
                          ),
                          FxSpacing.height(10),
                          SlideTransition(
                            position: controller.titleANimation,
                            child: TextFormField(
                              style: FxTextStyle.bodyMedium(),
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  filled: true,
                                  isDense: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Your Name..",
                                  enabledBorder: outlineInputBorderenable,
                                  focusedBorder: outlineInputBorderfocus,
                                  border: outlineInputBorderenable,
                                  contentPadding: FxSpacing.all(16),
                                  hintStyle: FxTextStyle.bodyMedium(),
                                  isCollapsed: true),
                              controller: controller.titleTE,
                              keyboardType: TextInputType.text,
                              cursorColor: theme.colorScheme.onBackground,
                            ),
                          ),
                          FxSpacing.height(20),

                          //notes
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
                            position: controller.reqAnimation,
                            child: TextFormField(
                              style: FxTextStyle.bodyMedium(),
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  filled: true,
                                  isDense: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Your Email Id..",
                                  enabledBorder: outlineInputBorderenable,
                                  focusedBorder: outlineInputBorderfocus,
                                  border: outlineInputBorderenable,
                                  contentPadding: FxSpacing.all(16),
                                  hintStyle: FxTextStyle.bodyMedium(),
                                  isCollapsed: true),
                              controller: controller.reqTE,
                              keyboardType: TextInputType.emailAddress,
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
                                  'Whatsapp Number',
                                  // textAlign: TextAlign.left,
                                  letterSpacing: 0,
                                  fontWeight: 600,
                                ),
                              ),
                            ),
                          ),
                          FxSpacing.height(10),
                          SlideTransition(
                            position: controller.whatsappnumberAnimation,
                            child: TextFormField(
                              style: FxTextStyle.bodyMedium(),
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  filled: true,
                                  isDense: true,
                                  fillColor: Colors.white,
                                  hintText: "Enter Your Whatsapp Number..",
                                  enabledBorder: outlineInputBorderenable,
                                  focusedBorder: outlineInputBorderfocus,
                                  border: outlineInputBorderenable,
                                  contentPadding: FxSpacing.all(16),
                                  hintStyle: FxTextStyle.bodyMedium(),
                                  isCollapsed: true),
                              controller: controller.whatsappnumberTE,
                              keyboardType: TextInputType.phone,
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
                                  'Nationality',
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
                                border:
                                    Border.all(width: 1, color: Colors.black),
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
                                value: controller.selectedCountryName,
                                onChanged: (value) {
                                  setState(() {
                                    log('Country name:${value.toString()}');
                                    controller.selectedCountryName =
                                        value.toString();
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
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: FxContainer.none(
                            onTap: () async {
                              if (controller.titleTE.text.isEmpty ||
                                      controller.reqTE.text.isEmpty ||
                                      controller
                                          .whatsappnumberTE.text.isEmpty ||
                                      controller.selectedCountryName == null ||
                                      controller.selectedCountryName!.isEmpty
                                  // controller.ratingValue == null
                                  ) {
                                // log('empty');
                                CustomSnackbar.show(
                                  context: context,
                                  message: 'Please Enter Required Fields..',
                                  backgroundColor: const Color(0xff1529e8),
                                  duration: const Duration(seconds: 2),
                                );
                              } else {
                                log('filled');
                              }
                            },
                            padding: FxSpacing.y(12),
                            // color: theme.colorScheme.primary,
                            color: const Color(0xff1529e8),
                            child: Center(
                              child: FxText(
                                "Enquire Now",
                                color: theme.colorScheme.onPrimary,
                                fontWeight: 600,
                              ),
                            ),
                          )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
