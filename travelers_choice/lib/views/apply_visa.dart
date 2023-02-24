import 'dart:async';
import 'dart:io';
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
import 'package:hotel_travel/models/select_visa_modal.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/apply_visa_controller.dart';
import '../images.dart';
import '../localizations/language.dart';
import '../models/Country_modal.dart';
import '../services/app_constants.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';

class ApplyVisa extends StatefulWidget {

  final SelectVisaModal? visa;
  const ApplyVisa( {Key? key, required  this.visa,}) : super(key: key);

  @override
  State<ApplyVisa> createState() => _ApplyVisaState(visa);
}
enum Event { increment, decrement }

class CounterController {
  int counter = 1;
  int minQty = 1;
  int discount = 1000;
  final StreamController<int> _counterController = StreamController<int>();
  StreamSink<int> get counterSink => _counterController.sink;
  Stream<int> get counterStream => _counterController.stream;

  final StreamController<Event> _eventController = StreamController<Event>();
  StreamSink<Event> get eventSink => _eventController.sink;
  Stream<Event> get eventStream => _eventController.stream;

  StreamSubscription? listener;

  CounterController() {
    listener = eventStream.listen((Event event) {
      switch (event) {
        case Event.increment:
          counter++;

          break;
        case Event.decrement:
          if (counter > minQty) counter--;
          break;
        default:
      }
      counterSink.add(counter);
    });
  }
  dispose() {
    listener?.cancel();
    _counterController.close();
    _eventController.close();
  }
}
class _ApplyVisaState extends State<ApplyVisa>  with TickerProviderStateMixin{

  List<PlatformFile> files = [];
  late ApplyVisaController controller;
  late ThemeData theme;
  TextEditingController nameController = TextEditingController();
  int activeIndex = 0;
  int totalIndex = 3;
  late CounterController _counterController;
  List<PickedFile?> _imageFile=[];
  List<String> _fileName = [];
  List<String> _fileName2 = [];
  List<String> _fileName3 = [];
  List<String> _fileName4 = [];
  int price = 0;
  final ImagePicker _picker = ImagePicker();

  _ApplyVisaState(SelectVisaModal? visa);


  void takePhoto(ImageSource source, index)async{
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile.removeAt(index);
      _imageFile.insert(index, pickedFile!);
      // _imageFile = pickedFile;
    });
  }
  bool isLoading = true;
  late FocusNode nameNode;

  late OutlineInputBorder outlineInputBorderenable;
  late OutlineInputBorder outlineInputBorderfocus;

