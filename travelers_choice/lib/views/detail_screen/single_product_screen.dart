import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/controllers/saved_controller.dart';
import 'package:hotel_travel/views/detail_screen/review_Screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../controllers/attraction_Controller.dart';
import '../../controllers/single_product_controller.dart';
import '../../loading_effect.dart';

import '../../models/atteraction_model.dart';
import '../../models/product.dart';
import '../../theme/app_theme.dart';

class SingleProductScreen extends StatefulWidget {
  final String productid;

  const SingleProductScreen(
    this.productid, {
    Key? key,
  }) : super(key: key);

  @override
  _SingleProductScreenState createState() => _SingleProductScreenState();
}

class _SingleProductScreenState extends State<SingleProductScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late SingleProductController controller;
  late SavedController cartController;
  late OutlineInputBorder outlineInputBorder;

  bool isLoading = true;

  List<DetailattractionModal> detailattraction = <DetailattractionModal>[];

  getDetailAttraction() {
    log('getDetail Attraction function called');
    Future.delayed(Duration.zero, () async {
      await AttractionController()
          .getDetailattractionList(productid: widget.productid)
          .then((value) {
        // if (value) {
        //   isLoading = false;
        //   setState(() {});
        // }
      });
    });
  }

  @override
  void initState() {
    // product = controller.products as Product;
    super.initState();
    getDetailAttraction();
    theme = AppTheme.shoppingTheme;
    controller = FxControllerStore.put(SingleProductController(
      this,
      //  widget.productid
    ));
    outlineInputBorder = const OutlineInputBorder(
        borderSide: BorderSide(
            color: Color(0xff1529e8),
            // color: Colors.lightBlueAccent,
            width: 0));
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
                  // '\$' + controller.order.precise,
                  // controller.product.title,
                  controller.detailattraction.first.title,
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
                //         controller.increment(controller.product.);
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

  // Widget _buildProductList() {
  //   List<Widget> list = [];

  //   list.add(FxSpacing.width(20));

  //   for (Product product in controller.products!) {
  //     if (controller.product == product) continue;
  //     list.add(FxContainer(
  //       onTap: () {
  //         // controller.goToSingleProduct(product);
  //       },
  //       borderRadiusAll: 8,
  //       paddingAll: 8,
  //       width: 150,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           FxContainer(
  //             paddingAll: 0,
  //             borderRadiusAll: 4,
  //             clipBehavior: Clip.antiAliasWithSaveLayer,
  //             child: Stack(
  //               children: [
  //                 Image(
  //                   image: AssetImage(product.image),
  //                   height: 140,
  //                   fit: BoxFit.cover,
  //                 ),
  //                 const Positioned(
  //                   right: 8,
  //                   top: 8,
  //                   child: Icon(
  //                     Icons.favorite_outline,
  //                     size: 20,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           FxSpacing.height(8),
  //           FxText.labelLarge(
  //             product.name,
  //             fontWeight: 600,
  //           ),
  //           FxSpacing.height(4),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               FxText.labelLarge(
  //                 '\$${product.price}',
  //                 fontWeight: 700,
  //               ),
  //               const FxContainer.bordered(
  //                 paddingAll: 2,
  //                 borderRadiusAll: 4,
  //                 child: Icon(
  //                   FeatherIcons.plus,
  //                   size: 12,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ));
  //     list.add(FxSpacing.width(20));
  //   }

  //   return Row(
  //     children: list,
  //   );
  // }

  Widget _buildSizeWidget() {
    List<Widget> list = [];

    for (String size in controller.sizes) {
      bool selected = size == controller.selectedSize;
      list.add(
        FxContainer.roundBordered(
          paddingAll: 8,
          width: 36,
          height: 36,
          onTap: () {
            controller.selectSize(size);
          },
          border: Border.all(
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onBackground),
          color: selected ? theme.colorScheme.primary : null,
          child: Center(
            child: FxText.bodySmall(
              size,
              fontWeight: 600,
              color: selected
                  ? theme.colorScheme.onSecondary
                  : theme.colorScheme.onBackground,
            ),
          ),
        ),
      );

      list.add(FxSpacing.width(8));
    }

    return Wrap(
      children: list,
    );
  }

  //opton
  Widget _buildoption() {
    List<Widget> list = [];

    for (Product product in controller.products!) {
      // bool selected = size == controller.selectedSize;
      bool increaseAble = controller.increaseAble(product);
      bool decreaseAble = controller.decreaseAble(product);
      list.add(FadeTransition(
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
                    // '\$' + controller.order.precise,
                    controller.detailattraction.first.title,
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
                          // onTap: () async {
                          //   DateTime? pickedDate = await showDatePicker(
                          //       context: context,
                          //       initialDate: DateTime.now(),
                          //       firstDate: DateTime(
                          //           1900), //DateTime.now() - not to allow to choose before today.
                          //       lastDate: DateTime(2101));

                          //   if (pickedDate != null) {
                          //     print(
                          //         pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          //     String formattedDate =
                          //         DateFormat('yyyy-MM-dd').format(pickedDate);
                          //     print(
                          //         formattedDate); //formatted date output using intl package =>  2021-03-16
                          //     //you can implement different kind of Date Format here according to your requirement

                          //     setState(() {
                          //       dateinput.text =
                          //           formattedDate; //set output date to TextField value.
                          //     });
                          //   } else {
                          //     print("Date is not selected");
                          //   }
                          // },
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
                          controller.increment(product);
                        },
                        bordered: increaseAble,
                        paddingAll: 4,
                        borderRadiusAll: 2,
                        border: Border.all(color: theme.colorScheme.primary),
                        color: increaseAble
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onBackground.withAlpha(200),
                        child: Icon(
                          FeatherIcons.plus,
                          size: 12,
                          color: increaseAble
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onPrimary,
                        ),
                      ),
                      FxSpacing.height(8),
                      FxText.bodyMedium(
                        product.person.toString(),
                        fontWeight: 700,
                      ),
                      FxSpacing.height(8),
                      FxContainer(
                        onTap: () {
                          controller.decrement(product);
                        },
                        paddingAll: 4,
                        borderRadiusAll: 2,
                        bordered: decreaseAble,
                        border: Border.all(
                            color: theme.colorScheme.primary.withAlpha(120)),
                        color: decreaseAble
                            ? theme.colorScheme.primary.withAlpha(28)
                            : theme.colorScheme.onBackground.withAlpha(200),
                        child: Icon(
                          FeatherIcons.minus,
                          size: 12,
                          color: decreaseAble
                              ? theme.colorScheme.primary
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
      ));

      list.add(FxSpacing.width(8));
    }

    return Wrap(
      children: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<SingleProductController>(
        controller: controller,
        builder: (controller) {
          // return _buildBody();
          // return _buildbody2();
          // return _buildDetail();
          return _buildnew();
        });
  }

  Widget _buildnew() {
    if (detailattraction.isEmpty) {
      return Scaffold(
          // body: CircularProgressIndicator(),
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
      return Scaffold(
          backgroundColor: const Color(0xfff5f5f5),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
            child: FxButton.block(
              onPressed: () {
                controller.bookNow();
                // cartController.carts.add(Cart());
              },
              backgroundColor: const Color(0xff1529e8),
              // backgroundColor: customTheme.estatePrimary,
              borderRadiusAll: 12,

              elevation: 0,
              child: FxText.bodyMedium(
                'Add to Cart',
                color: Colors.white,
                // color: customTheme.estateOnPrimary,
                fontWeight: 700,
              ),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: PageView(
                      pageSnapping: true,
                      physics: const ClampingScrollPhysics(),
                      controller: controller.pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          controller.currentPage = page;
                        });
                      },
                      children: <Widget>[
                        Container(
                          child: Image(
                            image: const AssetImage(
                                // controller.product.image
                                './assets/images/apps/hotel/room-1.jpg'),
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child: Image(
                            image: const AssetImage(
                                // controller.product.images.first
                                './assets/images/apps/hotel/room-2.jpg'),
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child: Image(
                            image: const AssetImage(
                                './assets/images/apps/hotel/room-3.jpg'
                                // controller.product.image
                                ),
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 24,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        MdiIcons.chevronLeft,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              FxContainer(
                                borderRadiusAll: 10,
                                // padding: FxSpacing.xy(8, 4),
                                padding: FxSpacing.xy(6, 2),
                                // color: Color(0xff1529e8),
                                color: Colors.blueGrey,
                                child: FxText.bodySmall(
                                  // 'Theme Park',
                                  controller.detailattraction.first.title,
                                  // controller.product.bookingType.toString(),
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
                          FxSpacing.height(10),
                          FxText.titleMedium(
                              // controller.product.title,
                              controller.detailattraction.first.title,
                              fontWeight: 600,
                              letterSpacing: 0),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  MdiIcons.mapMarker,
                                  color: theme.colorScheme.onBackground,
                                  size: 16,
                                ),
                                Container(
                                    margin: const EdgeInsets.only(left: 2),
                                    child: FxText.bodySmall(
                                        controller.detailattraction.first.title,
                                        fontWeight: 500)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: const Color(0xff1529e8).withAlpha(24),
                            child: InkWell(
                              splashColor:
                                  const Color(0xff1529e8).withAlpha(100),
                              highlightColor:
                                  const Color(0xff1529e8).withAlpha(20),
                              child: SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: Icon(
                                    MdiIcons.shareOutline,
                                    size: 22,
                                    color:
                                        const Color(0xff1529e8).withAlpha(240),
                                  )),
                              onTap: () {},
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          child: ClipOval(
                            child: Material(
                              color: const Color(0xff1529e8).withAlpha(24),
                              child: InkWell(
                                highlightColor:
                                    const Color(0xff1529e8).withAlpha(20),
                                splashColor:
                                    const Color(0xff1529e8).withAlpha(100),
                                child: const SizedBox(
                                    width: 44,
                                    height: 44,
                                    child: Icon(
                                      MdiIcons.heartOutline,
                                      size: 20,
                                      color: Color(0xff1529e8),
                                    )),
                                onTap: () {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FxText.bodyMedium("Price", fontWeight: 500),
                        FxText.bodyMedium(
                            // "350 \$",
                            '${controller.detailattraction.first.title} AED',
                            // controller.product.price.toString(),
                            fontWeight: 700)
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FxText.bodyMedium("Rating", fontWeight: 500),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FxText.bodyMedium(
                                  controller.detailattraction.first.title,
                                  fontWeight: 700),
                              Container(
                                  margin: const EdgeInsets.only(left: 4),
                                  child: FxStarRating(rating: 4.1))
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    FxContainer(
                      onTap: () {
                        log('review Screen clicked');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReviewScreen()));
                      },
                      padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                      color: const Color(0xff1529e8).withAlpha(40),
                      // color:Color(0xff6874E8),
                      // customTheme.groceryPrimary.withAlpha(40),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FxText.bodyMedium("(243 review)",
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                          const Icon(
                            MdiIcons.chevronRight,
                            size: 14,
                            color: Color(0xff1529e8),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                // padding: const EdgeInsets.all(32.0),
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                    color: Color(0xfff5f5f5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Container(
                    //   // margin: const EdgeInsets.all(5.0),
                    //   // width: 800,
                    //   height: 100,
                    //   decoration: BoxDecoration(
                    //       // color: Color(0xffe6e1e5),
                    //       color: Colors.white,
                    //       // color: Color(0xffe5fdfd),
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(10)),
                    //       border:
                    //           Border.all(color: Colors.grey.shade300, width: 1)
                    //       // color: theme!.colorScheme.onPrimaryContainer,
                    //       ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //         child: Row(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Row(
                    //               children: [
                    //                 FxContainer(
                    //                   borderRadiusAll: 10,
                    //                   // padding: FxSpacing.xy(8, 4),
                    //                   padding: FxSpacing.xy(6, 2),
                    //                   // color: Color(0xff1529e8),
                    //                   color: Colors.blueGrey,
                    //                   child: FxText.bodySmall(
                    //                     // 'Theme Park',
                    //                     controller.product.types.toString(),
                    //                     fontWeight: 300,
                    //                     color: Colors.white,
                    //                     // color: theme.colorScheme.onPrimary,
                    //                   ),
                    //                 ),
                    //                 const SizedBox(
                    //                   width: 5,
                    //                 ),
                    //                 FxContainer(
                    //                   borderRadiusAll: 10,
                    //                   // padding: FxSpacing.xy(8, 4),
                    //                   padding: FxSpacing.xy(6, 2),
                    //                   // color: Color(0xff1529e8),
                    //                   color: Colors.blueGrey,
                    //                   child: FxText.bodySmall(
                    //                     'Ticket',
                    //                     fontWeight: 300,
                    //                     color: Colors.white,
                    //                     // color: theme.colorScheme.onPrimary,
                    //                   ),
                    //                 ),
                    //                 const SizedBox(
                    //                   width: 5,
                    //                 ),
                    //                 FxContainer(
                    //                   borderRadiusAll: 10,
                    //                   // padding: FxSpacing.xy(8, 4),
                    //                   padding: FxSpacing.xy(6, 2),
                    //                   // color: Color(0xff1529e8),
                    //                   color: Colors.blueGrey,
                    //                   child: FxText.bodySmall(
                    //                     'Offer',
                    //                     fontWeight: 300,
                    //                     color: Colors.white,
                    //                     // color: theme.colorScheme.onPrimary,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     const Icon(
                    //                       // FeatherIcons.star,
                    //                       Icons.star,
                    //                       color: Colors.yellow,
                    //                       size: 12,
                    //                     ),
                    //                     FxSpacing.width(4),
                    //                     FxText.bodySmall(
                    //                       // '4.5',
                    //                       controller.product.rating.toString(),
                    //                       fontWeight: 600,
                    //                       color: Colors.black,
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       // FxSpacing.height(20),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(horizontal: 8),
                    //         child: FxText.bodyLarge(
                    //           // 'Ferrari world',
                    //           controller.product.name.toString(),
                    //           fontWeight: 800,
                    //         ),
                    //       ),
                    //       // FxSpacing.height(10),
                    //       Padding(
                    //         // padding: EdgeInsets.symmetric(horizontal: 0),
                    //         padding: const EdgeInsets.only(right: 8),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 FxContainer(
                    //                   borderRadiusAll: 8,
                    //                   padding: FxSpacing.xy(8, 4),
                    //                   // color: theme.colorScheme.primary,
                    //                   // color: Colors.yellow.shade400,
                    //                   color: Colors.white,
                    //                   child: Row(
                    //                     children: [
                    //                       const Icon(
                    //                         Iconsax.location,
                    //                         color: Colors.black,
                    //                         // color: theme.colorScheme.onPrimary,
                    //                         size: 12,
                    //                       ),
                    //                       FxSpacing.width(4),
                    //                       FxText.labelLarge(
                    //                         // '\$' + product.price.toString(),
                    //                         controller.product.location
                    //                             .toString(),
                    //                         // product.price.toString() + " " + "AED",
                    //                         // "\$" + product.price.toString() + "/hour",
                    //                         // fontWeight: 700,
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             FxText(
                    //               controller.product.price.toString(),
                    //               color: const Color(0xff1529e8),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // FxSpacing.height(15),
                    // Container(
                    //   height: 80,
                    //   decoration: BoxDecoration(
                    //       // color: Color(0xffe6e1e5),
                    //       color: Colors.white,
                    //       // color: Color(0xffe5fdfd),
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(10)),
                    //       border:
                    //           Border.all(color: Colors.grey.shade300, width: 1)
                    //       // color: theme!.colorScheme.onPrimaryContainer,
                    //       ),
                    //   padding: const EdgeInsets.only(left: 8.0, right: 8),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           FxText.labelLarge(
                    //             // '\$' + product.price.toString(),
                    //             'Per Person',
                    //             // product.price.toString() + " " + "AED",
                    //             // "\$" + product.price.toString() + "/hour",
                    //             // fontWeight: 700,
                    //           ),
                    //           FxText.bodyLarge(
                    //             // '\$140 ',
                    //             '140 AED ',
                    //             color: Colors.indigo,
                    //             fontWeight: 900,
                    //             // color: const Color(0xff1529e8),
                    //           ),
                    //         ],
                    //       ),
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           FxText.bodyMedium(
                    //             '4.5/5 - Good',
                    //             fontWeight: 900,
                    //             color: Colors.black,
                    //             // color: theme.colorScheme.onPrimary,
                    //           ),
                    //           FxContainer(
                    //             onTap: () {
                    //               log('review Screen clicked');
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) => ReviewScreen()));
                    //             },
                    //             padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                    //             color: const Color(0xff1529e8).withAlpha(40),
                    //             // color:Color(0xff6874E8),
                    //             // customTheme.groceryPrimary.withAlpha(40),
                    //             child: Row(
                    //               mainAxisSize: MainAxisSize.min,
                    //               children: [
                    //                 FxText.bodyMedium("(243 review)",
                    //                     color: const Color(0xff1529e8),
                    //                     // color: customTheme.groceryPrimary,
                    //                     fontWeight: 500,
                    //                     letterSpacing: -0.2),
                    //                 const Icon(
                    //                   MdiIcons.chevronRight,
                    //                   size: 14,
                    //                   color: Color(0xff1529e8),
                    //                 )
                    //               ],
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    //tabbar
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: TabBar(
                        controller: controller.tabController,
                        onTap: (index) {
                          setState(() {
                            controller.tabController.index = index;
                          });
                        },
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black.withOpacity(0.6),
                        labelStyle: const TextStyle(
                            fontFamily: 'inter', fontWeight: FontWeight.w500),
                        indicatorColor: Colors.black,
                        isScrollable: true,
                        tabs: const [
                          Tab(
                            text: 'Description',
                          ),
                          Tab(
                            text: 'Overview',
                          ),
                          Tab(
                            text: 'Highlights',
                          ),
                          Tab(
                            text: 'What At Dinner In The Sky?',
                          ),
                        ],
                      ),
                    ),

                    //indexedStack
                    IndexedStack(
                      index: controller.tabController.index,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: 1,
                          // itemCount: controller.product.description.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const Text('hi');
                            // return StepTile(
                            //   // data: widget.data.tutorial[index],
                            //   data: widget.product,
                            // );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: 1,
                          // itemCount: controller.product.description.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const Text('Text');
                            // return StepTile(
                            //   // data: widget.data.tutorial[index],
                            //   data: widget.product,
                            // );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: 1,
                          // itemCount: controller.product.description.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const Text('hi');
                            // return StepTile(
                            //   // data: widget.data.tutorial[index],
                            //   data: widget.product,
                            // );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: 1,
                          // itemCount: controller.product.description.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const Text('hi');
                            // return StepTile(
                            //   // data: widget.data.tutorial[index],
                            //   data: widget.product,
                            // );
                          },
                        ),
                      ],
                    ),

                    //touroption
                    FxSpacing.height(15),
                    _billingWidget(),
                    // _buildoption(),

                    //feaures
                    // FxSpacing.height(15),

                    // FxSpacing.height(15),
                    // Container(
                    //     decoration: BoxDecoration(
                    //         // color: Color(0xffe6e1e5),
                    //         color: Colors.white,
                    //         // color: Color(0xffe5fdfd),
                    //         borderRadius:
                    //             const BorderRadius.all(Radius.circular(10)),
                    //         border: Border.all(
                    //             color: Colors.grey.shade300, width: 1)),
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 8, vertical: 15),
                    //     child: Column(
                    //       children: [
                    //         Text(
                    //           "Description".toUpperCase(),
                    //           style: const TextStyle(
                    //               fontWeight: FontWeight.w600, fontSize: 14.0),
                    //         ),
                    //         const SizedBox(height: 10.0),
                    //         FxText.bodyLarge(
                    //           controller.product.description,
                    //           // "Lorem ipsum dolor sit, amet consectetur adipisicing elit. Ratione architecto autem quasi nisi iusto eius ex dolorum velit! Atque, veniam! Atque incidunt laudantium eveniet sint quod harum facere numquam molestias?",
                    //           textAlign: TextAlign.justify,
                    //           // style: TextStyle(
                    //           //     fontWeight: FontWeight.w300, fontSize: 14.0),
                    //         ),
                    //       ],
                    //     )),
                    FxSpacing.height(15),
                    Container(
                        decoration: BoxDecoration(
                            // color: Color(0xffe6e1e5),
                            color: Colors.white,
                            // color: Color(0xffe5fdfd),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact Details".toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14.0),
                            ),
                            const SizedBox(height: 10.0),
                            FxText.bodyLarge(
                              'Sheikh Zayed Rd - Dubai - United Arab Emirates\n www.dubaiparksandresorts.com \n ph.No:+9718002629464',
                              textAlign: TextAlign.justify,
                              // style: TextStyle(
                              //     fontWeight: FontWeight.w300, fontSize: 14.0),
                            ),
                          ],
                        )),

                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          ));
    }
  }
}
