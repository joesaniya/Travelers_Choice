
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../theme/app_theme.dart';
import '../controllers/visa_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VisaScreen extends StatefulWidget {

  const VisaScreen({Key? key,}) : super(key: key);

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen>
    with TickerProviderStateMixin {
  // late ThemeData theme;
  // late OutlineInputBorder outlineInputBorder;
  late VisaController controller;

  @override
  void initState() {
    super.initState();
    controller = FxControllerStore.put(VisaController(this,));
 
    // theme = AppTheme.shoppingTheme;

    // outlineInputBorder = const OutlineInputBorder(
    //     borderSide: BorderSide(
    //         color: Color(0xff1529e8),
    //         // color: Colors.lightBlueAccent,
    //         width: 0));
  }


  Widget visaList(){
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
        children: [
          FxText.bodyLarge(
            'Types of Dubai visa',
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20,),
          ListView.separated(
            // scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext, int index){
                return  Card(
                  shadowColor: Colors.black,
                  elevation: 7,
                  clipBehavior: Clip.antiAlias,
                  // color: Color(0xffdde1eb),
                  shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.blue,Colors.white,],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        FxText.bodyMedium("30 Days Single Entry Tourist Visa",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 10,),
                        FxText.bodyMedium("AED 320",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Color(0xff072461),
                              decoration: TextDecoration.underline
                          ),
                        ),
                        SizedBox(height: 10,),
                        Divider(height: 0.5,color: Colors.white,),
                        SizedBox(height: 10,),
                        FxText.bodyMedium("30 days UAE Tourist Visa Medical Insurance(COVID)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Divider(height: 0.5,color: Colors.white,),
                        SizedBox(height: 10,),
                        FxText.bodySmall("Child Age Limit: 18",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext, int index){
            return SizedBox(height: 20,);
          }, itemCount: 4),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Documents required for Dubai visa",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\u2022',style: TextStyle(fontSize: 20),),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text("Scanned color copy of first and last page of your passport",style: TextStyle(fontSize: 16,),)
                    )
                  ],
                ) ,

                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\u2022',style: TextStyle(fontSize: 20),),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text("Scanned color copy of first and last page of your passport",style: TextStyle(fontSize: 16,),)
                    )
                  ],
                ),

                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\u2022',style: TextStyle(fontSize: 20),),
                    SizedBox(width: 5),
                    Expanded(
                        child: Text("Scanned color copy of first and last page of your passport",style: TextStyle(fontSize: 16,),)
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height:20),

          ListTile(
            tileColor: Colors.blue,
            leading: Icon(Icons.file_copy_outlined,color: Colors.white,size: 30,),
            title: Text("View Sample Visa Copy",style:TextStyle(color: Colors.white,)),
            subtitle: Text("For better understanding click here!!",style:TextStyle(color: Colors.white,)),
          ),
          SizedBox(height: 20,),

        ],

    );
    //   Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     FxText.bodyLarge(
    //       'Types of Dubai visa',
    //       style: const TextStyle(
    //         fontSize: 26,
    //         fontWeight: FontWeight.w500,
    //         color: Colors.black,
    //       ),
    //     ),
    //     SizedBox(height: 20,),
    //     Card(
    //       shadowColor: Colors.black,
    //       elevation: 7,
    //       clipBehavior: Clip.antiAlias,
    //       // color: Color(0xffdde1eb),
    //       shape:RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(15)
    //       ),
    //       child: Container(
    //         padding: EdgeInsets.all(10),
    //         decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //                 colors: [Colors.blue,Colors.white,],
    //               begin: Alignment.topLeft,
    //               end: Alignment.bottomRight
    //             )
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(height: 20,),
    //             FxText.bodyMedium("30 Days Single Entry Tourist Visa",
    //               style: TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.normal,
    //                   color: Colors.black
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             FxText.bodyMedium("AED 320",
    //               style: TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.normal,
    //                   color: Color(0xff072461),
    //                   decoration: TextDecoration.underline
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             Divider(height: 1,color: Colors.grey,),
    //             SizedBox(height: 10,),
    //             FxText.bodyMedium("30 days UAE Tourist Visa Medical Insurance(COVID)",
    //               style: TextStyle(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.normal,
    //                 color: Colors.black,
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             Divider(height: 1,color: Colors.grey,),
    //             SizedBox(height: 10,),
    //             FxText.bodySmall("Child Age Limit: 18",
    //               style: TextStyle(
    //                 fontWeight: FontWeight.normal,
    //                 fontSize: 14,
    //                 color: Colors.black,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     SizedBox(height: 20,),
    //     Card(
    //       shadowColor: Colors.black,
    //       elevation: 7,
    //       clipBehavior: Clip.antiAlias,
    //       // color: Color(0xffdde1eb),
    //       shape:RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(15)
    //       ),
    //       child: Container(
    //         padding: EdgeInsets.all(10),
    //         decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //                 colors: [Colors.blue,Colors.white,],
    //                 begin: Alignment.topLeft,
    //                 end: Alignment.bottomRight
    //             )
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(height: 20,),
    //             FxText.bodyMedium("90 Days Single Entry Tourist Visa",
    //               style: TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.normal,
    //                   color: Colors.black
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             FxText.bodyMedium("AED 740",
    //               style: TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.normal,
    //                   color: Color(0xff072461),
    //                   decoration: TextDecoration.underline
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             Divider(height: 1,color: Colors.grey,),
    //             SizedBox(height: 10,),
    //             FxText.bodyMedium("90 days UAE Tourist Visa Medical Insurance(COVID)",
    //               style: TextStyle(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.normal,
    //                 color: Colors.black,
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             Divider(height: 1,color: Colors.grey,),
    //             SizedBox(height: 10,),
    //             FxText.bodySmall("Child Age Limit: 18",
    //               style: TextStyle(
    //                 fontWeight: FontWeight.normal,
    //                 fontSize: 14,
    //                 color: Colors.black,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     SizedBox(height: 20,),
    //     Card(
    //       shadowColor: Colors.black,
    //       elevation: 7,
    //       clipBehavior: Clip.antiAlias,
    //       // color: Color(0xffdde1eb),
    //       shape:RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(15)
    //       ),
    //       child: Container(
    //         padding: EdgeInsets.all(10),
    //         decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //                 colors: [Colors.blue,Colors.white,],
    //                 begin: Alignment.topLeft,
    //                 end: Alignment.bottomRight
    //             )
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(height: 20,),
    //             FxText.bodyMedium("14 Days Single Entry Tourist Visa",
    //               style: TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.normal,
    //                   color: Colors.black
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             FxText.bodyMedium("AED 310",
    //               style: TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.normal,
    //                   color: Color(0xff072461),
    //                   decoration: TextDecoration.underline
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             Divider(height: 1,color: Colors.grey,),
    //             SizedBox(height: 10,),
    //             FxText.bodyMedium("14 days UAE Tourist Visa Medical Insurance(COVID)",
    //               style: TextStyle(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.normal,
    //                 color: Colors.black,
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             Divider(height: 1,color: Colors.grey,),
    //             SizedBox(height: 10,),
    //             FxText.bodySmall("Child Age Limit: 18",
    //               style: TextStyle(
    //                 fontWeight: FontWeight.normal,
    //                 fontSize: 14,
    //                 color: Colors.black,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //     SizedBox(height: 20,),
    //     Card(
    //       shadowColor: Colors.black,
    //       elevation: 7,
    //       clipBehavior: Clip.antiAlias,
    //       // color: Color(0xffdde1eb),
    //       shape:RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(15)
    //       ),
    //       child: Container(
    //         padding: EdgeInsets.all(10),
    //         decoration: BoxDecoration(
    //             gradient: LinearGradient(
    //                 colors: [Colors.blue,Colors.white,],
    //                 begin: Alignment.topLeft,
    //                 end: Alignment.bottomRight
    //             )
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(height: 20,),
    //             FxText.bodyMedium("30 Days inside the country No Exit Requires",
    //               style: TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.normal,
    //                   color: Colors.black
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             FxText.bodyMedium("AED 970",
    //               style: TextStyle(
    //                   fontSize: 20,
    //                   fontWeight: FontWeight.normal,
    //                   color: Color(0xff072461),
    //                   decoration: TextDecoration.underline
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             Divider(height: 1,color: Colors.grey,),
    //             SizedBox(height: 10,),
    //             FxText.bodyMedium("30 days inside the country",
    //               style: TextStyle(
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.normal,
    //                 color: Colors.black,
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             Divider(height: 1,color: Colors.grey,),
    //             SizedBox(height: 10,),
    //             FxText.bodySmall("Child Age Limit: 18",
    //               style: TextStyle(
    //                 fontWeight: FontWeight.normal,
    //                 fontSize: 14,
    //                 color: Colors.black,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //
    //   ],
    // );
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
          backgroundColor:  Colors.white,
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xff04107d),
                        Color(0xff6a70a8)
                      ],
                    ),
                  ),
                  // color: Colors.blue,
                  height: MediaQuery.of(context).size.height/4.25,
                  child: Column(
                    children:[
                      Column(
                        children: [
                          SizedBox(height: 60,),
                          Row(
                            children: [
                              SizedBox(width: 5,),

                            Card(
                              shadowColor: Colors.white,
                                    elevation: 4,
                              clipBehavior: Clip.antiAlias,
                                    shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)
                                    ),
                              child: Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width*0.8,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
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

                              SizedBox(width: 5,),
                            InkWell(
                              onTap: (){},
                              child: Container(
                                        height: 60,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          // color: Colors.blue,
                                            border:  Border.all(color: Colors.white),
                                            borderRadius: BorderRadius.all(Radius.circular(15)),

                                        ),
                                        child: Center(
                                            child: Center(
                                                child: Icon(
                                                  Icons.filter_list,
                                                  size: 30,
                                                  color: Colors.white,
                                                )
                                            )
                                        ),
                                      ),
                            ),
                              SizedBox(width: 5,),
                          ],
                          ),
                          SizedBox(height: 20,),

                          TabBar(
                            controller: controller.tabController,
                            onTap: (index) {
                              setState(() {
                                controller.tabController.index = index;
                              });
                            },
                            labelColor: Colors.white,
                            // unselectedLabelColor: Colors.black.withOpacity(0.6),
                            labelStyle: const TextStyle(
                                fontFamily: 'inter', fontWeight: FontWeight.w500),
                            isScrollable: true,
                            indicator: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.blue, Colors.white10]),
                                borderRadius: BorderRadius.circular(30),
                                ),
                            tabs:  [
                              Tab(
                                child: Container(
                                  height: 60,
                                  width: 100,
                                  child: Center(child: Column(
                                    children: [
                                      Icon(Icons.credit_card),
                                      Text("Visas",style: TextStyle(fontSize: 16),),
                                    ],
                                  )),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  height: 60,
                                  width: 100,

                                  child: Center(child: Column(
                                    children: [
                                      Icon(Icons.file_copy_outlined),
                                      Text("Documents",style: TextStyle(fontSize: 16)),
                                    ],
                                  )),
                                ),
                              ),
                              Tab(
                                child: Container(
                                  height: 60,
                                  width: 100,
                                  child: Center(child: Column(
                                    children: [
                                      Icon(Icons.present_to_all),
                                      Text("Process",style: TextStyle(fontSize: 16)),
                                    ],
                                  )),
                                ),
                              ),

                            ],
                          ),



                        ],
                      ),

                    ]
                  ),
                ),
              ),

              Expanded(
                flex: 9,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  physics: const ClampingScrollPhysics(),
                  children: <Widget>[
                    // SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IndexedStack(
                          index: controller.tabController.index,
                          children: [
                            visaList(),

                            Text("Documents",style:TextStyle(color: Colors.black)),
                            Text("Process"),

                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
      );
  }

}
