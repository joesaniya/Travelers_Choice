import 'dart:math';

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
import 'package:intl/intl.dart';

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
  // late List<TextEditingController> FnameTE =
  // List.generate(5, (i) => TextEditingController());

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
                  Center(
                    child: DotStepper(
                      dotCount: 4,
                      activeStep: controller.currentPage,
                      dotRadius: 20.0,
                      tappingEnabled: false,
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
                  FxSpacing.height(10),
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


  Widget bodyBuilder() {
    switch (controller.currentPage) {
      case 0:
        return itenaryDetails();
        case 1:
        return travellerDetails();
      case 2:
        return uploadDetails();
        case 3:
        return payments();

      default:
        return itenaryDetails();
    }
  }

  Widget itenaryDetails(){
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
                        alignment: Alignment.center,
                        child: FxText.bodyLarge(
                          'Itenary',
                          // textAlign: TextAlign.left,
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                        // ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Visa Type',
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
                            value: controller.selectedVisa,
                            hint: Center(
                              child: FxText.labelLarge(
                                "Choose visa type",
                                fontWeight: 600,
                                color: Colors.black54,
                                letterSpacing: 0.4,
                              ),
                            ),
                            items: controller.visaTypes.map((String value) {
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
                                controller.selectedVisa = value.toString();
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
                          'From Date',
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
                            FeatherIcons.calendar,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "dd/mm/yy",
                          enabledBorder: outlineInputBorderenable,
                          focusedBorder: outlineInputBorderfocus,
                          border: outlineInputBorderenable,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.fromDateTE,
                      // validator: controller.validateFirstName,
                      cursorColor: theme.colorScheme.onBackground,
                      onTap: ()async{
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

                        if(pickedDate != null){
                          setState(() {
                            controller.fromDateTE.text = DateFormat("dd-MM-yyy").format(pickedDate);
                          });
                        }
                      },
                    ),

                    FxSpacing.height(20),

                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'To Date',
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
                            FeatherIcons.calendar,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "dd/mm/yyyy",
                          enabledBorder: outlineInputBorderenable,
                          focusedBorder: outlineInputBorderfocus,
                          border: outlineInputBorderenable,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      maxLines: 1,
                      controller: controller.toDateTE,
                      // validator: controller.validateLastName,
                      cursorColor: theme.colorScheme.onBackground,
                      onTap: ()async{
                        DateTime? pickedDate = await showDatePicker(
                            context: context,

                            initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

                        if(pickedDate != null){
                          setState(() {
                            controller.toDateTE.text = DateFormat("dd-MM-yyy").format(pickedDate);
                          });
                        }
                      },
                    ),

                    FxSpacing.height(20),

                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Travellers',
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
                            value: controller.selectedTraveller,
                            hint: Center(
                              child: FxText.labelLarge(
                                "Choose travellers",
                                fontWeight: 600,
                                color: Colors.black54,
                                // color: theme.colorScheme.onPrimary,
                                letterSpacing: 0.4,
                              ),
                            ),
                            items: controller.travellerNumber.map((int value) {
                              return DropdownMenuItem<int>(
                                  value: value,
                                  child: Center(
                                    child: Text(
                                      value.toString(),
                                      style: FxTextStyle.bodyMedium(),
                                    ),
                                  ));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                controller.selectedTraveller = value as int?;
                              });
                              // log(controller.selectedTraveller!.toInt());
                            },
                            style: FxTextStyle.bodyMedium(),
                          ),
                        ),
                      ),
                    ),
                    FxSpacing.height(20),

                  ],
                )
            ),
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
                      if(controller.selectedTraveller == null){

                        var snackBar = SnackBar(content: Text('Select no of travellers'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else if(controller.selectedTraveller != null){
                        setState(() {
                          controller.currentPage++;
                          // isFinished0 = true;
                        });
                      }

                      // }
                      // }
                    },
                    borderRadiusAll: 4,
                    elevation: 0,
                    splashColor: theme.colorScheme.onPrimary.withAlpha(30),
                    backgroundColor: const Color(0xff1529e8),
                    child: FxText.labelMedium(
                      'Go To Details',
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

  Widget travellerDetails() {
    // print(controller.selectedTraveller);
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Form(
                key: controller.formKey,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder:(BuildContext context, int index){
                    if (index >= controller.firstNameControllers.length) {
                      controller.firstNameControllers.add(TextEditingController());
                    }
                    if (index >= controller.lastNameControllers.length) {
                      controller.lastNameControllers.add(TextEditingController());
                    }if (index >= controller.emailControllers.length) {
                      controller.emailControllers.add(TextEditingController());
                    }if (index >= controller.contactControllers.length) {
                      controller.contactControllers.add(TextEditingController());
                    }if (index >= controller.passportControllers.length) {
                      controller.passportControllers.add(TextEditingController());
                    }
                  return  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          child: Align(
                            alignment: Alignment.center,
                            child:   controller.selectedTraveller ==1 ? FxText.bodyLarge(
                              "Traveller Details",
                              letterSpacing: 0,
                              fontWeight: 600,
                            ) : controller.travellerNumber[index]>= 1? FxText.bodyLarge(
                            "Passenger ${controller.travellerNumber[index]}" ,
                              letterSpacing: 0,
                              fontWeight: 600,
                            ):  Text(""),
                            // ),
                          ),
                        ),
                        SizedBox(height: 10,),
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
                                value: controller.selectedTitle,
                                hint: Center(
                                  child: FxText.labelLarge(
                                    "Choose title",
                                    fontWeight: 600,
                                    color: Colors.black54,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                items: controller.titleCodes.map((String value) {
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
                                    controller.selectedTitle = value.toString();
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
                          controller: controller.firstNameControllers[index],
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
                          controller: controller.lastNameControllers[index],
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
                          controller: controller.emailControllers[index],
                          validator: controller.validateEmail,
                          cursorColor: theme.colorScheme.onBackground,
                        ),

                        FxSpacing.height(20),

                        Container(
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
                                    "Choose country",
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
                              hintText: "Contact Number",
                              enabledBorder: outlineInputBorderenable,
                              focusedBorder: outlineInputBorderfocus,
                              border: outlineInputBorderenable,
                              contentPadding: FxSpacing.all(16),
                              hintStyle: FxTextStyle.bodyMedium(),
                              isCollapsed: true),
                          maxLines: 1,
                          controller: controller.contactControllers[index],
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
                          controller: controller.passportControllers[index],
                          validator: controller.validatePassport,
                          cursorColor: theme.colorScheme.onBackground,
                        ),

                        FxSpacing.height(20),

                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FxText.bodyLarge(
                              'Date of Birth',
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
                                Icons.calendar_month,
                                color: theme.colorScheme.onBackground,
                              ),
                              hintText: "dd/mm/yyyy",
                              enabledBorder: outlineInputBorderenable,
                              focusedBorder: outlineInputBorderfocus,
                              border: outlineInputBorderenable,
                              contentPadding: FxSpacing.all(16),
                              hintStyle: FxTextStyle.bodyMedium(),
                              isCollapsed: true),
                          // maxLines: 1,
                          controller: controller.dobTE,
                          // validator: controller.validateAddress,
                          cursorColor: theme.colorScheme.onBackground,
                          onTap: ()async{
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now());

                            if(pickedDate != null){
                              setState(() {
                                controller.dobTE.text = DateFormat("dd-MM-yyy").format(pickedDate);
                              });
                            }
                          },
                        ),

                        FxSpacing.height(10),

                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FxText.bodyLarge(
                              'Passport Expiry',
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
                                Icons.calendar_month,
                                color: theme.colorScheme.onBackground,
                              ),
                              hintText: "dd/mm/yyyy",
                              enabledBorder: outlineInputBorderenable,
                              focusedBorder: outlineInputBorderfocus,
                              border: outlineInputBorderenable,
                              contentPadding: FxSpacing.all(16),
                              hintStyle: FxTextStyle.bodyMedium(),
                              isCollapsed: true),
                          // maxLines: 1,
                          controller: controller.expiryTE,
                          // validator: controller.validateAddress,
                          cursorColor: theme.colorScheme.onBackground,
                          onTap: ()async{
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

                            if(pickedDate != null){
                              setState(() {
                                controller.expiryTE.text = DateFormat("dd-MM-yyy").format(pickedDate);
                              });
                            }
                          },
                        ),
                        FxSpacing.height(5),
                      ],
                    ),
                  );
                },
                itemCount: controller.selectedTraveller!,

                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10,);
                  },
                ) ,

            ),
            FxSpacing.height(20),
            FxButton(
              padding: FxSpacing.y(12),
              onPressed: () {
                // if(controller.formKey.currentState!.validate()){
                //   controller.formKey.currentState!.save();
                  // for(TextEditingController controllers in controller.firstNameControllers){
                  //   if(
                  //   controllers.text.isNotEmpty
                  //       // controller.LnameTE.text.isNotEmpty &&
                  //       // controller.emailTE.text.isNotEmpty &&
                  //       // controller.phoneTE.text.isNotEmpty &&
                  //       // controller.passportTE.text.isNotEmpty &&
                  //       // controller.addressTE.text.isNotEmpty
                  //   )
                    {
                      setState(() {
                        controller.currentPage++;
                        // isFinished0 = true;
                      });
                    }
                  //
                  // }
                // }
              },
              borderRadiusAll: 4,
              elevation: 0,
              splashColor: theme.colorScheme.onPrimary.withAlpha(30),
              backgroundColor: const Color(0xff1529e8),
              child: FxText.labelMedium(
                'Upload Details',
                color: theme.colorScheme.onPrimary,
                fontWeight: 600,
              ),
            ),
            FxSpacing.height(5),
          ]),
    );
  }

  Widget uploadDetails() {
    return Container(
      padding: FxSpacing.x(15),
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Align(
              alignment: Alignment.center,
              child: FxText.bodyLarge(
                'Upload Details',
                // textAlign: TextAlign.left,
                letterSpacing: 0,
                fontWeight: 600,

              ),
              // ),
            ),
          ),
          SizedBox(height: 20,),

          ListView.separated(
            shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index){
                return  Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child:   controller.selectedTraveller ==1 ? FxText.bodyLarge(
                            "",
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ) : controller.travellerNumber[index]>= 1? FxText.bodyLarge(
                            "Passenger ${controller.travellerNumber[index]}" ,
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ):  Text(""),
                          // ),
                        ),
                      ),

                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FxText.bodyLarge(
                            'Passport First Page',
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
                        width: MediaQuery.of(context).size.width *0.9,
                        height: MediaQuery.of(context).size.height *0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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

                                    Text("Choose File",style: TextStyle(color: Colors.black54),),
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
                            'Passport Second Page',
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
                        width: MediaQuery.of(context).size.width *0.9,
                        height: MediaQuery.of(context).size.height *0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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

                                    Text("Choose File",style: TextStyle(color: Colors.black54),),
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
                            'Passport Size Photo',
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ),
                          // ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width *0.9,
                        height: MediaQuery.of(context).size.height *0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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

                                    Text("Choose File",style: TextStyle(color: Colors.black54),),
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
                            'Supportive Documents 1',
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ),
                          // ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width *0.9,
                        height: MediaQuery.of(context).size.height *0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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

                                    Text("Choose File",style: TextStyle(color: Colors.black54),),
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
                            'Supportive Documents 2 (optional)',
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ),
                          // ),
                        ),
                      ),

                      SizedBox(height: 10,),
                      Container(
                        width: MediaQuery.of(context).size.width *0.9,
                        height: MediaQuery.of(context).size.height *0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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

                                    Text("Choose File",style: TextStyle(color: Colors.black54),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                );
              },
              separatorBuilder:  (BuildContext context, int index) {
                return SizedBox(height:10);
              },
              itemCount: controller.selectedTraveller!
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
          Container(
            child: Align(
              alignment: Alignment.center,
              child: FxText.bodyLarge(
                'Make Payment',
                // textAlign: TextAlign.left,
                letterSpacing: 0,
                fontWeight: 600,

              ),
              // ),
            ),
          ),
          SizedBox(height: 20,),
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




