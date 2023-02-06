import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

import '../controllers/checkout_controller.dart';
import '../images.dart';
import '../localizations/language.dart';
import '../models/shipping_address.dart';
import '../theme/app_theme.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late CheckOutController controller;
  // late OutlineInputBorder outlineInputBorder;
  late OutlineInputBorder outlineInputBorderenable;
  late OutlineInputBorder outlineInputBorderfocus;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(CheckOutController(this));
    // outlineInputBorder = const OutlineInputBorder(
    //   borderRadius: BorderRadius.all(Radius.circular(4)),
    //   borderSide: BorderSide(
    //       // color: Colors.transparent,
    //       width: 1,
    //       color: Colors.black),
    // );
    outlineInputBorderenable = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.black),
    );
    outlineInputBorderfocus = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Color(0xff1529e8)),
    );
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

  Widget _billingWidget() {
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
                FxText.bodyMedium(
                  // '\$' + controller.order.precise,
                  'IMG Worlds of Adventure',
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
                FxText.bodyMedium(
                  // '\$' + controller.order.precise,
                  'without',
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
                  // '\$' + controller.order.precise,
                  '2023-01-31',
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
                FxText.bodyMedium(
                  // '\$' + controller.order.precise,
                  '1 adult',
                  fontWeight: 700,
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
              ? theme.colorScheme.primary
              : theme.colorScheme.onBackground),
      color: selected
          ? theme.colorScheme.primary.withAlpha(40)
          : theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                shippingAddress.icon,
                size: 20,
                color: theme.colorScheme.onBackground.withAlpha(220),
              ),
              FxSpacing.width(12),
              FxText.bodyMedium(
                shippingAddress.type,
                fontWeight: 700,
              ),
              FxSpacing.width(12),
              shippingAddress.isDefault
                  ? FxContainer(
                      borderRadiusAll: 4,
                      padding: FxSpacing.xy(8, 4),
                      color: theme.colorScheme.primary,
                      child: FxText.bodySmall(
                        'Default',
                        color: theme.colorScheme.onPrimary,
                        fontSize: 11,
                      ),
                    )
                  : Container(),
              selected
                  ? Expanded(
                      child: Align(
                        alignment: Language.autoDirection<AlignmentGeometry>(
                            Alignment.centerRight, Alignment.centerLeft)!,
                        child: FxContainer.roundBordered(
                          paddingAll: 4,
                          border: Border.all(color: theme.colorScheme.primary),
                          color: theme.colorScheme.primary.withAlpha(40),
                          child: Icon(
                            Icons.check,
                            color: theme.colorScheme.primary,
                            size: 10,
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          FxSpacing.height(8),
          FxText.bodySmall(
            shippingAddress.name,
            fontWeight: 600,
          ),
          FxSpacing.height(4),
          FxText.bodySmall(
            shippingAddress.number,
            fontWeight: 600,
          ),
          FxSpacing.height(8),
          FxText.bodySmall(
            shippingAddress.address,
            muted: true,
          ),
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
                    physics: const NeverScrollableScrollPhysics(),
                    // physics: const ClampingScrollPhysics(),
                    controller: controller.pageController,
                    onPageChanged: (int page) {
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
      child: ListView(physics: const AlwaysScrollableScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FxText.labelLarge(
              'Passenger Details',
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
                            'Select(Mr/Mrs/Ms)',
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
                          border: Border.all(width: 1, color: Colors.black),
                          // color: theme.cardTheme.color,
                          color: Colors.white,
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
                            value: controller.selectedname,
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
                            onChanged: (value) {
                              setState(() {
                                controller.selectedname = value.toString();
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
                    FxSpacing.height(20),
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
                    SlideTransition(
                      position: controller.firstnameAnimation,
                      child: TextFormField(
                        style: FxTextStyle.bodyMedium(),
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            isDense: true,
                            // fillColor: theme.cardTheme.color,
                            fillColor: Colors.white,
                            // prefixIcon: Icon(
                            //   FeatherIcons.user,
                            //   color: theme.colorScheme.onBackground,
                            // ),
                            hintText: "First Name",
                            // enabledBorder: outlineInputBorder,
                            // focusedBorder: outlineInputBorder,
                            // border: outlineInputBorder,
                            enabledBorder: outlineInputBorderenable,
                            focusedBorder: outlineInputBorderfocus,
                            border: outlineInputBorderenable,

                            // enabledBorder: const OutlineInputBorder(
                            //   borderSide:
                            //       BorderSide(width: 1, color: Colors.red),
                            // ),
                            // focusedBorder: const OutlineInputBorder(
                            //   borderSide:
                            //       BorderSide(width: 1, color: Colors.indigo),
                            // ),
                            // border: const OutlineInputBorder(
                            //   borderSide:
                            //       BorderSide(width: 1, color: Colors.black),
                            // ),
                            contentPadding: FxSpacing.all(16),
                            hintStyle: FxTextStyle.bodyMedium(),
                            isCollapsed: true),
                        maxLines: 1,
                        controller: controller.FnameTE,
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
                            'Select Country',
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
                            value: controller.selectedcountry,
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
                            items: controller.countryCodes.map((String value) {
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
                                controller.selectedcountry = value.toString();
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
                            hintText: "Phone",
                            enabledBorder: outlineInputBorderenable,
                            focusedBorder: outlineInputBorderfocus,
                            border: outlineInputBorderenable,
                            // enabledBorder: outlineInputBorder,
                            // focusedBorder: outlineInputBorder,
                            // border: outlineInputBorder,
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
            // ...controller.addressList!
            //     .map((shippingAddress) =>
            //         _buildSingleShippingAddress(shippingAddress))
            //     .toList(),
            // Row(
            //   children: [
            //     FxButton(
            //       padding: FxSpacing.xy(16, 12),
            //       onPressed: () {},
            //       borderRadiusAll: 4,
            //       elevation: 0,
            //       splashColor: theme.colorScheme.primary.withAlpha(30),
            //       backgroundColor: theme.colorScheme.primaryContainer,
            //       // backgroundColor: theme.colorScheme.primaryContainer,
            //       child: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           const Icon(
            //             FeatherIcons.plus,
            //             color: Color(0xff1529e8),
            //             size: 18,
            //           ),
            //           FxSpacing.width(8),
            //           FxText.labelMedium(
            //             'Shipping Address',
            //             color: const Color(0xff1529e8),
            //             fontWeight: 600,
            //           ),
            //         ],
            //       ),
            //     ),
            //     FxSpacing.width(20),
            //     Expanded(
            //       child: FxButton(
            //         padding: FxSpacing.y(12),
            //         onPressed: () {
            //           controller.nextPage();
            //         },
            //         borderRadiusAll: 4,
            //         elevation: 0,
            //         splashColor: theme.colorScheme.onPrimary.withAlpha(30),
            //         backgroundColor: const Color(0xff1529e8),
            //         child: FxText.labelMedium(
            //           'Proceed to Payment',
            //           color: theme.colorScheme.onPrimary,
            //           fontWeight: 600,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            //btn
            Row(
              children: [
                // FxButton(
                //   padding: FxSpacing.xy(16, 12),
                //   onPressed: () {},
                //   borderRadiusAll: 4,
                //   elevation: 0,
                //   splashColor: theme.colorScheme.primary.withAlpha(30),
                //   backgroundColor: theme.colorScheme.primaryContainer,
                //   // backgroundColor: theme.colorScheme.primaryContainer,
                //   child: Row(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       const Icon(
                //         FeatherIcons.plus,
                //         color: Color(0xff1529e8),
                //         size: 18,
                //       ),
                //       FxSpacing.width(8),
                //       FxText.labelMedium(
                //         'Shipping Address',
                //         color: const Color(0xff1529e8),
                //         fontWeight: 600,
                //       ),
                //     ],
                //   ),
                // ),
                // FxSpacing.width(20),
                Expanded(
                  child: FxButton(
                    padding: FxSpacing.y(12),
                    onPressed: () {
                      controller.nextPage();
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

  Widget paymentInfo() {
    return Container(
      padding: FxSpacing.x(20),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FxText.labelLarge(
            'Select payment method',
            fontWeight: 600,
          ),
          FxSpacing.height(20),
          FxContainer.bordered(
            onTap: () {
              controller.selectPaymentMethod(1);
            },
            borderRadiusAll: 4,
            margin: FxSpacing.bottom(20),
            border: Border.all(
                color: controller.paymentMethodSelected == 1
                    ? const Color(0xff1529e8)
                    : theme.colorScheme.onBackground),
            color: controller.paymentMethodSelected == 1
                ? const Color(0xff1529e8).withAlpha(40)
                : theme.scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      FeatherIcons.creditCard,
                      size: 20,
                      color: theme.colorScheme.onBackground.withAlpha(220),
                    ),
                    FxSpacing.width(8),
                    FxText.bodyMedium(
                      'Credit Card',
                      fontWeight: 700,
                    ),
                    controller.paymentMethodSelected == 1
                        ? Expanded(
                            child: Align(
                              alignment:
                                  Language.autoDirection<AlignmentGeometry>(
                                      Alignment.centerRight,
                                      Alignment.centerLeft)!,
                              child: FxContainer.roundBordered(
                                paddingAll: 4,
                                border:
                                    Border.all(color: const Color(0xff1529e8)),
                                color: const Color(0xff1529e8).withAlpha(40),
                                child: const Icon(
                                  Icons.check,
                                  color: Color(0xff1529e8),
                                  size: 10,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                FxSpacing.height(8),
                FxText.bodySmall(
                  'Nency AnGhan',
                  fontWeight: 600,
                ),
                FxSpacing.height(4),
                FxText.bodySmall(
                  '**** **** **** 7865',
                  fontWeight: 600,
                ),
                FxSpacing.height(4),
                FxText.bodySmall(
                  'Expiry: 06/25',
                  fontWeight: 600,
                ),
                FxSpacing.height(20),
                FxText.bodySmall(
                  'Secure checkout powered by OnePay',
                  muted: true,
                ),
              ],
            ),
          ),
          // FxContainer.bordered(
          //   onTap: () {
          //     controller.selectPaymentMethod(2);
          //   },
          //   borderRadiusAll: 4,
          //   margin: FxSpacing.bottom(20),
          //   border: Border.all(
          //       color: controller.paymentMethodSelected == 2
          //           ? theme.colorScheme.primary
          //           : theme.colorScheme.onBackground),
          //   color: controller.paymentMethodSelected == 2
          //       ? theme.colorScheme.primary.withAlpha(40)
          //       : theme.scaffoldBackgroundColor,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         children: [
          //           Icon(
          //             FeatherIcons.dollarSign,
          //             size: 18,
          //             color: theme.colorScheme.onBackground.withAlpha(220),
          //           ),
          //           FxSpacing.width(8),
          //           FxText.bodyMedium(
          //             'Cash on delivery',
          //             fontWeight: 700,
          //           ),
          //           controller.paymentMethodSelected == 2
          //               ? Expanded(
          //                   child: Align(
          //                     alignment:
          //                         Language.autoDirection<AlignmentGeometry>(
          //                             Alignment.centerRight,
          //                             Alignment.centerLeft)!,
          //                     child: FxContainer.roundBordered(
          //                       paddingAll: 4,
          //                       border: Border.all(
          //                           color: theme.colorScheme.primary),
          //                       color: theme.colorScheme.primary.withAlpha(40),
          //                       child: Icon(
          //                         Icons.check,
          //                         color: theme.colorScheme.primary,
          //                         size: 10,
          //                       ),
          //                     ),
          //                   ),
          //                 )
          //               : Container(),
          //         ],
          //       ),
          //       FxSpacing.height(8),
          //       FxText.bodySmall(
          //         'Additional \$ 20 charges for COD services.',
          //         muted: true,
          //       ),
          //     ],
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FxText.labelLarge(
                'Do you have promo code?',
                fontWeight: 700,
              ),
              FxSpacing.width(20),
              FxContainer.bordered(
                // padding: FxSpacing.xy(16, 12),
                onTap: () {
                  controller.addCart
                      ? controller.cartController.reverse()
                      : controller.cartController.forward();
                  // controller.showcode = !controller.showcode;
                  // log(controller.showcode.toString());
                  // // controller.showcode();
                  // log('message');
                },
                borderRadiusAll: 4,
                // elevation: 0,
                splashColor: const Color(0xff1529e8).withAlpha(30),
                // color: const Color(0xff1529e8),
                color: const Color(0xff1529e8).withAlpha(40),
                border: Border.all(color: const Color(0xff1529e8)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FxText.labelMedium(
                      'Promo Code',
                      // color: Colors.white,
                      color: const Color(0xff1529e8),
                      fontWeight: 600,
                    ),
                    const Icon(
                      FeatherIcons.arrowDown,
                      color: Color(0xff1529e8),
                      // color: Colors.white,
                      size: 18,
                    ),
                    // FxSpacing.width(8),
                  ],
                ),
              ),
            ],
          ),
          FxSpacing.height(20),
          //code
          controller.addCart
              ? FxContainer(
                  paddingAll: 12,
                  borderRadiusAll: 4,
                  child: Row(
                    children: [
                      // Icon(
                      //   FeatherIcons.creditCard,
                      //   size: 18,
                      //   color: theme.colorScheme.primary,
                      // ),
                      // FxSpacing.width(16),
                      Expanded(
                        child: SlideTransition(
                          position: controller.promoAnimation,
                          child: TextFormField(
                            style: FxTextStyle.bodyMedium(),
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                filled: true,
                                isDense: true,
                                fillColor: Colors.white,
                                // fillColor: Colors.white
                                // prefixIcon: Icon(
                                //   FeatherIcons.user,
                                //   color: theme.colorScheme.onBackground,
                                // ),
                                hintText: "Enter Promo Code",
                                enabledBorder: outlineInputBorderenable,
                                focusedBorder: outlineInputBorderfocus,
                                border: outlineInputBorderenable,
                                // enabledBorder: outlineInputBorder,
                                // focusedBorder: outlineInputBorder,
                                // border: outlineInputBorder,
                                contentPadding: FxSpacing.all(16),
                                hintStyle: FxTextStyle.bodyMedium(),
                                isCollapsed: true),
                            maxLines: 1,
                            controller: controller.promoTE,
                            // validator: controller.validateName,
                            cursorColor: theme.colorScheme.onBackground,
                          ),
                        ),
                        //     child: FxText.labelLarge(
                        //   'Black Friday Promo',
                        //   fontWeight: 600,
                        // )
                      ),
                      FxSpacing.width(16),
                      // FxContainer(
                      //   borderRadiusAll: 2,
                      //   padding: FxSpacing.xy(8, 4),
                      //   color: theme.colorScheme.primary.withAlpha(40),
                      //   child: FxText.bodySmall(
                      //     'BLCK20',
                      //     color: theme.colorScheme.primary,
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Container(),
                      // ),

                      Expanded(
                        child: FxButton.block(
                          onPressed: () {},
                          borderRadiusAll: 4,
                          elevation: 0,
                          splashColor: const Color(0xff1529e8).withAlpha(40),
                          backgroundColor: const Color(0xff1529e8),
                          child: FxText.bodyMedium(
                            'Redeem',
                            fontWeight: 600,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          FxSpacing.height(20),
          // FxContainer(
          //   paddingAll: 12,
          //   borderRadiusAll: 4,
          //   child: Row(
          //     children: [
          //       Icon(
          //         FeatherIcons.creditCard,
          //         size: 18,
          //         color: theme.colorScheme.primary,
          //       ),
          //       FxSpacing.width(16),
          //       Expanded(
          //           child: FxText.labelLarge(
          //         'Cyber Week Deal',
          //         fontWeight: 600,
          //       )),
          //       FxSpacing.width(16),
          //       FxContainer(
          //         borderRadiusAll: 2,
          //         padding: FxSpacing.xy(8, 4),
          //         color: theme.colorScheme.primary.withAlpha(40),
          //         child: FxText.bodySmall(
          //           'CYBR00',
          //           color: theme.colorScheme.primary,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          //bill
          _billingWidget(),
          FxSpacing.height(20),
          FxButton.block(
            onPressed: () {
              controller.nextPage();
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
                  '\$ 251.55',
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

  Widget placedInfo() {
    return Padding(
      padding: FxSpacing.x(20),
      child: Column(
        children: [
          Container(
              margin: FxSpacing.all(20),
              child: Image(
                image: AssetImage(Images.shoppingOrderSuccess),
              )),
          FxSpacing.height(20),
          FxText.titleLarge(
            'Booking Success!!',
            fontWeight: 700,
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
}
