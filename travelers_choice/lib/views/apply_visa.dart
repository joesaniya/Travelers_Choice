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
import 'package:hotel_travel/models/visaModels/select_visa_modal.dart';
import 'package:hotel_travel/views/payment_screen.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/apply_visa_controller.dart';
import '../images.dart';
import '../localizations/language.dart';
import '../models/Country_modal.dart';
import '../models/visaModels/create_visa_modal.dart';
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
  List<PickedFile?> _passportFirstPage=[];
  List<PickedFile?> _passportSecondPage=[];
  List<PickedFile?> _supportiveDocument1=[];
  List<PickedFile?> _supportiveDocument2=[];
  List<String> _fileName = [];
  List<String> _fileName2 = [];
  List<String> _fileName3 = [];
  List<String> _fileName4 = [];
  int price = 0;
  final ImagePicker _picker = ImagePicker();
  final ImagePicker _pickerf1 = ImagePicker();
  final ImagePicker _pickerf2 = ImagePicker();
  final ImagePicker _pickerf3 = ImagePicker();
  final ImagePicker _pickerf4 = ImagePicker();

  bool isLoading = false;
  _ApplyVisaState(SelectVisaModal? visa);


  void takePhoto(ImageSource source, index)async{
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile.removeAt(index);
      _imageFile.insert(index, pickedFile!);
      // _imageFile = pickedFile;
    });
  }
  void takePhotoF1(ImageSource source, index)async{
    final pickedFile = await _pickerf1.getImage(source: source);
    setState(() {
      _passportFirstPage.removeAt(index);
      _passportFirstPage.insert(index, pickedFile!);
      // _imageFile = pickedFile;
    });
  }
  void takePhotoF2(ImageSource source, index)async{
    final pickedFile = await _pickerf2.getImage(source: source);
    setState(() {
      _passportSecondPage.removeAt(index);
      _passportSecondPage.insert(index, pickedFile!);
      // _imageFile = pickedFile;
    });
  }
  void takePhotoF3(ImageSource source, index)async{
    final pickedFile = await _pickerf3.getImage(source: source);
    setState(() {
      _supportiveDocument1.removeAt(index);
      _supportiveDocument1.insert(index, pickedFile!);
      // _imageFile = pickedFile;
    });
  }
  void takePhotoF4(ImageSource source, index)async{
    final pickedFile = await _pickerf4.getImage(source: source);
    setState(() {
      _supportiveDocument2.removeAt(index);
      _supportiveDocument2.insert(index, pickedFile!);
      // _imageFile = pickedFile;
    });
  }


  late FocusNode nameNode;

  late OutlineInputBorder outlineInputBorderenable;
  late OutlineInputBorder outlineInputBorderfocus;

