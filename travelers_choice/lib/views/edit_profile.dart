import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/extensions/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../theme/constant.dart';
import '../controllers/edit_profile_controller.dart';
import '../loading_effect.dart';
import '../models/Country_modal.dart';
import '../services/app_constants.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late EditProfileController controller;
  late OutlineInputBorder outlineInputBorder;

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
    controller = FxControllerStore.putOrFind(EditProfileController());
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  bool isLoading = true;

  fetchData() {
    Future.delayed(Duration.zero, () async {
      await getCountryList().then((value) {
        if (value) {
          log('message');
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
        log('1');
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
    return FxBuilder<EditProfileController>(
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
          children: [
            Center(
              child: FxContainer(
                color: Colors.transparent,
                paddingAll: 0,
                height: 100,
                width: 100,
                // child: Stack(
                //   clipBehavior: Clip.none,
                //   children: [
                //     ClipRRect(
                //       clipBehavior: Clip.antiAliasWithSaveLayer,
                //       borderRadius: const BorderRadius.all(Radius.circular(60)),
                //       // child: Image(
                //       //   height: 100,
                //       //   width: 100,
                //       //   image: AssetImage(Images.learningProfile),
                //       //   fit: BoxFit.cover,
                //       // ),
                //       child: SizedBox(
                //         height: 100,
                //         width: 100,
                //         child: CircleAvatar(
                //           backgroundColor:
                //               theme.colorScheme.primary.withAlpha(28),
                //           child: FxText.bodyLarge(controller.name![0],
                //               color: theme.colorScheme.primary,
                //               fontWeight: 600),
                //         ),
                //       ),
                //     ),
                //     Positioned(
                //       bottom: 0,
                //       left: Language.autoDirection(null, 0),
                //       right: Language.autoDirection(0),
                //       child: FxCard(
                //         paddingAll: 2,
                //         borderRadiusAll: 4,
                //         clipBehavior: Clip.none,
                //         child: FxContainer(
                //           paddingAll: 4,
                //           borderRadiusAll: 4,
                //           color: theme.colorScheme.primaryContainer,
                //           child: Icon(
                //             Icons.camera_alt,
                //             size: 16,
                //             color: theme.colorScheme.primary,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                //todo
                child: ClipRRect(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  borderRadius: const BorderRadius.all(Radius.circular(60)),
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary.withAlpha(28),
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
              controller: controller.mobileTE,
              validator: controller.validatePhone,
              cursorColor: theme.colorScheme.onBackground,
            ),

            FxSpacing.height(20),
            FxText.bodyMedium(
              'Country',
            ),
            FxSpacing.height(8),

            // FxTextField(
            //   controller: controller.addressTE,
            //   floatingLabelBehavior: FloatingLabelBehavior.never,
            //   autoFocusedBorder: true,
            //   autoIcon: false,
            //   textFieldStyle: FxTextFieldStyle.outlined,
            //   textFieldType: FxTextFieldType.name,
            //   filled: true,
            //   isDense: true,
            //   isCollapsed: true,
            //   labelText: 'Address',
            //   maxLines: 1,
            //   labelStyle: FxTextStyle.bodySmall(xMuted: true),
            //   fillColor: theme.colorScheme.primaryContainer,
            //   focusedBorderColor: theme.colorScheme.primary,
            //   enabledBorderColor: theme.colorScheme.primary,
            //   labelTextColor: theme.colorScheme.onBackground,
            //   cursorColor: theme.colorScheme.onBackground,
            //   focusedBorderRadius: Constant.textFieldRadius.medium,
            //   enabledBorderRadius: Constant.textFieldRadius.medium,
            // ),
            GestureDetector(
              onTap: () {
                log('Clicked');
                // log(countryList.first.countries
                //     .map((e) => e.countryName)
                //     .toString());
                countryList.isNotEmpty && countryList.first.countries.isNotEmpty
                    ? log(countryList.first.countries.first.countryName)
                    : log('empty');
              },
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                          child: FxText.labelLarge(
                            // "Code",
                            'India',
                            fontWeight: 600,
                            color: Colors.black,
                            // color: theme.colorScheme.onPrimary,
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

                    value: controller.selectedCountryCode,

                    onChanged: (value) {
                      setState(() {
                        log(value.toString());
                        controller.selectedCountryCode = value.toString();
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
                      // border: Border.all(
                      //     color: AppColor
                      //         .Secondary1,
                      //     width: 1),
                      // color: const Color(0xff2C2138),
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
            ),
            FxSpacing.height(60),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           FxText.bodyMedium(
            //             'Gender',
            //           ),
            //           FxSpacing.height(8),
            //           Row(
            //             children: [
            //               FxContainer.rounded(
            //                 onTap: () {
            //                   controller.changeGender(Gender.male);
            //                 },
            //                 paddingAll: 12,
            //                 color: controller.gender == Gender.male
            //                     ? theme.colorScheme.primary
            //                     : theme.colorScheme.primaryContainer,
            //                 child: Icon(
            //                   Icons.male,
            //                   color: controller.gender == Gender.male
            //                       ? theme.colorScheme.onPrimary
            //                       : theme.colorScheme.onBackground
            //                           .withAlpha(150),
            //                 ),
            //               ),
            //               FxSpacing.width(20),
            //               FxContainer.rounded(
            //                 onTap: () {
            //                   controller.changeGender(Gender.female);
            //                 },
            //                 paddingAll: 12,
            //                 color: controller.gender == Gender.female
            //                     ? theme.colorScheme.primary
            //                     : theme.colorScheme.primaryContainer,
            //                 child: Icon(
            //                   Icons.female,
            //                   color: controller.gender == Gender.female
            //                       ? theme.colorScheme.onPrimary
            //                       : theme.colorScheme.onBackground
            //                           .withAlpha(150),
            //                 ),
            //               ),
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //     FxSpacing.width(20),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           FxText.bodyMedium(
            //             'Age',
            //           ),
            //           FxSpacing.height(8),
            //           FxTextField(
            //             controller: controller.ageTE,
            //             floatingLabelBehavior: FloatingLabelBehavior.never,
            //             autoFocusedBorder: true,
            //             autoIcon: false,
            //             textFieldStyle: FxTextFieldStyle.outlined,
            //             textFieldType: FxTextFieldType.mobileNumber,
            //             filled: true,
            //             isDense: true,
            //             isCollapsed: true,
            //             labelText: 'Age',
            //             maxLines: 1,
            //             labelStyle: FxTextStyle.bodySmall(xMuted: true),
            //             fillColor: theme.colorScheme.primaryContainer,
            //             focusedBorderColor: theme.colorScheme.primary,
            //             enabledBorderColor: theme.colorScheme.primary,
            //             labelTextColor: theme.colorScheme.onBackground,
            //             cursorColor: theme.colorScheme.onBackground,
            //             focusedBorderRadius: Constant.textFieldRadius.medium,
            //             enabledBorderRadius: Constant.textFieldRadius.medium,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // FxSpacing.height(20),
            FxButton.block(
              onPressed: () async {
                log('Name:${controller.nameTE.text}');
                log('Email:${controller.emailTE.text}');
                log('Country:${controller.countryId}');
                log('Mobile:${controller.mobileTE.text}');
                log('Token:${controller.token}');
                var result = await controller.patchEdit(
                    controller.nameTE.text,
                    controller.emailTE.text,
                    controller.countryId!,
                    controller.mobileTE.text,
                    controller.token!,
                    context);

                controller.goBack(canRefresh: result);
                // controller.updateProfile(
                //     controller.nameTE.text,
                //     controller.emailTE.text,
                //     controller.countryId!,
                //     controller.mobileTE.text,
                //     controller.token!,
                //     context);
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
          ],
        ),
      );
    }
  }
}
