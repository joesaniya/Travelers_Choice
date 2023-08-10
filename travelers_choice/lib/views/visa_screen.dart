import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/models/visaModels/select_visa_modal.dart';
import 'package:hotel_travel/models/visaModels/visa_country_modal.dart';
import 'package:hotel_travel/services/visa_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../controllers/visa_controller.dart';
import '../loading_effect.dart';
import 'apply_visa.dart';
import 'bottomSheet/visa_enquire_bottom.dart';

class VisaScreen extends StatefulWidget {
  final VisaCountryModal place;

  const VisaScreen({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> with TickerProviderStateMixin {
  // late ThemeData theme;
  // late OutlineInputBorder outlineInputBorder;
  late VisaController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = FxControllerStore.put(VisaController(this));
    VisaService().getSelectVisa(widget.place.id);
    fetchData();
    // theme = AppTheme.shoppingTheme;

    // outlineInputBorder = const OutlineInputBorder(
    //     borderSide: BorderSide(
    //         color: Color(0xff1529e8),
    //         // color: Colors.lightBlueAccent,
    //         width: 0));
  }

  fetchData() {
    Future.delayed(Duration.zero, () async {
      await getVisa().then((value) {
        if (value) {
          isLoading = false;
          setState(() {});
        }
      });
    });
  }

  SelectVisaModal? selectVisa;
  bool isCountryListLoading = true;
  Future getVisa() async {
    isCountryListLoading = true;
    try {
      var data = await VisaService().getSelectVisa(widget.place.id);
      if (data != null) {
        setState(() {});
        // countryList.add(data);
        selectVisa = data;

        isCountryListLoading = false;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  List<String> list = [
    "Visa application fees along with the service charge are non-refundable in all cases. Even in case of visa application rejection the entire amount is non-refundable.",
    "Visa application approval/rejection and processing time is at the sole discretion of the immigration and we do not have any control over the same.",
    "Visa applications may require more than usual working days for processing and it is completely dependent on the immigration.",
    "Immigration/Akbartravels.com may ask for additional documents on a case to case basis.",
    "Prices are correct at the time of publication and are subject to change without notice.",
    "Visa applications processing will only be after the verification of all required documents and receipt of complete payment",
    "Visas issued under visit/business/transit/tourist profession are not eligible to work in the destination country.",
    "Traveller or the customer has to fully bear the penalty amount in case the destination country levy any charges.",
  ];

  bool disableCard = false;
  List<String> lastString = [
    "Policy",
    "Terms and settings",
    "Partners",
    "About"
  ];
  String searchText = "";

  Widget visaList() {
    var text = selectVisa!.visa.termsAndConditions.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        FxText.bodyLarge(
          'Types of ${selectVisa!.visa.name}',
          fontSize: 20,
          fontWeight: 600,
        ),

        const SizedBox(
          height: 15,
        ),

        ListView.separated(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shadowColor: Colors.black,
                elevation: 7,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: const Color(0xff5c69e0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1.5)),
                  // decoration: BoxDecoration(
                  //         // color:Color(0xff1529e8).withAlpha(20),
                  //         borderRadius: BorderRadius.circular(15),
                  //       //   gradient: const LinearGradient(
                  //       //     colors: [
                  //       //       Color(0xff1529e8),
                  //       //       Color(0xff5c69e0),
                  //       //       Color(0xff1529e8),
                  //       //     ],
                  //       //     begin: Alignment.topLeft,
                  //       //     end: Alignment.bottomRight,
                  //       //   ),
                  //   color:Colors.white,
                  //
                  // ),
                  margin: const EdgeInsets.only(
                    top: 8,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      FxText.bodyLarge(
                        selectVisa!.visaType[index].visaName,
                        textAlign: TextAlign.center,
                        fontSize: 20,
                        fontWeight: 600,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FxText.bodyMedium(
                        "${selectVisa!.visa.country.currencySymbol} ${selectVisa!.visaType[index].visaPrice}",
                        textAlign: TextAlign.center,
                        fontSize: 16,
                        fontWeight: 600,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FxText.bodyMedium(
                        "${selectVisa!.visaType[index].visaName} Medical Insurance (COVID)",
                        textAlign: TextAlign.center,
                        fontSize: 16,
                        fontWeight: 600,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FxText.bodyMedium(
                            "Child age Limit: ${selectVisa!.visaType[index].ageFrom}",
                            // textAlign: TextAlign.center,
                            fontSize: 16,
                            fontWeight: 600,
                          ),
                          FxText.bodyMedium(
                            "Adult age Limit: ${selectVisa!.visaType[index].ageTo}",
                            // textAlign: TextAlign.center,
                            fontSize: 16,
                            fontWeight: 600,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              );
              //   Container(
              //   width: MediaQuery.of(context).size.width *0.7,
              //   child: Card(
              //     // color:  Color(0xff4741f0),
              //     shadowColor: Colors.black,
              //     elevation: 7,
              //     shape:RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15),
              //       // side: const BorderSide(
              //       //   width: 2,
              //       //   color: Color(0xff1529e8),
              //       // ),
              //     ),
              //     child: Container(
              //
              //       padding: EdgeInsets.all(10),
              //       decoration: BoxDecoration(
              //         color:Color(0xff1529e8).withAlpha(20),
              //         borderRadius: BorderRadius.circular(15),
              //       //   gradient: const LinearGradient(
              //       //     colors: [
              //       //       Color(0xff1529e8),
              //       //       Color(0xff5c69e0),
              //       //       Color(0xff1529e8),
              //       //     ],
              //       //     begin: Alignment.topLeft,
              //       //     end: Alignment.bottomRight,
              //       //   ),
              //       ),
              //       child: Column(
              //         children: [
              //           const SizedBox(height: 5,),
              //           FxText.bodyLarge(
              //             selectVisa!.visaType[index].visaName,
              //             textAlign: TextAlign.center,
              //             fontSize: 20,
              //             fontWeight: 700,
              //           ),
              //           const SizedBox(height: 10,),
              //           FxText.bodyMedium( "${selectVisa!.visa.country.currencySymbol} ${selectVisa!.visaType[index].visaPrice}",
              //             textAlign: TextAlign.center,
              //           fontSize: 16,
              //             fontWeight: 600,
              //           ),
              //           const SizedBox(height: 10,),
              //           FxText.bodyMedium(
              //             "${selectVisa!.visaType[index].visaName} Medical Insurance (COVID)",
              //             textAlign: TextAlign.center,
              //             fontSize: 16,
              //             fontWeight: 600,
              //           ),
              //           const SizedBox(height: 10,),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               FxText.bodyMedium(
              //                 "Child age Limit: ${selectVisa!.visaType[index].ageFrom}",
              //                 // textAlign: TextAlign.center,
              //                 fontSize: 16,
              //                 fontWeight: 600,
              //               ),
              //               FxText.bodyMedium(
              //                 "Adult age Limit: ${selectVisa!.visaType[index].ageTo}",
              //                 // textAlign: TextAlign.center,
              //                 fontSize: 16,
              //                 fontWeight: 600,
              //               ),
              //             ],
              //           ),
              //           const SizedBox(height: 5,),
              //         ],
              //       ),
              //     ),
              //   ),
              // );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 20,
              );
            },
            itemCount: selectVisa!.visaType.length),

        const SizedBox(
          height: 20,
        ),

        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.grey.shade300, width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FxText.bodyMedium(
                    selectVisa!.visa.details[index].title,
                    fontSize: 20,
                    fontWeight: 600,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // FxText.bodySmall('\u2022',style: const TextStyle(fontSize: 25),),
                      const SizedBox(width: 10),
                      Expanded(
                          child: FxText.bodySmall(
                        selectVisa!.visa.details[index].body,
                        fontSize: 16,
                      ))
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: selectVisa!.visa.details.length,
        ),

        const SizedBox(height: 20),

        InkWell(
            onTap: () {},
            child: Card(
                elevation: 5,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      // color: Color(0xffe6e1e5),
                      color: Colors.white,
                      // color: Color(0xffe5fdfd),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border:
                          Border.all(color: Colors.grey.shade300, width: 1)),
                  child: ListTile(
                    leading: Icon(
                      Icons.file_copy_outlined,
                      color: Colors.indigo.shade800,
                    ),
                    title: FxText.bodyMedium(
                      "View Sample Visa Copy",
                      color: Colors.indigo.shade800,
                    ),
                  ),
                ))
            // Container(
            //   height: 80,
            //   width: MediaQuery.of(context).size.width,
            //
            //   padding: const EdgeInsets.all(10),
            //   color:  const Color(0xff1529e8),
            //   child: Row(
            //     children: [
            //       const Icon(Icons.file_copy_outlined,color: Colors.white,size: 35,),
            //       const SizedBox(width: 15,),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           FxText.bodyMedium("View Sample Visa Copy",
            //              fontSize: 18,
            //             fontWeight: 600,
            //             color: Colors.white,
            //           ),
            //           const SizedBox(height: 10,),
            //           FxText.bodyMedium("For better understanding click here!!",
            //               fontSize: 16,
            //             fontWeight: 500,
            //             color: Colors.white,
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            ),

        const SizedBox(
          height: 20,
        ),

        FxText.bodyMedium(
          " ${selectVisa!.visa.name} FAQs",
          fontSize: 20,
          fontWeight: 600,
        ),

        const SizedBox(
          height: 10,
        ),

        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return ExpandableNotifier(
                child: ScrollOnExpand(
              child: Card(
                color: Colors.white,
                clipBehavior: Clip.antiAlias,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    iconColor: Colors.transparent,
                  ),
                  header: ListTile(
                      leading: Icon(
                        Icons.add,
                        color: Colors.indigo.shade800,
                      ),
                      title: FxText.bodyMedium(
                        // "Can I get Dubai Visa on Arrival"
                        selectVisa!.visa.faqs[index].question,
                        fontSize: 14,
                        fontWeight: 500,
                        color: Colors.indigo.shade800,
                      )),
                  collapsed: Container(),
                  expanded: Padding(
                    padding: const EdgeInsets.all(15),
                    child: FxText.bodyMedium(
                      selectVisa!.visa.faqs[index].answer,
                      fontSize: 14,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ));
          },
          itemCount: selectVisa!.visa.faqs.length,
        ),

        const SizedBox(
          height: 10,
        ),

        // Container(
        //   padding: EdgeInsets.all(10),
        //   decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: const BorderRadius.all(Radius.circular(10)),
        //       border: Border.all(color: Colors.grey.shade300, width: 1)),
        //   child:  Column(
        //
        //     children: [
        //       // InkWell(
        //       //   onTap: (){
        //       //
        //       //   },
        //       //   child: FxText(
        //       //     "Terms and conditions"
        //       //   ),
        //       // )
        //       // Padding(
        //       //   padding: EdgeInsets.all(8.0),
        //       //   child: Align(
        //       //     alignment: Alignment.topLeft,
        //       //     child: FxText.bodyLarge("${selectVisa!.visa.name} Terms & Conditions",
        //       //       fontSize: 20,
        //       //       fontWeight: 600,
        //       //
        //       //     ),
        //       //   ),
        //       // ),
        //       Padding(
        //           padding:  EdgeInsets.all(8.0),
        //           child: Html(
        //             data:text.toString(),
        //            style: {
        //              'body':Style(
        //                 textAlign: TextAlign.center,
        //                color: Colors.pink
        //              )
        //            },
        //           )
        //         // ListView.separated(
        //         //   padding: EdgeInsets.zero,
        //         //   physics: const NeverScrollableScrollPhysics(),
        //         //   shrinkWrap: true,
        //         //     itemCount: list.length,
        //         //     itemBuilder: (BuildContext context, int index) {
        //         //       return  Text(
        //         //         "${index +1}. ${list[index]}",
        //         //         style: const TextStyle(
        //         //             fontSize: 16,
        //         //             color: Colors.grey),
        //         //         textAlign: TextAlign.justify,
        //         //       );
        //         //     }, separatorBuilder: (BuildContext context, int index) {
        //         //     return const SizedBox(height: 10,);
        //         // },
        //         // ),
        //       )
        //     ],
        //   ),
        // ),

        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget applyNow() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ApplyVisa(visa: selectVisa)));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff1529e8),
              minimumSize: Size(MediaQuery.of(context).size.width * 0.9, 40),
            ),
            child: const Text(
              "Apply Online",
              style: TextStyle(fontSize: 16),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<VisaController>(
        controller: controller,
        builder: (controller) {
          return _visaWidget(selectVisa);
        });
  }

  Widget _visaWidget(SelectVisaModal? selectVisa) {
    if (selectVisa == null) {
      return Scaffold(
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
        floatingActionButton: Padding(
          // padding: const EdgeInsets.only(bottom: 8.0),
          padding: FxSpacing.y(45),
          child: FloatingActionButton.extended(
            onPressed: () async{
              var data = await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  shape: const RoundedRectangleBorder(
                    // <-- SEE HERE
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  builder: (BuildContext buildContext) {
                    return const VisaEnquireBottom();
                  });
              setState(() {});              // Add your onPressed code here!
            },
            label: FxText.bodyMedium(
              "Enquire",
              fontWeight: 700,
              // color: const Color(0xff1529e8),
              color: Colors.white,
            ),
            icon: const Icon(
              MdiIcons.contacts,
              color: Colors.white,
              // color: const Color(0xff1529e8).withAlpha(240),
            ),
            backgroundColor: const Color(0xff1529e8),
            // backgroundColor: const Color(0xff1529e8).withOpacity(0.4),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0xff1529e8),
                      Color(0xff5c69e0),
                    ],
                  ),
                ),

                height: 200,
                // height: MediaQuery.of(context).size.height / 3.7,
                child: ListView(
                  children: [
                    // const SizedBox(
                    //   // height: 25,
                    //   height: 10,
                    // ),
                    FxSpacing.height(10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        if (!disableCard)
                          Expanded(
                            flex: 12,
                            child: Card(
                              shadowColor: Colors.black,
                              elevation: 6,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                height: 65,
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: const EdgeInsets.all(10),
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FxText.bodyLarge(
                                        "Explore Visas for",
                                        fontSize: 16,
                                        fontWeight: 700,
                                      ),
                                      FxText.bodyLarge(
                                        "I'm open to anywhere",
                                        fontSize: 14,
                                        fontWeight: 500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 2,
                          child: AnimatedContainer(
                            width: disableCard
                                ? MediaQuery.of(context).size.width * 0.9
                                : MediaQuery.of(context).size.height * 0.06,
                            height: MediaQuery.of(context).size.height * 0.06,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            duration: const Duration(milliseconds: 300),
                            child: !disableCard
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        disableCard = true;
                                      });
                                    },
                                    child: const Icon(Icons.search_rounded))
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              disableCard = false;
                                            });
                                          },
                                          child:
                                              const Icon(Icons.arrow_back_ios)),
                                      Expanded(
                                          child: TextField(
                                        controller: controller.visaController,
                                        decoration: const InputDecoration(
                                          hintText: "Search",
                                          border: InputBorder.none,
                                        ),
                                      )),
                                      InkWell(
                                          onTap: () {
                                            controller.visaController.clear();
                                          },
                                          child: const Icon(Icons.close)),
                                      const SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // Container(
                    //   height: 65,
                    //   width: MediaQuery
                    //       .of(context)
                    //       .size
                    //       .width,
                    //   child: TabBar(
                    //     controller: controller.tabController,
                    //     onTap: (index) {
                    //       setState(() {
                    //         controller.tabController.index = index;
                    //       });
                    //     },
                    //     labelColor: Colors.white,
                    //     unselectedLabelColor: Colors.white60,
                    //     // indicatorWeight: 0,
                    //     // unselectedLabelColor: Colors.black.withOpacity(0.6),
                    //     labelStyle: const TextStyle(
                    //         fontFamily: 'inter', fontWeight: FontWeight.w500),
                    //     isScrollable: true,
                    //     // indicatorSize: TabBarIndicatorSize.label,
                    //     indicatorColor: Colors.transparent,
                    //     // indicator: RectangularIndicator(
                    //     //   bottomLeftRadius: 15,
                    //     //   bottomRightRadius: 15,
                    //     //   topLeftRadius: 15,
                    //     //   topRightRadius: 15,
                    //     //   paintingStyle: PaintingStyle.stroke,
                    //     //   strokeWidth: 0,
                    //     //   color: Colors.white
                    //     // ),
                    //     tabs: [
                    //       Tab(
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(
                    //               left: 10, right: 5),
                    //           child: Center(child:
                    //           Column(
                    //             children: const [
                    //               Text("Visa"),
                    //               SizedBox(height: 3,),
                    //               Icon(Icons.credit_card),
                    //             ],
                    //           ),
                    //
                    //
                    //           ),
                    //         ),
                    //       ),
                    //       Tab(
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(
                    //               left: 10, right: 5),
                    //           child: Center(child:
                    //           Column(
                    //             children: const [
                    //               Text("Documents"),
                    //               SizedBox(height: 3,),
                    //               Icon(Icons.file_copy_outlined),
                    //             ],
                    //           ),
                    //           ),
                    //         ),
                    //       ),
                    //       Tab(
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(
                    //               left: 10, right: 5),
                    //           child: Center(child:
                    //           Column(
                    //             children: const [
                    //               Text("FAQs"),
                    //               SizedBox(height: 3,),
                    //               Icon(Icons.format_quote),
                    //             ],
                    //           ),
                    //           ),
                    //         ),
                    //       ),
                    //       Tab(
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(
                    //               left: 10, right: 5),
                    //           child: Center(child:
                    //           Column(
                    //             children: const [
                    //               Text("Terms"),
                    //               SizedBox(height: 3,),
                    //               Icon(Icons.menu_open_outlined),
                    //             ],
                    //           ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                physics: const AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  IndexedStack(
                    index: controller.tabController.index,
                    children: [
                      visaList(),

                      const Text("Documents",
                          style: TextStyle(color: Colors.black)),

                      // const Text("Process"),

                      const Text("FAQs", style: TextStyle(color: Colors.black)),

                      const Text("Terms & conditions"),
                    ],
                  ),
                ],
              ),
            ),
            applyNow()
          ],
        ),
      );
    }
  }
}