String userName = "";

   CreateVisaApplication? createdVisaOrder;

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

  List? data;



  @override
  void initState() {
    theme = AppTheme.shoppingTheme;
   controller = FxControllerStore.put(ApplyVisaController(this));
    _counterController = CounterController();
    data = controller.visaApplication;
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        controller.countryId =
            sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN_countryId)!;
        // log(controller.countryId);

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
                    //
                    // Container(
                    //   child: Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: FxText.bodyLarge(
                    //       'Travellers',
                    //       // textAlign: TextAlign.left,
                    //       letterSpacing: 0,
                    //       fontWeight: 600,
                    //     ),
                    //   ),
                    //
                    // ),
                    // FxSpacing.height(10),
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
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyLarge(
                          'Choose Travellers',
                          letterSpacing: 0,
                          fontWeight: 600,
                        ),
                      ),

                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        ),
                        Row(
                          children: [
                            FxText.bodyLarge(
                              "${_counterController.counter * price} ${widget.visa!.visa.country.currencySymbol}",
                              color:  const Color(0xff1529e8),
                              decoration: TextDecoration.underline,
                            ),
                            SizedBox(width: 10,)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),

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
                              // height: 50.0,
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
                                              value.countryName[0].toUpperCase()+value.countryName.substring(1).toLowerCase(),
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
              onPressed: () async {
                // setState(() {
                //   isLoading =true;
                // });
                print(controller.selectedTitle.first);
                if(controller.formKey.currentState!.validate()) {
                  // controller.formKey.currentState!.save();

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
                    "country": "63ac33ecff04e5652a2583f5"
                  };


                  print(body);

                  // controller.visaApplication.add(createdVisaOrder!.totalAmount)
                  createdVisaOrder = await  controller.postCreateVisa(
                          body
                      );


                 print("resultresult ======== ${createdVisaOrder!.totalAmount}");


                 if(createdVisaOrder!=null && createdVisaOrder!.noOfTravellers!=null){
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
              child:  FxText.labelMedium(
                'Proceed Payment',
                color: theme.colorScheme.onPrimary,
                fontWeight: 600,
              )
            ),
            FxSpacing.height(5),
          ]),
    );
  }

  void upLoadFile(index) async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
      // allowedExtensions: ['jpg', 'png'],
    );

    if (results != null) {
      final path1 = results.files.single.path!;

      _fileName.removeAt(index); //  ["ilfer","" , "", ];
      _fileName.insert(index,  results.files.single.name);
      // storage.uploadFile(path, fileName);
      setState(() {});
      print(_fileName);
      print(results.files.single.name);
      print(path1);

    } else {
      // User canceled the picker
    }
  }
  void upLoadFile2(index) async {
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
      // allowedExtensions: ['jpg', 'png'],
    );

    if (results != null) {
      final path2 = results.files.single.path!;

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
      final path3 = results.files.single.path!;

      _fileName3.removeAt(index); //  ["ilfer","" , "", ];
      _fileName3.insert(index,  results.files.single.name);
      // storage.uploadFile(path, fileName);
      setState(() {});
      print(_fileName3);
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
      final path4 = results.files.single.path!;

      _fileName4.removeAt(index); //  ["ilfer","" , "", ];
      _fileName4.insert(index,  results.files.single.name);
      // storage.uploadFile(path, fileName);
      setState(() {});
      print(_fileName4);
    } else {
      // User canceled the picker
    }
  }


  Widget uploadDetails() {
    var onwardDateResponse = createdVisaOrder!.onwardDate;
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
                _supportiveDocument1.add(null);
                _passportFirstPage.add(null);
                _passportSecondPage.add(null);
                _supportiveDocument2.add(null);
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
                                                    text: '${createdVisaOrder!.travellers![index].firstName}',
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
                                                    text: '${createdVisaOrder!.travellers![index].lastName}',
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
                                                    text: '${createdVisaOrder!.travellers![index].dateOfBirth.day}/${createdVisaOrder!.travellers![index].dateOfBirth.month}/'
                                                        '${createdVisaOrder!.travellers![index].dateOfBirth.year}',
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
                                                    text: "${onwardDateResponse!.day.toString()}/${onwardDateResponse.month.toString()}/${onwardDateResponse.year.toString()}",
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
                                                    text: '${createdVisaOrder!.travellers![index].passportNo}',
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
                                                    text: '${createdVisaOrder!.travellers![index].expiryDate.day}/${createdVisaOrder!.travellers![index].expiryDate.month}/${createdVisaOrder!.travellers![index].expiryDate.year}',
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

                        Row(
                          children: [
                            Container(
                              height: 100,
                              width:100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 1,color: Colors.black),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: (_passportFirstPage[index] != null)? Image.file(
                                File( _passportFirstPage[index]?.path ?? "" ,),fit: BoxFit.fitWidth,) : Container(),
                            ),
                            SizedBox(width:5),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1529e8),
                                ),
                                onPressed: ()async{
                                  takePhotoF1(ImageSource.gallery, index);
                                },
                                child: Text("Choose File"))
                          ],
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
                        Row(
                          children: [
                            Container(
                              height: 100,
                              width:100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 1,color: Colors.black),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: (_passportSecondPage[index] != null)? Image.file(
                                File( _passportSecondPage[index]?.path ?? "" ,),fit: BoxFit.fitWidth,) : Container(),
                            ),
                            SizedBox(width: 5,),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1529e8),
                                ),
                                onPressed: ()async{
                                  takePhotoF2(ImageSource.gallery, index);
                                },
                                child: Text("Choose File"))
                          ],
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
                        Row(
                          children: [
                            
                            Container(
                              height: 100,
                              width:100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 1,color: Colors.black),
                                borderRadius: BorderRadius.circular(4)
                              ),
                              child: (_imageFile[index] != null)? Image.file(
                                          File( _imageFile[index]?.path ?? "" ,),fit: BoxFit.fitWidth,) : Container(),
                            ),
                            SizedBox(width: 10,),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff1529e8),
                                  ),
                                  onPressed: ()async{
                                    takePhoto(ImageSource.gallery, index);
                                  }, child: Text("Upload photo")),
                            )
                          ],
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
                        Row(
                          children: [
                            Container(
                              height: 100,
                              width:100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 1,color: Colors.black),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: (_supportiveDocument1[index] != null)? Image.file(
                                File( _supportiveDocument1[index]?.path ?? "" ,),fit: BoxFit.fitWidth,) : Container(),
                            ),
                            SizedBox(width: 5,),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1529e8),
                                ),
                                onPressed: ()async{
                                  takePhotoF3(ImageSource.gallery, index);
                                },
                                child: Text("Choose File"))

                          ],
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
                        Row(
                          children: [
                            Container(
                              height: 100,
                              width:100,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(width: 1,color: Colors.black),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: (_supportiveDocument2[index] != null)? Image.file(
                                File( _supportiveDocument2[index]?.path ?? "" ,),fit: BoxFit.fitWidth,) : Container(),
                            ),
                            SizedBox(width:5),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff1529e8),
                                ),
                                onPressed: ()async{
                                  takePhotoF4(ImageSource.gallery, index);
                                },
                                child: Text("Choose File"))

                          ],
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

                if( _passportFirstPage.first == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Upload Passport First Page")));
                }else if(_passportSecondPage.first == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Upload Passport Second Page")));
                }else if(_imageFile.first == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Upload Passport Image")));
                }else if(_supportiveDocument1.first == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Upload Supportive Documents")));
                }else if(_supportiveDocument2.first == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please Upload Supportive Documents")));
                }else{
                  // controller.postDocumentUpload(map);

                  controller.postDocumentUpload(
                    image1:  File(_passportFirstPage.first!.path),
                    image2:  File(_passportSecondPage.first!.path),
                      image3:File(_imageFile.first!.path),
                     image4: File(_supportiveDocument1.first!.path),
                     image5: File(_supportiveDocument2.first!.path),
                   // id: createdVisaOrder!.travellers!.first.id
                  );

                  print(_passportFirstPage.first!.path);
                  setState(() {

                    // controller.currentPage++;
                    // isFinished1 = true;
                  });
                }

              },
              borderRadiusAll: 4,
              elevation: 0,
              splashColor: const Color(0xff1529e8).withAlpha(40),
              backgroundColor: const Color(0xff1529e8),
              child: FxText.bodyMedium(
                'Upload Documents',
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
   var onwardDateResponse = createdVisaOrder!.onwardDate;
   var returnDateResponse = createdVisaOrder!.returnDate;
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
                        'Visa',
                        fontWeight: 600,
                      ),
                      FxSpacing.width(20),
                      // Expanded(child: Container()),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FxText.bodyMedium(
                            // '\$' + controller.order.precise,
                            createdVisaOrder!.visaType.toString(),
                            fontWeight: 700,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // FxSpacing.height(4),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     FxText.bodyMedium(
                  //       'Transfer',
                  //       fontWeight: 600,
                  //     ),
                  //
                  //     FxText.bodyMedium(
                  //       "without",
                  //       fontWeight: 700,
                  //     ),
                  //   ],
                  // ),
                  FxSpacing.height(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Onward Date',
                        fontWeight: 600,
                      ),
                      FxText.bodyMedium(
                        "${onwardDateResponse!.day.toString()}/${onwardDateResponse.month.toString()}/${onwardDateResponse.year.toString()}",
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
                        'Return Date',
                        fontWeight: 600,
                      ),
                      FxText.bodyMedium(
                        "${returnDateResponse!.day.toString()}/${returnDateResponse.month.toString()}/${returnDateResponse.year.toString()}",
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
                        'Travellers',
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
                                    createdVisaOrder!.noOfTravellers.toString(),
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
                        'Visa price',
                        fontWeight: 600,
                      ),
                      FxText.bodyLarge(
                        "${ createdVisaOrder!.visaPrice} "
                            "${widget.visa!.visa.country.currencySymbol}",
                        color:  Colors.black,
                      ),
                    ],
                  ),
                  FxSpacing.height(4),
                  (createdVisaOrder!.noOfTravellers == 1) ? Container() : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Amount',
                        fontWeight: 600,
                      ),
                      FxText.bodyLarge(
                        "${createdVisaOrder!.totalAmount.toString()} "
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
                        "${createdVisaOrder!.totalAmount.toString()} "
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
    String? visaOrderId = createdVisaOrder!.id;

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
          payment(
              "assets/images/apps/shopping2/icons/cc-avenue.png", "CCavenue"),

          FxSpacing.height(20),


          FxButton.block(
            onPressed: () {

              // showDialog(
              //   context: context,
              //   builder: (BuildContext context){
              //     return AlertDialog(
              //       content: placedInfo(),
              //     );
              //   },
              //
              // );
              // controller.openGateway(visaOrderId!);
              // controller.initPlatformState();
              // setState(() {
              print(visaOrderId);
              controller.createVisaOrderccAvenue(visaOrderId!);
                // controller.currentPage++;
              //   // isFinished1 = true;
              // });

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

  // Widget getSinglePayment(
  //     {int? index, required String image, required String method}) {
  //   log('method:$method');
  //   log('index:$index');
  //   bool isSelected = index == controller.selectedPayment;
  //
  //   return FxContainer(
  //     onTap: () {
  //       setState(() {
  //         controller.selectedPayment = index;
  //       });
  //     },
  //     margin: FxSpacing.bottom(16),
  //     padding: FxSpacing.all(16),
  //     bordered: !isSelected,
  //     border: Border.all(
  //       // color: customTheme.border
  //         color: Colors.indigo),
  //     color: isSelected ? Colors.white : Colors.transparent,
  //     // color: isSelected ? customTheme.card : theme.scaffoldBackgroundColor,
  //     borderRadiusAll: 8,
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         SizedBox(
  //           width: 48,
  //           height: 36,
  //           child: Image.asset(
  //             image,
  //           ),
  //         ),
  //         FxSpacing.width(16),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               FxText.bodyMedium(method, fontWeight: 600),
  //               // FxSpacing.height(8),
  //               // FxText.labelSmall(
  //               //     "8765  \u2022\u2022\u2022\u2022  \u2022\u2022\u2022\u2022  7983",
  //               //     muted: true,
  //               //     letterSpacing: 0)
  //             ],
  //           ),
  //         ),
  //         // isSelected ? Space.width(16) : Space.width(20),
  //         isSelected
  //             ? Container(
  //           padding: FxSpacing.all(8),
  //           decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               color: const Color(0xff1529e8).withAlpha(40)),
  //           child: const Icon(
  //             FeatherIcons.check,
  //             color: Color(0xff1529e8),
  //             size: 14,
  //           ),
  //         )
  //             : Container(
  //           height: 26,
  //           width: 26,
  //           decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               border: Border.all(color: const Color(0xff1529e8))),
  //         ),
  //       ],
  //     ),
  //   );
  // }
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

  // void openFiles(List<PlatformFile> files) {
  //   show(files: files);
  // }



}







