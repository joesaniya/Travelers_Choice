import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/core/state_management/builder.dart';
import 'package:flutx/core/state_management/controller_store.dart';
import 'package:flutx/themes/text_style.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:im_stepper/stepper.dart';

import '../controllers/apply_visa_controller.dart';
import '../images.dart';
import '../localizations/language.dart';
import '../theme/app_theme.dart';

class ApplyVisa extends StatefulWidget {

  const ApplyVisa({Key? key,}) : super(key: key);

  @override
  State<ApplyVisa> createState() => _ApplyVisaState();
}

class _ApplyVisaState extends State<ApplyVisa>  with TickerProviderStateMixin{


  late ApplyVisaController controller;
  late ThemeData theme;
  TextEditingController nameController = TextEditingController();
  int activeIndex = 0;
  int totalIndex = 3;

  late FocusNode nameNode;

  late OutlineInputBorder outlineInputBorderenable;
  late OutlineInputBorder outlineInputBorderfocus;

String userName = "";
  @override
  void initState() {
    theme = AppTheme.shoppingTheme;
   controller = FxControllerStore.put(ApplyVisaController(this));

    super.initState();
    outlineInputBorderenable = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(width: 1, color: Colors.black),
    );
    outlineInputBorderfocus = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(width: 1, color: Color(0xff1529e8)),
    );

  }

  Widget buildTabs() {
    List<Widget> tabs = [];

    for (int i = 0; i < controller.tabs.length; i++) {
      bool selected = controller.currentPage == i;
      tabs.add(Expanded(
        flex:  4 ,
        child: Container(

          // onTap: () {
          //   // controller.onPageChanged(i, fromUser: true);
          // },

          // padding: EdgeInsets.all(12),
          // borderRadiusAll: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: selected ? const Color(0xff1529e8) : Colors.transparent,
          ),
          child: Center(
            child: FxText.bodySmall(
              controller.tabs[i].name,
              fontWeight: 600,
              color: selected
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onBackground,
            ),
          ),
        ),
      ));
    }

    return Row(
      children: tabs,
    );
  }


  @override
  Widget build(BuildContext context){
    return FxBuilder<ApplyVisaController>(
        controller: controller,
        builder: (controller) {
          return
            WillPopScope(
            onWillPop: () async {
              if (controller.currentPage != 0) {
                controller.currentPage --;
                setState(() {});
                return false;
              }
              return true;
            },
            child:
          Scaffold(
              backgroundColor: const Color(0xfff5f5f5),
              // backgroundColor: theme.scaffoldBackgroundColor,
              appBar: AppBar(
                elevation: 0,
                // centerTitle: true,
                title: FxText.titleMedium(
                  'Apply Visa',
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
              body:
              Column(
                children: [
                  FxSpacing.height(8),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.grey,

                      ),
                      height: MediaQuery.of(context).size.height*0.05,
                      width: MediaQuery.of(context).size.width *0.9,
                      // margin: FxSpacing.x(20),
                      // paddingAll: 0,
                      // borderRadiusAll: 4,
                      // clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: buildTabs(),
                    ),
                  ),
                  FxSpacing.height(20),
                  Expanded(
                    child: bodyBuilder(),
                  )
                  // Expanded(
                  //   child: PageView(
                  //     allowImplicitScrolling: true,
                  //     pageSnapping: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     // physics: const ClampingScrollPhysics(),
                  //     controller: controller.pageController,
                  //     onPageChanged: (int page) {
                  //       controller.onPageChanged(page);
                  //     },
                  //     children: [travellerDetails(), makePayment(), uploadDetails()],
                  //   ),
                  // ),
                ],
              ),
          ));
        });
  }
  Widget travellerDetails() {
    return Container(
      padding: FxSpacing.x(20),
      child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            // FxText.labelLarge(
            //   'Traveller Details',
            //   fontWeight: 600,
            // ),
            // FxSpacing.height(20),
            Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    // FadeTransition(
                    //   opacity: controller.fadeAnimation,
                    //   child:
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Mr/Mrs',
                          // textAlign: TextAlign.left,
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                        // ),
                      ),
                    ),
                    FxSpacing.height(10),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            iconSize: 25.0,
                            dropdownColor: Colors.white,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            value: controller.selectedname,
                            hint: Center(
                              child: FxText.labelLarge(
                                "Mr.",
                                fontWeight: 600,
                                color: Colors.black54,
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
                            style: FxTextStyle.bodyMedium(),
                          ),
                        ),
                      ),
                    ),
                    FxSpacing.height(20),
                    // FadeTransition(
                    //   opacity: controller.fadeAnimation,
                    //   child:
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'First Name',
                          fontWeight: 600,
                        ),
                        // ),
                      ),
                    ),
                    FxSpacing.height(10),
                    // SlideTransition(
                    //   position: controller.firstnameAnimation,
                    //   child:
                    TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            FeatherIcons.user,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "First Name",

                          enabledBorder: outlineInputBorderenable,
                          focusedBorder: outlineInputBorderfocus,
                          border: outlineInputBorderenable,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.FnameTE,
                      validator: controller.validateFirstName,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                    // ),
                    FxSpacing.height(20),
                    // FadeTransition(
                    //   opacity: controller.fadeAnimation,
                    //   child:
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Last Name',
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),
                      // ),
                    ),
                    FxSpacing.height(10),
                    // SlideTransition(
                    //   position: controller.lastnameAnimation,
                    //   child:
                    TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            FeatherIcons.user,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Last Name",
                          enabledBorder: outlineInputBorderenable,
                          focusedBorder: outlineInputBorderfocus,
                          border: outlineInputBorderenable,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.LnameTE,
                      validator: controller.validateLastName,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                    // ),
                    FxSpacing.height(20),
                    // FadeTransition(
                    //   opacity: controller.fadeAnimation,
                    //   child:
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Email',
                          // textAlign: TextAlign.left,
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),
                      // ),
                    ),
                    FxSpacing.height(10),
                    // SlideTransition(
                    //   position: controller.emailAnimation,
                    //   child:
                    TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Email",
                          enabledBorder: outlineInputBorderenable,
                          focusedBorder: outlineInputBorderfocus,
                          border: outlineInputBorderenable,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.emailTE,
                      validator: controller.validateEmail,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                    // ),
                    FxSpacing.height(20),
                    // FadeTransition(
                    //   opacity: controller.fadeAnimation,
                    //   child:
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Select Country',
                          // textAlign: TextAlign.left,
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),
                      // ),
                    ),
                    FxSpacing.height(10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(15)),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                            iconSize: 25.0,
                            dropdownColor: Colors.white,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black,
                            ),
                            value: controller.selectedcountry,
                            hint: Center(
                              child: FxText.labelLarge(
                                "Choose Country",
                                fontWeight: 600,
                                color: Colors.black54,
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
                            style: FxTextStyle.bodyMedium(),
                          ),
                        ),
                      ),
                    ),
                    FxSpacing.height(20),
                    // FadeTransition(
                    //   opacity: controller.fadeAnimation,
                    //   child:
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Contact Number',
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),
                      // ),
                    ),
                    FxSpacing.height(10),
                    // SlideTransition(
                    //   position: controller.emailAnimation,
                    //   child:
                    TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            FeatherIcons.phone,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Phone Number",
                          enabledBorder: outlineInputBorderenable,
                          focusedBorder: outlineInputBorderfocus,
                          border: outlineInputBorderenable,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.phoneTE,
                      validator: controller.validatePhone,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                    // ),
                    FxSpacing.height(20),
                    // FadeTransition(
                    //   opacity: controller.fadeAnimation,
                    //   child:
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Passport Number',
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),
                      // ),
                    ),
                    FxSpacing.height(10),
                    // SlideTransition(
                    //   position: controller.emailAnimation,
                    //   child:
                    TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            FeatherIcons.fileText,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Passport Number",
                          enabledBorder: outlineInputBorderenable,
                          focusedBorder: outlineInputBorderfocus,
                          border: outlineInputBorderenable,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.passportTE,
                      validator: controller.validatePassport,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                    // ),
                    FxSpacing.height(20),
                    // FadeTransition(
                    //   opacity: controller.fadeAnimation,
                    //   child:
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Address',
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),
                      // ),
                    ),
                    FxSpacing.height(10),
                    // SlideTransition(
                    //   position: controller.emailAnimation,
                    //   child:
                    TextFormField(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.location_on_outlined,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Address",
                          enabledBorder: outlineInputBorderenable,
                          focusedBorder: outlineInputBorderfocus,
                          border: outlineInputBorderenable,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.addressTE,
                      validator: controller.validateAddress,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                    // ),

                  ],
                )),
            FxSpacing.height(20),
            Row(
              children: [
                Expanded(
                  child: FxButton(
                    padding: FxSpacing.y(12),
                    onPressed: () {
                      if(controller.formKey.currentState!.validate()){
                        controller.formKey.currentState!.save();
                        if(
                        controller.FnameTE.text.isNotEmpty &&
                            controller.LnameTE.text.isNotEmpty &&
                            controller.emailTE.text.isNotEmpty &&
                            controller.phoneTE.text.isNotEmpty &&
                            controller.passportTE.text.isNotEmpty &&
                            controller.addressTE.text.isNotEmpty
                        ){
                          // controller.nextPage();
                          setState(() {
                            controller.currentPage++;
                          });
                        }
                      }
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



Widget bodyBuilder() {
    switch (controller.currentPage) {
      case 0:
        return travellerDetails();
      case 1:
        return makePayment();
        case 2:
        return uploadDetails();

      default:
        return travellerDetails();
    }
  }
  //
  // Widget basicDetails() {
  //   return Form(
  //     key: controller.formKey,
  //     child: ListView(
  //       padding: const EdgeInsets.all(
  //         12.0,
  //       ),
  //       children: [
  //         Center(
  //           child: DotStepper(
  //             activeStep: activeIndex,
  //             dotRadius: 20.0,
  //             fixedDotDecoration: FixedDotDecoration(),
  //             shape: Shape.pipe,
  //             // spacing: 10.0,
  //           ),
  //         ),
  //         TextFormField(
  //           decoration: const InputDecoration(
  //             labelText: "Name",
  //           ),
  //           validator: RequiredValidator(
  //             errorText: "Required *",
  //           ),
  //         ),
  //         TextFormField(
  //             decoration: const InputDecoration(
  //               labelText: "Email",
  //             ),
  //             validator: MultiValidator([
  //               RequiredValidator(
  //                 errorText: "Required *",
  //               ),
  //               EmailValidator(
  //                 errorText: "Not Valid Email",
  //               ),
  //             ])),
  //         TextFormField(
  //           decoration: const InputDecoration(
  //             labelText: "Passoword",
  //           ),
  //           validator: MinLengthValidator(
  //             6,
  //             errorText: "Min 6 characters required",
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 12.0,
  //         ),
  //         SizedBox(
  //           height: 40.0,
  //           child: ElevatedButton(
  //             onPressed: () {
  //               if (controller.formKey.currentState?.validate() ?? false) {
  //                 // next
  //                 setState(() {
  //                   activeIndex++;
  //                 });
  //               }
  //             },
  //             child: const Text(
  //               "Next",
  //               style: TextStyle(
  //                 fontSize: 20.0,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget educationDetails() {
  //   return ListView(
  //     padding: const EdgeInsets.all(
  //       12.0,
  //     ),
  //     children: [
  //       Center(
  //         child: DotStepper(
  //           activeStep: activeIndex,
  //           dotRadius: 20.0,
  //           shape: Shape.pipe,
  //           spacing: 10.0,
  //         ),
  //       ),
  //
  //       TextFormField(
  //         decoration: const InputDecoration(
  //           labelText: "Name",
  //         ),
  //         validator: RequiredValidator(
  //           errorText: "Required *",
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 12.0,
  //       ),
  //       SizedBox(
  //         height: 40.0,
  //         child: ElevatedButton(
  //           onPressed: () {},
  //           child: const Text(
  //             "Register",
  //             style: TextStyle(
  //               fontSize: 20.0,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
  Widget makePayment() {
    return Container(
      padding: FxSpacing.x(20),
      child:

      ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Payment")
          // FxText.labelLarge(
          //   'Select payment method',
          //   fontWeight: 600,
          // ),
          // FxSpacing.height(20),
          // FxContainer.bordered(
          //   onTap: () {
          //     controller.selectPaymentMethod(1);
          //   },
          //   borderRadiusAll: 4,
          //   margin: FxSpacing.bottom(20),
          //   border: Border.all(
          //       color: controller.paymentMethodSelected == 1
          //           ? const Color(0xff1529e8)
          //           : theme.colorScheme.onBackground),
          //   color: controller.paymentMethodSelected == 1
          //       ? const Color(0xff1529e8).withAlpha(40)
          //       : theme.scaffoldBackgroundColor,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Row(
          //         children: [
          //           Icon(
          //             FeatherIcons.creditCard,
          //             size: 20,
          //             color: theme.colorScheme.onBackground.withAlpha(220),
          //           ),
          //           FxSpacing.width(8),
          //           FxText.bodyMedium(
          //             'Credit Card',
          //             fontWeight: 700,
          //           ),
          //           controller.paymentMethodSelected == 1
          //               ? Expanded(
          //             child: Align(
          //               alignment:
          //               Language.autoDirection<AlignmentGeometry>(
          //                   Alignment.centerRight,
          //                   Alignment.centerLeft)!,
          //               child: FxContainer.roundBordered(
          //                 paddingAll: 4,
          //                 border:
          //                 Border.all(color: const Color(0xff1529e8)),
          //                 color: const Color(0xff1529e8).withAlpha(40),
          //                 child: const Icon(
          //                   Icons.check,
          //                   color: Color(0xff1529e8),
          //                   size: 10,
          //                 ),
          //               ),
          //             ),
          //           )
          //               : Container(),
          //         ],
          //       ),
          //       FxSpacing.height(8),
          //       FxText.bodySmall(
          //         'Nency AnGhan',
          //         fontWeight: 600,
          //       ),
          //       FxSpacing.height(4),
          //       FxText.bodySmall(
          //         '**** **** **** 7865',
          //         fontWeight: 600,
          //       ),
          //       FxSpacing.height(4),
          //       FxText.bodySmall(
          //         'Expiry: 06/25',
          //         fontWeight: 600,
          //       ),
          //       FxSpacing.height(20),
          //       FxText.bodySmall(
          //         'Secure checkout powered by OnePay',
          //         muted: true,
          //       ),
          //     ],
          //   ),
          // ),
          // // FxContainer.bordered(
          // //   onTap: () {
          // //     controller.selectPaymentMethod(2);
          // //   },
          // //   borderRadiusAll: 4,
          // //   margin: FxSpacing.bottom(20),
          // //   border: Border.all(
          // //       color: controller.paymentMethodSelected == 2
          // //           ? theme.colorScheme.primary
          // //           : theme.colorScheme.onBackground),
          // //   color: controller.paymentMethodSelected == 2
          // //       ? theme.colorScheme.primary.withAlpha(40)
          // //       : theme.scaffoldBackgroundColor,
          // //   child: Column(
          // //     crossAxisAlignment: CrossAxisAlignment.start,
          // //     children: [
          // //       Row(
          // //         children: [
          // //           Icon(
          // //             FeatherIcons.dollarSign,
          // //             size: 18,
          // //             color: theme.colorScheme.onBackground.withAlpha(220),
          // //           ),
          // //           FxSpacing.width(8),
          // //           FxText.bodyMedium(
          // //             'Cash on delivery',
          // //             fontWeight: 700,
          // //           ),
          // //           controller.paymentMethodSelected == 2
          // //               ? Expanded(
          // //                   child: Align(
          // //                     alignment:
          // //                         Language.autoDirection<AlignmentGeometry>(
          // //                             Alignment.centerRight,
          // //                             Alignment.centerLeft)!,
          // //                     child: FxContainer.roundBordered(
          // //                       paddingAll: 4,
          // //                       border: Border.all(
          // //                           color: theme.colorScheme.primary),
          // //                       color: theme.colorScheme.primary.withAlpha(40),
          // //                       child: Icon(
          // //                         Icons.check,
          // //                         color: theme.colorScheme.primary,
          // //                         size: 10,
          // //                       ),
          // //                     ),
          // //                   ),
          // //                 )
          // //               : Container(),
          // //         ],
          // //       ),
          // //       FxSpacing.height(8),
          // //       FxText.bodySmall(
          // //         'Additional \$ 20 charges for COD services.',
          // //         muted: true,
          // //       ),
          // //     ],
          // //   ),
          // // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     FxText.labelLarge(
          //       'Do you have promo code?',
          //       fontWeight: 700,
          //     ),
          //     FxSpacing.width(20),
          //     FxContainer.bordered(
          //       // padding: FxSpacing.xy(16, 12),
          //       onTap: () {
          //         controller.addCart
          //             ? controller.cartController.reverse()
          //             : controller.cartController.forward();
          //         // controller.showcode = !controller.showcode;
          //         // log(controller.showcode.toString());
          //         // // controller.showcode();
          //         // log('message');
          //       },
          //       borderRadiusAll: 4,
          //       // elevation: 0,
          //       splashColor: const Color(0xff1529e8).withAlpha(30),
          //       // color: const Color(0xff1529e8),
          //       color: const Color(0xff1529e8).withAlpha(40),
          //       border: Border.all(color: const Color(0xff1529e8)),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           FxText.labelMedium(
          //             'Promo Code',
          //             // color: Colors.white,
          //             color: const Color(0xff1529e8),
          //             fontWeight: 600,
          //           ),
          //           const Icon(
          //             FeatherIcons.arrowDown,
          //             color: Color(0xff1529e8),
          //             // color: Colors.white,
          //             size: 18,
          //           ),
          //           // FxSpacing.width(8),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          // FxSpacing.height(20),
          // //code
          // controller.addCart
          //     ? FxContainer(
          //   paddingAll: 12,
          //   borderRadiusAll: 4,
          //   child: Row(
          //     children: [
          //       // Icon(
          //       //   FeatherIcons.creditCard,
          //       //   size: 18,
          //       //   color: theme.colorScheme.primary,
          //       // ),
          //       // FxSpacing.width(16),
          //       Expanded(
          //         child: SlideTransition(
          //           position: controller.passportAnimation,
          //           child: TextFormField(
          //             style: FxTextStyle.bodyMedium(),
          //             decoration: InputDecoration(
          //                 floatingLabelBehavior:
          //                 FloatingLabelBehavior.never,
          //                 filled: true,
          //                 isDense: true,
          //                 fillColor: Colors.white,
          //                 // fillColor: Colors.white
          //                 // prefixIcon: Icon(
          //                 //   FeatherIcons.user,
          //                 //   color: theme.colorScheme.onBackground,
          //                 // ),
          //                 hintText: "Enter Promo Code",
          //                 enabledBorder: outlineInputBorderenable,
          //                 focusedBorder: outlineInputBorderfocus,
          //                 border: outlineInputBorderenable,
          //                 // enabledBorder: outlineInputBorder,
          //                 // focusedBorder: outlineInputBorder,
          //                 // border: outlineInputBorder,
          //                 contentPadding: FxSpacing.all(16),
          //                 hintStyle: FxTextStyle.bodyMedium(),
          //                 isCollapsed: true),
          //             maxLines: 1,
          //             controller: controller.phoneTE,
          //             // validator: controller.validateName,
          //             cursorColor: theme.colorScheme.onBackground,
          //           ),
          //         ),
          //         //     child: FxText.labelLarge(
          //         //   'Black Friday Promo',
          //         //   fontWeight: 600,
          //         // )
          //       ),
          //       FxSpacing.width(16),
          //       // FxContainer(
          //       //   borderRadiusAll: 2,
          //       //   padding: FxSpacing.xy(8, 4),
          //       //   color: theme.colorScheme.primary.withAlpha(40),
          //       //   child: FxText.bodySmall(
          //       //     'BLCK20',
          //       //     color: theme.colorScheme.primary,
          //       //   ),
          //       // ),
          //       // Expanded(
          //       //   child: Container(),
          //       // ),
          //
          //       Expanded(
          //         child: FxButton.block(
          //           onPressed: () {},
          //           borderRadiusAll: 4,
          //           elevation: 0,
          //           splashColor: const Color(0xff1529e8).withAlpha(40),
          //           backgroundColor: const Color(0xff1529e8),
          //           child: FxText.bodyMedium(
          //             'Redeem',
          //             fontWeight: 600,
          //             color: theme.colorScheme.onPrimary,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
          //     : const SizedBox(),
          // FxSpacing.height(20),
          // // FxContainer(
          // //   paddingAll: 12,
          // //   borderRadiusAll: 4,
          // //   child: Row(
          // //     children: [
          // //       Icon(
          // //         FeatherIcons.creditCard,
          // //         size: 18,
          // //         color: theme.colorScheme.primary,
          // //       ),
          // //       FxSpacing.width(16),
          // //       Expanded(
          // //           child: FxText.labelLarge(
          // //         'Cyber Week Deal',
          // //         fontWeight: 600,
          // //       )),
          // //       FxSpacing.width(16),
          // //       FxContainer(
          // //         borderRadiusAll: 2,
          // //         padding: FxSpacing.xy(8, 4),
          // //         color: theme.colorScheme.primary.withAlpha(40),
          // //         child: FxText.bodySmall(
          // //           'CYBR00',
          // //           color: theme.colorScheme.primary,
          // //         ),
          // //       ),
          // //     ],
          // //   ),
          // // ),
          //
          // //bill
          // // _billingWidget(),
          // FxSpacing.height(20),
          ,
          FxButton.block(
            onPressed: () {
              // controller.nextPage();
              setState(() {
                controller.currentPage++;
              });
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
                // FxText.bodyMedium(
                //   '\$ 251.55',
                //   fontWeight: 700,
                //   color: theme.colorScheme.onPrimary,
                // ),
              ],
            ),
          ),
          // FxSpacing.height(80),
        ],
      ),
    );
  }

  Widget uploadDetails() {
    return Padding(
        padding: FxSpacing.x(20),
        child:
      ListView(
        children: [
          Text("Upload Details")

          //     Container(
      //         margin: FxSpacing.all(20),
      //         child: Image(
      //           image: AssetImage(Images.shoppingOrderSuccess),
      //         )),
      //     FxSpacing.height(20),
      //     FxText.titleLarge(
      //       'Booking Success!!',
      //       fontWeight: 700,
      //     ),
      //     FxSpacing.height(8),
      //     FxText.labelLarge(
      //       'Enjoy Your \nVaccation, thanks for Booking',
      //       textAlign: TextAlign.center,
      //       xMuted: true,
      //     ),
      //     FxSpacing.height(24),
      //     FxButton.block(
      //       onPressed: () {
      //         controller.goBack();
      //       },
      //       borderRadiusAll: 4,
      //       elevation: 0,
      //       splashColor: const Color(0xff1529e8).withAlpha(30),
      //       backgroundColor: const Color(0xff1529e8),
      //       child: FxText.labelLarge(
      //         'Back To Home',
      //         color: theme.colorScheme.onPrimary,
      //         fontWeight: 600,
      //       ),
      //     ),
        ],
      ),
    );
  }
}




  // Widget _applyVisa (){
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text("Visa Details",style: TextStyle(color: Colors.black),),
  //       ),
  //       body: Form(
  //         key: formKey,
  //         child: ListView(
  //           children: [
  //             SizedBox(height: 10,),
  //             TextFormField(
  //               controller: nameController,
  //               focusNode: nameNode,
  //               onSaved: (value){
  //                 value = _name;
  //               },
  //               validator:  (_name) {
  //                 if (_name!.isEmpty) {
  //                   return "Enter your name";
  //                 } else if (_name.length <= 3) {
  //                   return "Enter up to name three characters";
  //                 } else {
  //                   return null;
  //                 }
  //               },
  //               style: const TextStyle(fontSize: 14),
  //               keyboardType: TextInputType.text,
  //
  //               decoration: InputDecoration(
  //                 prefixIcon:Icon(Icons.person),
  //                 focusedBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: Colors.blue, width: 1),
  //                     borderRadius: BorderRadius.circular(10)),
  //                 errorBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: Colors.red, width: 2),
  //                     borderRadius: BorderRadius.circular(10)),
  //                 contentPadding: EdgeInsets.all(10.0),
  //                 enabledBorder: OutlineInputBorder(
  //                     borderSide: BorderSide(color: Colors.grey, width: 1),
  //                     borderRadius: BorderRadius.circular(10)),
  //                 hintText: "Enter your name",
  //                 errorStyle: TextStyle(
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.bold),
  //
  //                 // suffix:(isLocationEnable != null)? Icon(Icons.my_location,color: Colors.red,) : null,
  //                 hintStyle: TextStyle(
  //                   color: Colors.grey,
  //                   fontSize: 16,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 50,),
  //             ElevatedButton(onPressed: (){
  //               if(formKey.currentState!.validate()){
  //
  //                 formKey.currentState!.save();
  //                 print(nameController.text);
  //
  //               }
  //             }, child: Text("Submit"))
  //           ],
  //         ),
  //       )
  //   );
  // }


