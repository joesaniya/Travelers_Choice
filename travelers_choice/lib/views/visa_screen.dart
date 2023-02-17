
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:hotel_travel/models/select_visa_modal.dart';
import 'package:hotel_travel/models/visa_country_modal.dart';
import 'package:hotel_travel/services/visa_service.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../controllers/visa_controller.dart';
import 'apply_visa.dart';


class VisaScreen extends StatefulWidget {

  final VisaCountryModal place;


  const VisaScreen({Key? key, required this.place ,}) : super(key: key);

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen>
    with TickerProviderStateMixin {
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

  SelectVisaModal? selectVisa ;
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


  List<String> list =[
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
  String searchText="";

  Widget visaList(){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          FxText.bodyLarge(
            'Types of Dubai visa',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 10,),

          ListView.separated(
              padding: EdgeInsets.zero,

              // scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext, int index){
                return Card(
                  // color:  Color(0xff4741f0),
                  shadowColor: Colors.black,
                  elevation: 7,
                  shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(
                      width: 2,
                      color: Color(0xff1529e8),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:Color(0xff1529e8).withAlpha(20),
                      borderRadius: BorderRadius.circular(15),
                    //   gradient: const LinearGradient(
                    //     colors: [
                    //       Color(0xff1529e8),
                    //       Color(0xff5c69e0),
                    //       Color(0xff1529e8),
                    //     ],
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight,
                    //   ),
                    ),
                    child: Column(
                      children: const[
                        Text(
                          "30 Days Single Entry Tourist Visa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(height: 10,),
                        Text("AED 320.00",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              fontSize: 20,
                              // fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "30 days UAE Tourist Visa Medical Insurance (COVID)",
                          textAlign: TextAlign.center,
                          style:  TextStyle(
                              fontSize: 20,
                              // fontWeight: FontWeight.w600,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext, int index){
            return const SizedBox(height: 20,);
          },
              itemCount: 4),

          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                const Text("Documents required for Dubai visa",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('\u2022',style: TextStyle(fontSize: 25),),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(
                          "Scanned color copy of first and last page of your valid passport",
                          style: TextStyle(fontSize: 18,color: Colors.grey),)
                    )
                  ],
                ) ,

                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('\u2022',style: TextStyle(fontSize: 25),),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(
                          "Scanned color copy of your passport size photograph with white background",
                          style: TextStyle(fontSize: 18,color: Colors.grey),)
                    )
                  ],
                ),

                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('\u2022',style: TextStyle(fontSize: 25),),
                    SizedBox(width: 10),
                    Expanded(
                        child: Text(
                          "Confrimed return air ticket (requires for Ok to Board processing)",
                          style: TextStyle(fontSize: 18,color: Colors.grey),)
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height:20),

          InkWell(
            onTap: (){},
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              color:  const Color(0xff1529e8),
              child: Row(

                children: [
                  const Icon(Icons.file_copy_outlined,color: Colors.white,size: 35,),
                  const SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:const [
                      Text("View Sample Visa Copy",
                          style:TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            fontWeight: FontWeight.w600
                          )
                      ),
                      SizedBox(height: 10,),
                      Text("For better understanding click here!!",
                          style:TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

          const SizedBox(height: 20,),

          const Text("Dubai Visa FAQs",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 10,),

          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return  ExpandableNotifier(
                  child: ScrollOnExpand(
                    child: Card(
                      color: Colors.white,
                      clipBehavior: Clip.antiAlias,
                      child: ExpandablePanel(
                        theme: const ExpandableThemeData(
                          iconColor: Colors.transparent,
                        ),
                        header: const ListTile(
                            leading: Icon(Icons.add),
                            title: Text("Can I get Dubai Visa on Arrival",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff1529e8)
                              ),
                            )
                        ),
                        collapsed: Container(),
                        expanded:const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Yes, Citizens of few countries do not require advance"
                                " visa arrangements to enter the UAE and can obtain a Dubai visa "
                              "on arrival. Indian nationals holding a normal passport and a "
                              "valid Visa, or a Green Card issued by the USA, or UK or EU "
                              "Residency, can obtain a Dubai Tourist visa on arrival for a "
                              "maximum stay of 14 days. The US Visa, the Green Card, the UK"
                              " Resident Permit and the EU Resident Permit must be valid for"
                              " at least six months from the date of arrival into the UAE. "
                              "The Dubai visa on arrival will be valid for 14 days, extendable "
                              "for a similar period one time only. The validity of the passport"
                              " must be not less than six months and the fee for an entry "
                              "permit will be Dirham 100 (Rs 1,750).",
                          style: TextStyle(fontSize: 18,color: Colors.grey),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ),
                  ));
            },
            itemCount: 4,
          ),

          const SizedBox(height: 10,),

          Container(
            color: Colors.white,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Dubai Visa Services - Terms & Conditions",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return  Text(
                          "${index +1}. ${list[index]}",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey),
                          textAlign: TextAlign.justify,
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10,);
                  },
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 10,),

          Container(
            padding:const EdgeInsets.all(10),
            color:Colors.black,
            child: Column(
              children: [
                ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return  ExpandableNotifier(
                        child: ScrollOnExpand(
                          child: ExpandablePanel(
                            theme: const ExpandableThemeData(
                              iconColor: Colors.transparent,
                            ),
                            header: ListTile(
                                title: Text(lastString[index],
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color:Colors.grey
                                  ),
                                ),
                            ),
                            collapsed: Container(),
                            expanded:const Padding(
                              padding:  EdgeInsets.all(15),
                              child: Text("Travel Policy\nTravel Communities",
                                style: TextStyle(fontSize: 18,color: Colors.grey),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        )
                    );
                  },
                  itemCount: 4, separatorBuilder: (BuildContext context, int index) {
                    return const Divider(height: 1,color: Colors.grey,);
                },
                ),

                const Divider(height: 1,color: Colors.grey,),

                const SizedBox(height: 10,),
                Column(
                  children: const [
                    Text("License No.671267",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    Text("Copyright © 1996–2023 TravellersChoice.com™. All rights reserved.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey
                    ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                  ],
                )
              ],
            ),
          ),

        ],

    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<VisaController>(
        controller: controller,
        builder: (controller) {
          return _visaWidget();
        });
  }

  Widget _visaWidget() {
      return Scaffold(
          backgroundColor:  const Color(0xfff5f5f5),
          body: Column(
            children: [
              Expanded(
                  flex: 4,
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
                    // color: Colors.blue,
                    height: MediaQuery.of(context).size.height/3.65,
                    child: ListView(
                      children: [
                        const SizedBox(height: 30,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(width: 10,),

                            if(!disableCard )
                              Expanded(
                                flex:  12,
                                child: Card(
                                  shadowColor: Colors.black,
                                  elevation: 6,
                                  clipBehavior: Clip.antiAlias,
                                  shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width*0.8,
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: Colors.white
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text("Explore Visas for",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800
                                            ),
                                          ),
                                          Text("I'm open to anywhere",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            const SizedBox(width: 5,),

                            Expanded(
                              flex: 2,
                              child: AnimatedContainer(
                                width: disableCard ? MediaQuery.of(context).size.width*0.9 :
                                MediaQuery.of(context).size.height *0.06,
                                height: MediaQuery.of(context).size.height *0.06,
                                decoration: const BoxDecoration(
                                    color:Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(30))),
                                duration: const Duration(milliseconds: 300),
                                child:
                                !disableCard ? InkWell(
                                    onTap: (){
                                      setState(() {
                                        disableCard=true;
                                      });
                                    },
                                    child: const Icon(Icons.search_rounded)) :
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 10,),
                                      InkWell(
                                          onTap: (){
                                            setState(() {
                                              disableCard=false;
                                            });
                                          },
                                          child: const Icon(Icons.arrow_back_ios)),
                                      Expanded(
                                          child: TextField(
                                        controller: controller.visaController,
                                            decoration: const InputDecoration(
                                              hintText: "Search",
                                              border: InputBorder.none,
                                            ),
                                      )),
                                      InkWell(
                                          onTap: (){
                                            controller.visaController.clear();
                                          },
                                          child: const Icon(Icons.close)),
                                      const SizedBox(width: 10,)
                                    ],
                                  ),
                              ),
                            ),

                          const SizedBox(width: 5,)

                        ],
                        ),

                        const SizedBox(height: 15,),

                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: TabBar(
                            controller: controller.tabController,
                            onTap: (index) {
                              setState(() {
                                controller.tabController.index = index;
                              });
                            },
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.white60,
                            // indicatorWeight: 0,
                            // unselectedLabelColor: Colors.black.withOpacity(0.6),
                            labelStyle: const TextStyle(
                                fontFamily: 'inter', fontWeight: FontWeight.w500),
                            isScrollable: true,
                            // indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Colors.transparent,
                            // indicator: RectangularIndicator(
                            //   bottomLeftRadius: 15,
                            //   bottomRightRadius: 15,
                            //   topLeftRadius: 15,
                            //   topRightRadius: 15,
                            //   paintingStyle: PaintingStyle.stroke,
                            //   strokeWidth: 0,
                            //   color: Colors.white
                            // ),
                            tabs:  [
                              Tab(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 5),
                                  child: Center(child:
                                      Column(
                                        children:const [
                                          Text("Visa"),
                                          SizedBox(height: 5,),
                                          Icon(Icons.credit_card),
                                        ],
                                      ),


                                  ),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 5),
                                  child: Center(child:
                                      Column(
                                        children:const [
                                          Text("Documents"),
                                          SizedBox(height: 5,),
                                          Icon(Icons.file_copy_outlined),
                                        ],
                                      ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 5),
                                  child: Center(child:
                                  Column(
                                    children:const [
                                      Text("FAQs"),
                                      SizedBox(height: 5,),
                                      Icon(Icons.format_quote),
                                    ],
                                  ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10,right: 5),
                                  child: Center(child:
                                  Column(
                                    children:const [
                                      Text("Terms"),
                                      SizedBox(height: 5,),
                                      Icon(Icons.menu_open_outlined),
                                    ],
                                  ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              Expanded(
                flex: 10,
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: <Widget>[
                    IndexedStack(
                      index: controller.tabController.index,
                      children: [

                        visaList(),

                        const Text("Documents",style:TextStyle(color: Colors.black)),

                        // const Text("Process"),

                        const Text("FAQs",style:TextStyle(color: Colors.black)),

                        const Text("Terms & conditions"),

                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context)=> ApplyVisa()));
                    },
                    child: Text("Apply Online",
                    style: TextStyle(fontSize: 16),),
                    style:ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff1529e8),
                    minimumSize: Size(MediaQuery.of(context).size.width*0.9, 40),
                    )
                  ),
                ),
              )
            ],
          ),
      );
  }

}