String userName = "";

  CountryModal? countryList;
  bool isCountryListLoading = true;
  Future getCountryList() async {
    isCountryListLoading = true;
    try {
      var data = await AuthService().getCountry();

      if (data != null) {
        setState(() {});
        countryList = data;
        countryList!.countries.forEach((element) {
          controller.countryCodes.add(element);

        });
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
  void initState() {
    theme = AppTheme.shoppingTheme;
   controller = FxControllerStore.put(ApplyVisaController(this));
    _counterController = CounterController();
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        controller.countryId =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN_countryId)!;
        log(controller.countryId as num);

      });
    });
    super.initState();
    fetchData();

    outlineInputBorderenable = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Colors.black),
    );
    outlineInputBorderfocus = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: 1, color: Color(0xff1529e8)),
    );

  }

  @override
  void dispose() {
    _counterController.dispose();

    super.dispose();
  }


  fetchData() {
    Future.delayed(Duration.zero, () async {
      await getCountryList().then((value) {
        if (value) {
          isLoading = false;
          setState(() {});
        }
      });
    });
  }
  @override
  Widget build(BuildContext context){
    // print(widget.visa!.visa.country);
    print(countryList);
    print(widget.visa!.visa.country.countryName);
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
              StreamBuilder<int>(
                stream: _counterController.counterStream,
                builder: (context, snapshot,){
                  return  Column(
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
                        child: bodyBuilder(widget.visa),
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
                  );
                },

              ),
          ));
        });
  }


  Widget bodyBuilder(SelectVisaModal? visa) {
    switch (controller.currentPage) {
      case 0:
        return itenaryDetails();
        case 1:
        return travellerDetails();
      case 2:
        return payments();
        case 3:
          return uploadDetails();

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
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.black),
                          // color: const Color(0xff1529e8),
                          borderRadius: BorderRadius.circular(4)),
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.9,
                      child:

                      DropdownButtonHideUnderline(
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
                            items:
                            widget.visa!.visaType.isNotEmpty ? widget.visa!.visaType
                                .map((value) {
                              return DropdownMenuItem<String>(

                                  value: value.id.toString(),
                                  child: Center(
                                    child: Text(
                                      value.visaName,
                                      style: FxTextStyle
                                          .bodyMedium(),
                                    ),
                                  ));
                            }).toList() :  [].map((value) {
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

                            onChanged: (String? value) {
                              setState(() {
                                controller.selectedVisa = value;
                                price = widget.visa!.visaType.firstWhere((element) => element.id==value).visaPrice;

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
                          'Email',
                          // textAlign: TextAlign.left,
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),

                    ),
                    FxSpacing.height(10),

                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: TextFormField(
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
                    ),
                    FxSpacing.height(20),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Contact No',
                          // textAlign: TextAlign.left,
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),

                    ),
                    FxSpacing.height(10),

                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: TextFormField(
                        style: FxTextStyle.bodyMedium(),
                        decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            isDense: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.phone,
                              color: theme.colorScheme.onBackground,
                            ),
                            hintText: "Contact No",
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

                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: TextFormField(
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
                        validator: controller.validateFromDate,

                        // validator: controller.validateFirstName,
                        cursorColor: theme.colorScheme.onBackground,
                        onTap: ()async{
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

                          if(pickedDate != null){
                            setState(() {
                              controller.fromDateTE.text = DateFormat("dd/MM/yyy").format(pickedDate);
                            });
                          }
                        },
                      ),
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

                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.9,
                      child: TextFormField(
                        style: FxTextStyle.bodyMedium(),
                        keyboardType: TextInputType.datetime,
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
                        validator: controller.validateToDate,
                        cursorColor: theme.colorScheme.onBackground,
                        onTap: ()async{
                          DateTime? pickedDate = await showDatePicker(
                              context: context,

                              initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

                          if(pickedDate != null){
                            setState(() {
                              controller.toDateTE.text = DateFormat("dd/MM/yyy").format(pickedDate);
                            });
                          }
                        },
                      ),
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
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       border: Border.all(width: 1, color: Colors.black),
                    //       // color: const Color(0xff1529e8),
                    //       borderRadius: BorderRadius.circular(4)),
                    //   height: 50,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: DropdownButtonHideUnderline(
                    //     child: ButtonTheme(
                    //       alignedDropdown: true,
                    //       child: DropdownButton(
                    //         iconSize: 25.0,
                    //         dropdownColor: Colors.white,
                    //         icon: const Icon(
                    //           Icons.arrow_drop_down,
                    //           color: Colors.black,
                    //         ),
                    //         value: controller.selectedTraveller,
                    //         hint: Center(
                    //           child: FxText.labelLarge(
                    //             "Choose travellers",
                    //             fontWeight: 600,
                    //             color: Colors.black54,
                    //             // color: theme.colorScheme.onPrimary,
                    //             letterSpacing: 0.4,
                    //           ),
                    //         ),
                    //         items: controller.travellerNumber.map((int value) {
                    //           return DropdownMenuItem<int>(
                    //               value: value,
                    //               child: Center(
                    //                 child: Text(
                    //                   value.toString(),
                    //                   style: FxTextStyle.bodyMedium(),
                    //                 ),
                    //               ));
                    //         }).toList(),
                    //         onChanged: (value) {
                    //           setState(() {
                    //             controller.selectedTraveller = value as int?;
                    //           });
                    //           // log(controller.selectedTraveller!.toInt());
                    //         },
                    //         style: FxTextStyle.bodyMedium(),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // FxSpacing.height(10),

                    Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1, color: Colors.black),
                          // color: const Color(0xff1529e8),
                          borderRadius: BorderRadius.circular(4)),
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          FxText.bodyLarge("Choose travellers"),
                          Row(
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                      MaterialStateProperty.all(Colors.grey),
                                      shape: MaterialStateProperty.all(
                                          const CircleBorder(side: BorderSide.none)),
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(20, 20))),
                                  onPressed: () {
                                    _counterController.eventSink.add(Event.decrement);
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    width: 25,
                                    color: Colors.transparent,
                                    child: FxText.bodyLarge(' ${_counterController.counter}',
                                    )),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff1529e8)),
                                    shape: MaterialStateProperty.all(
                                        const CircleBorder(side: BorderSide.none)),
                                    minimumSize:
                                    MaterialStateProperty.all(const Size(20, 20))),
                                onPressed: () {
                                  _counterController.eventSink.add(Event.increment);
                                },
                                child: const Icon(Icons.add),
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FxText.bodyLarge(

                          "${_counterController.counter * price} ${widget.visa!.visa.country.currencySymbol}",
                          color:  const Color(0xff1529e8),
                          decoration: TextDecoration.underline,
                        ),
                      ],
                    ),
                  ],
                )
            ),
            FxSpacing.height(20),
            FxButton(
              padding: FxSpacing.y(12),
              onPressed: () {

                  if(controller.selectedVisa == null || controller.selectedVisa!.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please Select Visa type")));
                  }
                  else if(controller.emailTE.text.isEmpty ){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter email")));
                  }
                  else if(controller.phoneTE.text.isEmpty ){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter Contact no")));
                  }
                 else if(controller.fromDateTE.text.isEmpty ){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please Select From date")));
                  }
                 else if(controller.toDateTE.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please Select To date")));
                  }
                  // else if(controller.selectedTraveller == null){
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('Select no of travellers')));
                  // }
                  else {
                    setState(() {
                      controller.currentPage++;
                      // isFinished0 = true;
                    });
                  }
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
            FxSpacing.height(15),
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
                child: Column(
                  children: [
                    FxText.bodyLarge("Travellers Details",
                    fontWeight:600),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder:(BuildContext context, int index){
                        if (index >= controller.selectTitle.length) {
                          controller.selectTitle.add(controller.titleCodes);

                          // adding first item to display in the dropdown
                          controller.selectedTitle.add(controller.titleCodes[0]);
                        }
                        if (index >= controller.selectCountry.length) {



                          controller.selectCountry.add(controller.countryCodes);

                          // adding first item to display in the dropdown
                          controller.selectedCountry.add(controller.countryCodes[0]);
                        }
                        if (index >= controller.firstNameControllers.length) {
                          controller.firstNameControllers.add(TextEditingController());
                        }
                        if (index >= controller.lastNameControllers.length) {
                          controller.lastNameControllers.add(TextEditingController());
                        }
                        if (index >= controller.emailControllers.length) {
                          controller.emailControllers.add(TextEditingController());
                        }
                        // if (index >= controller.nationalityControllers.length) {
                        //   controller.nationalityControllers.add(TextEditingController());
                        // }
                        if (index >= controller.contactControllers.length) {
                          controller.contactControllers.add(TextEditingController());
                        }
                        if (index >= controller.passportControllers.length) {
                          controller.passportControllers.add(TextEditingController());
                        }
                        if (index >= controller.dobControllers.length) {
                          controller.dobControllers.add(TextEditingController());
                        }
                        if (index >= controller.expiryControllers.length) {
                          controller.expiryControllers.add(TextEditingController());
                        }

                        // print(controller.selectTitle);
                      return  Container(
                        padding: EdgeInsets.all(10),
                        // color: Colors.white,
                        child: Column(
                          children: [
                            // Container(
                            //   child: Align(
                            //     alignment: Alignment.center,
                            //     child:   controller.selectedTraveller ==1 ? FxText.bodyLarge(
                            //       "Traveller Details",
                            //       letterSpacing: 0,
                            //       fontWeight: 600,
                            //     ) : controller.travellerNumber[index]>= 1? FxText.bodyLarge(
                            //     "Passenger ${controller.travellerNumber[index]}" ,
                            //       letterSpacing: 0,
                            //       fontWeight: 600,
                            //     ):  Text(""),
                            //     // ),
                            //   ),
                            // ),
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
                                  color: Colors.white,
                                  border: Border.all(width: 1, color: Colors.black),
                                  // color: const Color(0xff1529e8),
                                  borderRadius: BorderRadius.circular(4)),
                              height: 50.0,
                              width: MediaQuery.of(context).size.width*0.9,
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
                                    value: controller.selectedTitle[index],
                                    hint: Center(
                                      child: FxText.labelLarge(
                                        "Choose title",
                                        fontWeight: 600,
                                        color: Colors.black54,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                    items: controller.selectTitle[index].map((String value) {
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
                                        controller.selectedTitle[index]= value.toString();
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

                            SizedBox(
                              width: MediaQuery.of(context).size.width* 0.9,
                              height: 50,
                              child: TextFormField(
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

                            SizedBox(
                              width: MediaQuery.of(context).size.width* 0.9,
                              height: 50,
                              child: TextFormField(
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

                            SizedBox(
                              width: MediaQuery.of(context).size.width* 0.9,
                              height: 50,
                              child: TextFormField(
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
                                  // color: const Color(0xff1529e8),
                                  borderRadius: BorderRadius.circular(4)),
                              height: 50.0,
                              width: MediaQuery.of(context).size.width* 0.9,
                              child:
                              // DropdownButtonHideUnderline(
                              //   child: ButtonTheme(
                              //     alignedDropdown: true,
                              //     child: DropdownButton(
                              //       iconSize: 25.0,
                              //       dropdownColor: Colors.white,
                              //       icon: const Icon(
                              //         Icons.arrow_drop_down,
                              //         color: Colors.black,
                              //       ),
                              //       value: controller.selectedVisa,
                              //       hint: Center(
                              //         child: FxText.labelLarge(
                              //           "Choose Nationality",
                              //           fontWeight: 600,
                              //           color: Colors.black54,
                              //           letterSpacing: 0.4,
                              //         ),
                              //       ),
                              //       items:
                              //       countryList.first.countries.isNotEmpty ? countryList.first.countries
                              //           .map((value) {
                              //         return DropdownMenuItem<String>(
                              //             value: value.id[index].toString(),
                              //             child: Center(
                              //               child: Text(
                              //                 value.countryName[index],
                              //                 style: FxTextStyle
                              //                     .bodyMedium(),
                              //               ),
                              //             ));
                              //       }).toList() :  [].map((value) {
                              //         return DropdownMenuItem<String>(
                              //             value: value,
                              //             child: Center(
                              //               child: Text(
                              //                 value,
                              //                 style: FxTextStyle
                              //                     .bodyMedium(),
                              //               ),
                              //             ));
                              //       }).toList(),
                              //       onChanged: (value) {
                              //         setState(() {
                              //           // print(value.toString());
                              //           // print(controller.selectedVisa.toString());
                              //           controller.selectedCountry[index] = value.toString() ;
                              //         });
                              //       },
                              //       style: FxTextStyle.bodyMedium(),
                              //     ),
                              //   ),
                              // ),
                              DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                    iconSize: 25.0,
                                    dropdownColor: Colors.white,
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                    value: controller.selectedCountry[index],
                                    hint: Center(
                                      child: FxText.labelLarge(
                                        "Choose country",
                                        fontWeight: 600,
                                        color: Colors.black54,
                                        // color: theme.colorScheme.onPrimary,
                                        letterSpacing: 0.4,
                                      ),
                                    ),
                                    items: controller.selectCountry[index].map((CountryElement value) {
                                      return DropdownMenuItem<CountryElement>(
                                          value: value,
                                          child: Center(
                                            child: Text(
                                              value.countryName,
                                              style: FxTextStyle.bodyMedium(),
                                            ),
                                          ));
                                    }).toList(),
                                    onChanged: ( CountryElement? value) {
                                      setState(() {
                                        controller.selectedCountry[index] = value!;
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

                            SizedBox(
                              width: MediaQuery.of(context).size.width* 0.9,
                              height: 50,
                              child: TextFormField(
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

                            SizedBox(
                              width: MediaQuery.of(context).size.width* 0.9,
                              height: 50,
                              child: TextFormField(
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

                            SizedBox(
                              width: MediaQuery.of(context).size.width* 0.9,
                              height: 50,
                              child: TextFormField(
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
                                controller: controller.dobControllers[index],
                                validator: controller.validateDOB,
                                cursorColor: theme.colorScheme.onBackground,
                                onTap: ()async{
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now());

                                  if(pickedDate != null){
                                    setState(() {
                                      controller.dobControllers[index].text = DateFormat("dd/MM/yyy").format(pickedDate);
                                    });
                                  }
                                },
                              ),
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

                            SizedBox(
                              width: MediaQuery.of(context).size.width* 0.9,
                              height: 50,
                              child: TextFormField(
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
                                controller: controller.expiryControllers[index],
                                validator: controller.validateExpiry,
                                cursorColor: theme.colorScheme.onBackground,
                                onTap: ()async{
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));

                                  if(pickedDate != null){
                                    setState(() {
                                      controller.expiryControllers[index].text = DateFormat("dd/MM/yyy").format(pickedDate);
                                    });
                                  }
                                },
                              ),
                            ),
                            FxSpacing.height(5),
                          ],
                        ),
                      );
                    },
                    itemCount: _counterController.counter,

                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10,);
                      },
                    ),
                  ],
                ) ,

            ),
            FxSpacing.height(20),
            FxButton(
              padding: FxSpacing.y(12),
              onPressed: () {
                print(controller.selectedTitle.first);
                if(controller.formKey.currentState!.validate()) {
                  // controller.formKey.currentState!.save();

                  setState(() {
                    controller.currentPage++;
                  });

                  List<Map> travellersList = [];
                  for (int i = 0; i <= _counterController.counter - 1; i++) {
                    var inputFormat = DateFormat('dd/MM/yyyy');
                    var date1 = inputFormat.parse(
                        controller.expiryControllers[i].text);
                    var date2 = inputFormat.parse(
                        controller.dobControllers[i].text);



                    var outputFormat = DateFormat('yyyy-MM-dd');
                    int expiryDay = DateTime
                        .parse(outputFormat.parse(date1.toString()).toString())
                        .day;
                    int expiryMonth = DateTime
                        .parse(outputFormat.parse(date1.toString()).toString())
                        .month;
                    int expiryYear = DateTime
                        .parse(outputFormat.parse(date1.toString()).toString())
                        .year;
                    int dobDay = DateTime
                        .parse(outputFormat.parse(date2.toString()).toString())
                        .day;
                    int dobMonth = DateTime
                        .parse(outputFormat.parse(date2.toString()).toString())
                        .month;
                    int dobYear = DateTime
                        .parse(outputFormat.parse(date2.toString()).toString())
                        .year;



                    travellersList.add(
                        {
                          "title": controller.selectedTitle[i].toLowerCase(),
                          "firstName": controller.firstNameControllers[i].text,
                          "lastName": controller.lastNameControllers[i].text,
                          "expiryDate": {
                            "day": expiryDay,
                            "month": expiryMonth,
                            "year": expiryYear
                          },
                          "dateOfBirth": {
                            "day": dobDay,
                            "month": dobMonth,
                            "year": dobYear
                          },
                          "country": controller.selectedCountry[i].id,
                          "passportNo": controller.passportControllers[i].text,
                          "contactNo": controller.contactControllers[i].text,
                          "email": controller.emailControllers[i].text
                        }
                    );
                  }
                  var inputFormat = DateFormat('dd/MM/yyyy');
                  var fromDate = inputFormat.parse(
                      controller.fromDateTE.text);
                  var toDate = inputFormat.parse(
                      controller.toDateTE.text);
                  var dateFormat = DateFormat('MM-dd-yyyy');
                  var onwardDate = dateFormat.format(fromDate).toString();
                  var returnDate = dateFormat.format(toDate).toString();
                  Map body = {
                    "visaType": controller.selectedVisa,
                    "email": controller.emailTE.text,
                    "contactNo": controller.phoneTE.text,
                    "onwardDate": onwardDate,
                    "returnDate": returnDate,
                    "noOfTravellers": _counterController.counter,
                    "travellers": travellersList,
                    "country": controller.countryId
                  };


                  print(body);
                  controller.postCreateVisa(
                      body
                  );
                }

              },
              borderRadiusAll: 4,
              elevation: 0,
              splashColor: theme.colorScheme.onPrimary.withAlpha(30),
              backgroundColor: const Color(0xff1529e8),
              child: FxText.labelMedium(
                'Proceed Payment',
                color: theme.colorScheme.onPrimary,
                fontWeight: 600,
              ),
            ),
            FxSpacing.height(5),
          ]),
    );
  }

  Widget uploadDetails() {
    return Form(
      key: controller.formKey,
      child: Container(
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

                _fileName.add("");
                _fileName2.add("");
                _fileName3.add("");
                _fileName4.add("");
                _imageFile.add(null);
                  return  Container(
                    padding: EdgeInsets.all(10),
                    // color: Colors.white,
                    child: Column(
                      children: [
                        // Align(
                        //   alignment: Alignment.center,
                        //   child:   _counterController.counter == 1 ? FxText.bodyLarge(
                        //     "",
                        //     // textAlign: TextAlign.left,
                        //     letterSpacing: 0,
                        //     fontWeight: 600,
                        //   ) : controller.travellerNumber[index]>= 1? FxText.bodyLarge(
                        //     "Passenger ${controller.travellerNumber[index]}" ,
                        //     // textAlign: TextAlign.left,
                        //     letterSpacing: 0,
                        //     fontWeight: 600,
                        //   ):  const Text(""),
                        //   // ),
                        // ),

                        const SizedBox(height: 5,),

                        Card(
                          elevation:2,
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          child: Container(
                            decoration:BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding:EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      FittedBox(
                                          fit:BoxFit.fitWidth,
                                          child:RichText(
                                            text: TextSpan(
                                              text: 'First name: ',
                                              style: TextStyle(fontSize: 16,color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '${controller.firstNameControllers[index].text}',
                                                    style: TextStyle(fontSize: 16,color: Color(0xff1529e8))
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                      SizedBox(width: 10,),
                                      FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child:RichText(
                                            text: TextSpan(
                                              text: 'Last name: ',
                                              style: TextStyle(fontSize: 16,color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '${controller.lastNameControllers[index].text}',
                                                    style: TextStyle(fontSize: 16,color: Color(0xff1529e8))
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: Row(
                                    children: [
                                      FittedBox(
                                          fit:BoxFit.fitWidth,
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'DOB: ',
                                              style: TextStyle(fontSize: 16,color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '${controller.dobControllers[index].text}',
                                                    style: TextStyle(fontSize: 16,color:  Color(0xff1529e8))
                                                ),
                                              ],
                                            ),
                                          )

                                ),
                                      SizedBox(width: 10,),
                                      FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child:RichText(
                                            text: TextSpan(
                                              text: 'Visit Date: ',
                                              style: TextStyle(fontSize: 16,color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '${controller.fromDateTE.text}',
                                                    style: TextStyle(fontSize: 16,color:  Color(0xff1529e8))
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                          fit:BoxFit.fitWidth,
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Passport number: ',
                                              style: TextStyle(fontSize: 16,color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '${controller.passportControllers[index].text}',
                                                    style: TextStyle(fontSize: 16,color: Color(0xff1529e8))
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                      SizedBox(height: 5,),
                                      FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Passport expiry: ',
                                              style: TextStyle(fontSize: 16,color: Colors.black),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: '${controller.expiryControllers[index].text}',
                                                    style: TextStyle(fontSize: 16,color:  Color(0xff1529e8))
                                                ),
                                              ],
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10,),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: FxText.bodyLarge(
                            'Passport First Page',
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ),
                          // ),
                        ),

                        const SizedBox(height: 10,),

                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.black),
                              // color: const Color(0xff1529e8),
                              borderRadius: BorderRadius.circular(4)),
                          height: 50.0,
                          width: MediaQuery.of(context).size.width*0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_fileName[index]),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1529e8),
                                ),
                                  onPressed: (){
                                    upLoadFile(index);
                                    },
                                  child: Text("Choose File"))
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FxText.bodyLarge(
                            'Passport Second Page',
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ),
                          // ),
                        ),

                        const SizedBox(height: 10,),
                        Container(
                          alignment: Alignment.topCenter,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.black),
                              // color: const Color(0xff1529e8),
                              borderRadius: BorderRadius.circular(4)),
                          height: 50.0,
                          width: MediaQuery.of(context).size.width*0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_fileName2[index]),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff1529e8),
                                  ),
                                  onPressed: (){
                                    upLoadFile2(index);
                                  },
                                  child: Text("Choose File"))
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FxText.bodyLarge(
                            'Passport Size Photo',
                            // textAlign: TextAlign.left,
                            letterSpacing: 0,
                            fontWeight: 600,
                          ),
                          // ),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          padding:EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width *0.9,
                          height: (_imageFile[index] == null) ?MediaQuery.of(context).size.height *0.05:
                          MediaQuery.of(context).size.height *0.08 ,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.black),
                              // color: const Color(0xff1529e8),
                              borderRadius: BorderRadius.circular(4)),
                          child: Center(
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  (_imageFile[index] == null)? Container(): Container(
                                    width:100,
                                    height:70,
                                    child: (_imageFile[index] != null)? Image.file(
                                        File( _imageFile[index]?.path ?? "" )) : Container()),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xff1529e8),
                                      ),
                                      onPressed: ()async{
                                    takePhoto(ImageSource.gallery, index);
                                  }, child: Text("Choose File"))
                                ]
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FxText.bodyLarge(
                              'Supportive Document 1',
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
                          padding: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width *0.9,
                          height: MediaQuery.of(context).size.height *0.05,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.black),
                              // color: const Color(0xff1529e8),
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_fileName3[index]),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff1529e8),
                                  ),
                                  onPressed: (){
                                    upLoadFile3(index);
                                  },
                                  child: Text("Choose File"))
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: FxText.bodyLarge(
                              'Supportive Document 2',
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
                          padding: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width *0.9,
                          height: MediaQuery.of(context).size.height *0.05,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 1, color: Colors.black),
                              // color: const Color(0xff1529e8),
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_fileName4[index]),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff1529e8),
                                  ),
                                  onPressed: (){
                                    upLoadFile4(index);
                                  },
                                  child: Text("Choose File"))
                            ],
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
                itemCount: _counterController.counter
            ),
            SizedBox(height: 10,),
            FxButton.block(
              onPressed: () {
                // controller.nextPage();
                if( _fileName.first.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Upload Passport First Page")));
                }else if(_fileName2.first.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Upload Passport Second Page")));
                }else if(_imageFile.first == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Upload Passport Image")));
                }else if(_fileName3.first.isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Upload Supportive Documents")));
                }else{
                  setState(() {
                    controller.currentPage++;
                    // isFinished1 = true;
                  });
                }

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
            SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }

  Widget _billingWidget() {
    List<Widget> list = [];
    return SizedBox(
      child: ListView.separated(
        itemCount: 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
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
                      FxSpacing.width(20),
                      // Expanded(child: Container()),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FxText.bodyMedium(
                            // '\$' + controller.order.precise,
                            "30 days single entry tourist visa",
                            fontWeight: 700,
                            textAlign: TextAlign.left,
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
                        'Transfer',
                        fontWeight: 600,
                      ),
                      // widget.selectedtourOption[index].isSharing == null
                      //     ? FxText.bodyMedium(
                      //         // '\$' + controller.order.precise,
                      //         'without',
                      //         fontWeight: 700,
                      //       )
                      //     : FxText.bodyMedium(
                      //         widget.Transfer.toString(),
                      //         fontWeight: 700,
                      //       ),

                      FxText.bodyMedium(
                        "without",
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
                        controller.fromDateTE.text,
                        fontWeight: 700,
                      ),
                      // widget.textdate.isEmpty
                      //     ? FxText.bodyMedium(
                      //         'select Date',
                      //         fontWeight: 700,
                      //       )
                      //     : FxText.bodyMedium(
                      //         // widget.textdate.toString(),
                      //         widget.selectedtourOption[index].selectedDate
                      //             .toString(),
                      //         fontWeight: 700,
                      //       ),
                    ],
                  ),
                  FxSpacing.height(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Traveller',
                        fontWeight: 600,
                      ),
                      Expanded(child: Container()),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FxContainer(
                            padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                            color: const Color(0xff1529e8).withAlpha(40),
                            child: Row(
                              children: [
                                FxText.bodyMedium(
                                    _counterController.counter.toString(),
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                                FxSpacing.width(4),
                                // FxText.bodyMedium('Adult',
                                //     color: const Color(0xff1529e8),
                                //     // color: customTheme.groceryPrimary,
                                //     fontWeight: 500,
                                //     letterSpacing: -0.2),
                              ],
                            ),
                          ),
                          // FxSpacing.width(10),
                          // FxContainer(
                          //   padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                          //   color: const Color(0xff1529e8).withAlpha(40),
                          //   child: Row(
                          //     children: [
                          //       FxText.bodyMedium(
                          //           "0",
                          //           color: const Color(0xff1529e8),
                          //           // color: customTheme.groceryPrimary,
                          //           fontWeight: 500,
                          //           letterSpacing: -0.2),
                          //       FxSpacing.width(4),
                          //       FxText.bodyMedium('child',
                          //           color: const Color(0xff1529e8),
                          //           // color: customTheme.groceryPrimary,
                          //           fontWeight: 500,
                          //           letterSpacing: -0.2),
                          //     ],
                          //   ),
                          // ),
                          // FxSpacing.width(10),
                          // FxContainer(
                          //   padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                          //   color: const Color(0xff1529e8).withAlpha(40),
                          //   child: Row(
                          //     children: [
                          //       FxText.bodyMedium(
                          //           "0",
                          //           color: const Color(0xff1529e8),
                          //           // color: customTheme.groceryPrimary,
                          //           fontWeight: 500,
                          //           letterSpacing: -0.2),
                          //       FxSpacing.width(4),
                          //       FxText.bodyMedium('Infant',
                          //           color: const Color(0xff1529e8),
                          //           // color: customTheme.groceryPrimary,
                          //           fontWeight: 500,
                          //           letterSpacing: -0.2),
                          //     ],
                          //   ),
                          // )
                        ],
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
                      FxText.bodyLarge(
                        "${_counterController.counter * widget.visa!.visaType.first.visaPrice} "
                            "${widget.visa!.visa.country.currencySymbol}",
                        color:  Colors.black,
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
                       FxText.bodyLarge(
                        "${_counterController.counter * widget.visa!.visaType.first.visaPrice} "
                            "${widget.visa!.visa.country.currencySymbol}",
                        color: Color(0xff1529e8)
                      ),
                      // FxText.bodyMedium(
                      //   // '\$' + controller.total.precise,
                      //   "AED",
                      //   fontWeight: 800,
                      //   color: const Color(0xff1529e8),
                      // ),
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

  Widget placedInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Padding(
        padding: FxSpacing.x(20),
        child: Column(
          // physics: const BouncingScrollPhysics(),
          children: [

            Lottie.asset('assets/lottie/confirmation.json',
                height: 150, width: 200),
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
                'Back',
                color: theme.colorScheme.onPrimary,
                fontWeight: 600,
              ),
            ),
          ],
        ),
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
          _billingWidget(),
          // FxText.labelLarge(
          //   'Select payment method',
          //   fontWeight: 600,
          // ),
          // FxSpacing.height(20),
          // FxContainer.bordered(
          //   onTap: () {
          //     controller.selectPaymentMethod(1);
          //   },
          //   borderRadiusAll: 10,
          //   // margin: FxSpacing.bottom(20),
          //   border: Border.all(
          //       color: controller.paymentMethodSelected == 1
          //           ? const Color(0xff1529e8)
          //           : theme.colorScheme.onBackground),
          //   color: controller.paymentMethodSelected == 1
          //       ? const Color(0xff1529e8).withAlpha(20)
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
          //             'XYZ Bank Credit Card',
          //             fontWeight: 700,
          //           ),
          //           // controller.paymentMethodSelected == 1
          //           //     ? Expanded(
          //           //       child: Align(
          //           //         alignment:
          //           //         Language.autoDirection<AlignmentGeometry>(
          //           //             Alignment.centerRight,
          //           //             Alignment.centerLeft)!,
          //           //         child: const Icon(
          //           //           Icons.radio_button_checked,
          //           //           color: Color(0xff1529e8),
          //           //           size: 20,
          //           //         ),
          //           //       ),
          //           // )
          //           //     : Container(),
          //         ],
          //       ),
          //       FxSpacing.height(8),
          //       FxText.bodySmall(
          //         'Abrar Ahmed',
          //         fontWeight: 600,
          //       ),
          //       FxSpacing.height(5),
          //       FxText.bodySmall(
          //         '**** **** **** 7865',
          //         fontWeight: 600,
          //       ),
          //       FxSpacing.height(5),
          //       FxText.bodySmall(
          //         'VALID THRU 12/27',
          //         fontWeight: 600,
          //       ),
          //       FxSpacing.height(10),
          //
          //     ],
          //   ),
          // ),
          // FxSpacing.height(20),
          // FxContainer.bordered(
          //   onTap: () {
          //     controller.selectPaymentMethod(2);
          //   },
          //   borderRadiusAll: 10,
          //   // margin: FxSpacing.bottom(20),
          //   border: Border.all(
          //       color: controller.paymentMethodSelected == 2
          //           ? const Color(0xff1529e8)
          //           : theme.colorScheme.onBackground),
          //   color: controller.paymentMethodSelected == 2
          //       ? const Color(0xff1529e8).withAlpha(20)
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
          //             'ABC Bank Debit Card',
          //             fontWeight: 700,
          //           ),
          //           // controller.paymentMethodSelected == 1
          //           //     ? Expanded(
          //           //       child: Align(
          //           //         alignment:
          //           //         Language.autoDirection<AlignmentGeometry>(
          //           //             Alignment.centerRight,
          //           //             Alignment.centerLeft)!,
          //           //         child: const Icon(
          //           //           Icons.radio_button_checked,
          //           //           color: Color(0xff1529e8),
          //           //           size: 20,
          //           //         ),
          //           //       ),
          //           // )
          //           //     : Container(),
          //         ],
          //       ),
          //       FxSpacing.height(8),
          //       FxText.bodySmall(
          //         'Britto John',
          //         fontWeight: 600,
          //       ),
          //       FxSpacing.height(5),
          //       FxText.bodySmall(
          //         '**** **** **** 3214',
          //         fontWeight: 600,
          //       ),
          //       FxSpacing.height(5),
          //       FxText.bodySmall(
          //         'VALID THRU 06/25',
          //         fontWeight: 600,
          //       ),
          //       FxSpacing.height(10),
          //
          //     ],
          //   ),
          // ),

          FxSpacing.height(20),


          FxButton.block(
            onPressed: () {

              showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    content: placedInfo(),
                  );
                },

              );
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
              'Payment',
              fontWeight: 600,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // void openFiles(List<PlatformFile> files) {
  //   show(files: files);
  // }

  void upLoadFile(index) async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
      // allowedExtensions: ['jpg', 'png'],
    );

    if (results != null) {
      final path = results.files.single.path!;

      _fileName.removeAt(index); //  ["ilfer","" , "", ];
      _fileName.insert(index,  results.files.single.name);
      // storage.uploadFile(path, fileName);
      setState(() {});
      print(_fileName);
    } else {
      // User canceled the picker
    }
  }
  void upLoadFile2(index) async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
      // allowedExtensions: ['jpg', 'png'],
    );

    if (results != null) {
      final path = results.files.single.path!;

      _fileName2.removeAt(index); //  ["ilfer","" , "", ];
      _fileName2.insert(index,  results.files.single.name);
      // storage.uploadFile(path, fileName);
      setState(() {});
      print(_fileName2);
    } else {
      // User canceled the picker
    }
  }
  void upLoadFile3(index) async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
      // allowedExtensions: ['jpg', 'png'],
    );

    if (results != null) {
      final path = results.files.single.path!;

      _fileName3.removeAt(index); //  ["ilfer","" , "", ];
      _fileName3.insert(index,  results.files.single.name);
      // storage.uploadFile(path, fileName);
      setState(() {});
      print(_fileName);
    } else {
      // User canceled the picker
    }
  }
  void upLoadFile4(index) async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.any,
      // allowedExtensions: ['jpg', 'png'],
    );

    if (results != null) {
      final path = results.files.single.path!;

      _fileName4.removeAt(index); //  ["ilfer","" , "", ];
      _fileName4.insert(index,  results.files.single.name);
      // storage.uploadFile(path, fileName);
      setState(() {});
      print(_fileName);
    } else {
      // User canceled the picker
    }
  }


}







