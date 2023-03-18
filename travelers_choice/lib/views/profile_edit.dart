import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/extensions/extensions.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Country_modal.dart';
import '../../services/auth_service.dart';
import '../controllers/edit_controller.dart';
import '../loading_effect.dart';
import '../services/app_constants.dart';
import '../theme/constant.dart';
import '/theme/app_theme.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late EditController controller;

  late OutlineInputBorder outlineInputBorder;
  // final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  //manual
  final TextEditingController _phnocontroller = TextEditingController();
  final bool _isLoading = false;

  String? _selectedCountryCode;
  final List<String> _countryCodes = ['+91', '+23'];

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        controller.name =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN_Name);
        log(controller.name.toString());
        controller.email =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN_Email);
        log(controller.email.toString());
        controller.phoneNumber =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN_Phone);
        log('Ph Number:${controller.phoneNumber.toString()}');
        log('username');
        controller.token =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN)!;
        log(controller.token!);
        controller.countryId =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN_countryId)!;
        log(controller.countryId.toString());
      });
    });

    theme = AppTheme.learningTheme;

    controller = FxControllerStore.put(EditController(this));

    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

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
    return FxBuilder<EditController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
        body: Padding(
          padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
          child: LoadingEffect.getSearchLoadingScreen(context),
        ),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: FxText.bodyLarge(
            'Edit Profile',
            fontWeight: 600,
          ),
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              controller.goBack(canRefresh: true);
            },
            child: const Icon(
              FeatherIcons.chevronLeft,
              size: 20,
            ).autoDirection(),
          ),
        ),
        body: ListView(
            padding: FxSpacing.nTop(20),

            // padding: FxSpacing.fromLTRB(
            //     20, FxSpacing.safeAreaTop(context) + 48, 20, 20),

            children: [
              Center(
                child: FxContainer(
                  color: Colors.transparent,
                  paddingAll: 0,
                  height: 100,
                  width: 100,

                  //todo
                  child: ClipRRect(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: const BorderRadius.all(Radius.circular(60)),
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        backgroundColor:
                            theme.colorScheme.primary.withAlpha(28),
                        child: FxText.bodyLarge(
                          controller.name![0],
                          color: theme.colorScheme.primary,
                          fontWeight: 600,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FxSpacing.height(20),
              FxText.bodyMedium(
                'Your Name',
              ),
              FxSpacing.height(8),
              TextFormField(
                style: FxTextStyle.bodyMedium(),
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    isDense: true,
                    fillColor: theme.cardTheme.color,
                    hintText: "Name",
                    labelText: controller.name,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: outlineInputBorder,
                    contentPadding: FxSpacing.all(16),
                    hintStyle: FxTextStyle.bodyMedium(),
                    isCollapsed: true),
                maxLines: 1,
                controller: controller.nameTE,
                validator: controller.validateName,
                cursorColor: theme.colorScheme.onBackground,
              ),
              FxSpacing.height(20),
              FxText.bodyMedium(
                'Email',
              ),
              FxSpacing.height(8),
              TextFormField(
                style: FxTextStyle.bodyMedium(),
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    isDense: true,
                    fillColor: theme.cardTheme.color,
                    hintText: "Email",
                    labelText: controller.email,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: outlineInputBorder,
                    contentPadding: FxSpacing.all(16),
                    hintStyle: FxTextStyle.bodyMedium(),
                    isCollapsed: true),
                maxLines: 1,
                controller: controller.emailTE,
                validator: controller.validateEmail,
                cursorColor: theme.colorScheme.onBackground,
              ),
              FxSpacing.height(20),
              FxText.bodyMedium(
                'Mobile Number',
              ),
              FxSpacing.height(8),
              TextFormField(
                style: FxTextStyle.bodyMedium(),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    isDense: true,
                    fillColor: theme.cardTheme.color,
                    hintText: "Phone",
                    labelText: controller.phoneNumber,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: outlineInputBorder,
                    contentPadding: FxSpacing.all(16),
                    hintStyle: FxTextStyle.bodyMedium(),
                    isCollapsed: true),
                maxLines: 1,
                controller: controller.phoneTE,
                validator: controller.validatePhone,
                cursorColor: theme.colorScheme.onBackground,
              ),
              FxSpacing.height(20),
              FxText.bodyMedium(
                'Country',
              ),
              FxSpacing.height(8),
              Container(
                decoration: BoxDecoration(
                    color: theme.cardTheme.color,
                    // color: const Color(0xff1529e8),
                    borderRadius: BorderRadius.circular(0)),
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
                            "India",
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
                                        // style: const TextStyle(
                                        //     color: Colors.black,
                                        //     fontSize: 20,
                                        //     fontWeight:
                                        //         FontWeight.w500),
                                      ),
                                    ));
                              }).toList(),

                    value: controller.selectedCountryCode,

                    onChanged: (value) {
                      setState(() {
                        log('Value:${value.toString()}');
                        controller.selectedCountryCode = value.toString();
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

                    itemHeight: 40,
                    // itemWidth: 200,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 200,
                    dropdownPadding: null,

                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 2,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(0, 0),
                  ),
                ),
              ),
              FxSpacing.height(60),
              FxButton.block(
                onPressed: () async {
                  print('Name:${controller.nameTE.text}');
                  print('Email:${controller.emailTE.text}');
                  print('Country:${controller.selectedCountryCode}');
                  // print('Country:${controller.countryId}');
                  print('Mobile:${controller.phoneTE.text}');
                  print('Token:${controller.token}');
                  var result = await controller.patchEdit(
                      controller.nameTE.text,
                      controller.emailTE.text,
                      // controller.countryId!,
                      controller.selectedCountryCode.toString(),
                      controller.phoneTE.text,
                      controller.token!,
                      context);

                  controller.goBack(canRefresh: result);
                },
                elevation: 0,
                borderRadiusAll: Constant.buttonRadius.large,
                splashColor: theme.colorScheme.onPrimary.withAlpha(40),
                backgroundColor: theme.colorScheme.primary,
                child: FxText.bodyMedium(
                  'Submit',
                  fontWeight: 600,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ]),
      );
    }
  }
}
