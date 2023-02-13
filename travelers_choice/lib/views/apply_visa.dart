import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/core/state_management/builder.dart';
import 'package:flutx/core/state_management/controller_store.dart';
import 'package:flutx/themes/text_style.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:flutx/widgets/container/container.dart';
import 'package:flutx/widgets/dashed_divider/dashed_divider.dart';
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

  List<PlatformFile> files = [];
  late ApplyVisaController controller;
  late ThemeData theme;
  TextEditingController nameController = TextEditingController();
  int activeIndex = 0;
  int totalIndex = 3;

  // bool isFinished0 = false;
  // bool isFinished1 = false;
  // bool isFinished2 = false;

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

  // Widget buildNwTab(){
  //   return  Row(
  //     children: [
  //       Expanded(
  //         flex:  4 ,
  //         child: Container(
  //           height: 60,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(40),
  //             color: isFinished0 == true ?  Color(0xff1529e8).withAlpha(20):Color(0xff1529e8)
  //           ),
  //           child: Center(
  //             child: isFinished0 == true ? Icon(Icons.check_circle_outline_outlined,color: Colors.green,):
  //             FxText.bodySmall(
  //               controller.tabs[0].name,
  //               fontWeight: 600,
  //               color:
  //               // isSelected ?
  //               theme.colorScheme.onPrimary
  //                   // : theme.colorScheme.onBackground,
  //             ),
  //           ),
  //         ),
  //       ),
  //       Expanded(
  //         flex:  4 ,
  //         child: Container(
  //           height: 60,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(40),
  //             color: isFinished1 == true ? Color(0xff1529e8).withAlpha(20):Color(0xff1529e8)
  //           ),
  //           child: isFinished1 == true ?  Icon(Icons.check_circle_outline_outlined,color: Colors.green,):Center(
  //             child: FxText.bodySmall(
  //               controller.tabs[1].name,
  //               fontWeight: 600,
  //               color:
  //               // isSelected ?
  //               theme.colorScheme.onPrimary
  //                   // : theme.colorScheme.onBackground,
  //             ),
  //           ),
  //         ),
  //       ),
  //       Expanded(
  //         flex:  4 ,
  //         child: Container(
  //           height: 60,
  //           decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(40),
  //               color: isFinished2 == true ? Color(0xff1529e8).withAlpha(20):Color(0xff1529e8)
  //           ),
  //           child: Center(
  //             child: isFinished2 ==  true ?Icon(Icons.check_circle_outline_outlined,color: Colors.green,):FxText.bodySmall(
  //                 controller.tabs[2].name,
  //                 fontWeight: 600,
  //                 color:
  //                 // isSelected ?
  //                 theme.colorScheme.onPrimary
  //               // : theme.colorScheme.onBackground,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget buildTabs() {
  //   List<Widget> tabs = [];
  //
  //   for (int i = 0; i < controller.tabs.length; i++) {
  //     bool isSelected = controller.currentPage == i;
  //     tabs.add(
  //         Expanded(
  //       flex:  4 ,
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(40),
  //           color: isSelected ? const Color(0xff1529e8)  : isFinished0 == true && isFinished1 == true ? Colors.green: Colors.transparent,
  //         ),
  //         child: Center(
  //           child: FxText.bodySmall(
  //             controller.tabs[i].name,
  //             fontWeight: 600,
  //             color: isSelected
  //                 ? theme.colorScheme.onPrimary
  //                 : theme.colorScheme.onBackground,
  //           ),
  //         ),
  //       ),
  //     )
  //     );
  //   }
  //
  //   return Row(
  //     children: tabs,
  //   );
  // }


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
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8.0,right: 8),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(40),
                  //       color: Colors.transparent,
                  //
                  //     ),
                  //     height: MediaQuery.of(context).size.height*0.05,
                  //     width: MediaQuery.of(context).size.width *0.9,
                  //     // margin: FxSpacing.x(20),
                  //     // paddingAll: 0,
                  //     // borderRadiusAll: 4,
                  //     // clipBehavior: Clip.antiAliasWithSaveLayer,
                  //     child: buildNwTab(),
                  //   ),
                  // ),
                  Center(
                    child: DotStepper(
                      dotCount: 3,
                      activeStep: controller.currentPage,
                      dotRadius: 20.0,
                      shape: Shape.pipe,
                      indicator: Indicator.slide,
                      indicatorDecoration: IndicatorDecoration(color: Color(0xff1529e8)),
                      // fixedDotDecoration: FixedDotDecoration(color: Color(0xff1529e8).withAlpha(20)),
                      spacing: 20.0,
                    ),
                  ),
                  Text(
                    "Step ${controller.currentPage + 1} of ${controller.numPages}",
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
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
            Form(
                key: controller.formKey,
                child: Column(
                  children: [

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

                    FxSpacing.height(20),

                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Last Name',
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),

                    ),
                    FxSpacing.height(10),

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

                    FxSpacing.height(20),

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

                    ),
                    FxSpacing.height(10),

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

                    FxSpacing.height(20),

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

                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Contact Number',
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),

                    ),
                    FxSpacing.height(10),

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

                    FxSpacing.height(20),

                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Passport Number',
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),

                    ),
                    FxSpacing.height(10),

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

                    FxSpacing.height(20),

                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Address',
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),

                    ),
                    FxSpacing.height(10),

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

                  ],
                )),
            FxSpacing.height(20),
            Row(
              children: [
                Expanded(
                  child: FxButton(
                    padding: FxSpacing.y(12),
                    onPressed: () {
                      // if(controller.formKey.currentState!.validate()){
                      //   controller.formKey.currentState!.save();
                      //   if(
                      //   controller.FnameTE.text.isNotEmpty &&
                      //       controller.LnameTE.text.isNotEmpty &&
                      //       controller.emailTE.text.isNotEmpty &&
                      //       controller.phoneTE.text.isNotEmpty &&
                      //       controller.passportTE.text.isNotEmpty &&
                      //       controller.addressTE.text.isNotEmpty
                      //   ){

                          setState(() {
                            controller.currentPage++;
                            // isFinished0 = true;
                          });
                        // }
                      // }
                    },
                    borderRadiusAll: 4,
                    elevation: 0,
                    splashColor: theme.colorScheme.onPrimary.withAlpha(30),
                    backgroundColor: const Color(0xff1529e8),
                    child: FxText.labelMedium(
                      'Upload Documents',
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
        return uploadDetails();
        case 2:
        return payments();

      default:
        return travellerDetails();
    }
  }

  Widget uploadDetails() {
    return Container(
      padding: FxSpacing.x(20),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FxText.bodyLarge(
                'Passport',
                // textAlign: TextAlign.left,
                letterSpacing: 0,
                fontWeight: 600,
              ),
              // ),
            ),
          ),

          SizedBox(height: 10,),
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width *0.8,
            height: MediaQuery.of(context).size.height *0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1,color: Colors.black54),
                color: Colors.transparent
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:  ()async{
                  final result = await FilePicker.platform.pickFiles();
                  if (result == null) return;
                  files = result.files; //EDIT: THIS PROBABLY CAUSED YOU AN ERROR
                  setState((){});
                  },
                    child: Row(
                      children: [
                         Icon(Icons.upload_outlined,color: Colors.grey,),

                        Text("Passport front",style: TextStyle(color: Colors.black54),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
         
          SizedBox(height: 10,),
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width *0.8,
            height: MediaQuery.of(context).size.height *0.15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1,color: Colors.black54),
                color: Colors.transparent
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:  ()async{
                      final result = await FilePicker.platform.pickFiles();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.upload_outlined,color: Colors.grey,),

                        Text("Passport back",style: TextStyle(color: Colors.black54),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FxText.bodyLarge(
                'Photo',
                // textAlign: TextAlign.left,
                letterSpacing: 0,
                fontWeight: 600,
              ),
              // ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width *0.8,
            height: MediaQuery.of(context).size.height *0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1,color: Colors.black54),
                color: Colors.transparent
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:  ()async{
                      final result = await FilePicker.platform.pickFiles();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.upload_outlined,color: Colors.grey,),

                        Text("Upload photo",style: TextStyle(color: Colors.black54),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
           Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FxText.bodyLarge(
                'Documents',
                // textAlign: TextAlign.left,
                letterSpacing: 0,
                fontWeight: 600,
              ),
              // ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width *0.8,
            height: MediaQuery.of(context).size.height *0.15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1,color: Colors.black54),
                color: Colors.transparent
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:  ()async{
                      final result = await FilePicker.platform.pickFiles();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.upload_outlined,color: Colors.grey,),

                        Text("Upload L2 document",style: TextStyle(color: Colors.black54),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width *0.8,
            height: MediaQuery.of(context).size.height *0.15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1,color: Colors.black54),
                color: Colors.transparent
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:  ()async{
                      final result = await FilePicker.platform.pickFiles();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.upload_outlined,color: Colors.grey,),

                        Text("Upload L2 document (optional)",style: TextStyle(color: Colors.black54),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 10,),
          FxButton.block(
            onPressed: () {
              // controller.nextPage();
              setState(() {
                controller.currentPage++;
                // isFinished1 = true;
              });
            },
            borderRadiusAll: 4,
            elevation: 0,
            splashColor: const Color(0xff1529e8).withAlpha(40),
            backgroundColor: const Color(0xff1529e8),
            child: FxText.bodyMedium(
              'Proceed Payment',
              fontWeight: 600,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          SizedBox(height: 10,),

        ],
      ),
    );
  }

  Widget payments() {
    return Padding(
        padding: FxSpacing.x(20),
        child:
      ListView(
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
            borderRadiusAll: 10,
            // margin: FxSpacing.bottom(20),
            border: Border.all(
                color: controller.paymentMethodSelected == 1
                    ? const Color(0xff1529e8)
                    : theme.colorScheme.onBackground),
            color: controller.paymentMethodSelected == 1
                ? const Color(0xff1529e8).withAlpha(20)
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
                      'XYZ Bank Credit Card',
                      fontWeight: 700,
                    ),
                    // controller.paymentMethodSelected == 1
                    //     ? Expanded(
                    //       child: Align(
                    //         alignment:
                    //         Language.autoDirection<AlignmentGeometry>(
                    //             Alignment.centerRight,
                    //             Alignment.centerLeft)!,
                    //         child: const Icon(
                    //           Icons.radio_button_checked,
                    //           color: Color(0xff1529e8),
                    //           size: 20,
                    //         ),
                    //       ),
                    // )
                    //     : Container(),
                  ],
                ),
                FxSpacing.height(8),
                FxText.bodySmall(
                  'Abrar Ahmed',
                  fontWeight: 600,
                ),
                FxSpacing.height(5),
                FxText.bodySmall(
                  '**** **** **** 7865',
                  fontWeight: 600,
                ),
                FxSpacing.height(5),
                FxText.bodySmall(
                  'VALID THRU 12/27',
                  fontWeight: 600,
                ),
                FxSpacing.height(10),

              ],
            ),
          ),
          FxSpacing.height(20),
          FxContainer.bordered(
            onTap: () {
              controller.selectPaymentMethod(2);
            },
            borderRadiusAll: 10,
            // margin: FxSpacing.bottom(20),
            border: Border.all(
                color: controller.paymentMethodSelected == 2
                    ? const Color(0xff1529e8)
                    : theme.colorScheme.onBackground),
            color: controller.paymentMethodSelected == 2
                ? const Color(0xff1529e8).withAlpha(20)
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
                      'ABC Bank Debit Card',
                      fontWeight: 700,
                    ),
                    // controller.paymentMethodSelected == 1
                    //     ? Expanded(
                    //       child: Align(
                    //         alignment:
                    //         Language.autoDirection<AlignmentGeometry>(
                    //             Alignment.centerRight,
                    //             Alignment.centerLeft)!,
                    //         child: const Icon(
                    //           Icons.radio_button_checked,
                    //           color: Color(0xff1529e8),
                    //           size: 20,
                    //         ),
                    //       ),
                    // )
                    //     : Container(),
                  ],
                ),
                FxSpacing.height(8),
                FxText.bodySmall(
                  'Britto John',
                  fontWeight: 600,
                ),
                FxSpacing.height(5),
                FxText.bodySmall(
                  '**** **** **** 3214',
                  fontWeight: 600,
                ),
                FxSpacing.height(5),
                FxText.bodySmall(
                  'VALID THRU 06/25',
                  fontWeight: 600,
                ),
                FxSpacing.height(10),

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
          //
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
          FxSpacing.height(20),


          FxButton.block(
            onPressed: () {

              setState(() {
                // isFinished2 = true;
              });

            },
            borderRadiusAll: 4,
            elevation: 0,
            splashColor: const Color(0xff1529e8).withAlpha(40),
            backgroundColor: const Color(0xff1529e8),
            child: FxText.bodyMedium(
              'Payment',
              fontWeight: 600,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
  void openFiles(List<PlatformFile> files) {
    show(files: files);
  }

  void show({required List<PlatformFile> files}) {}
}




