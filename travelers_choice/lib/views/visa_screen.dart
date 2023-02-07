
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../theme/app_theme.dart';
import '../controllers/visa_controller.dart';

// class VisaScreen extends StatefulWidget {
//
//   const VisaScreen({Key? key,}) : super(key: key);
//
//   @override
//   State<VisaScreen> createState() => _VisaScreenState();
// }
//
// class _VisaScreenState extends State<VisaScreen>
//     with TickerProviderStateMixin {
//   // late ThemeData theme;
//   // late OutlineInputBorder outlineInputBorder;
//   late VisaController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = FxControllerStore.put(VisaController(this,));
//
//     // theme = AppTheme.shoppingTheme;
//
//     // outlineInputBorder = const OutlineInputBorder(
//     //     borderSide: BorderSide(
//     //         color: Color(0xff1529e8),
//     //         // color: Colors.lightBlueAccent,
//     //         width: 0));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FxBuilder<VisaController>(
//         controller: controller,
//         builder: (controller) {
//           return _visaWidget();
//         });
//   }
//
//   Widget _visaWidget() {
//       return Scaffold(
//           backgroundColor: const Color(0xfff5f5f5),
//           body: ListView(
//             padding: EdgeInsets.zero,
//             physics: const ClampingScrollPhysics(),
//             children: <Widget>[
//               Stack(
//                 children: <Widget>[
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 2.5,
//                     child: Container(
//                                 child: Image(
//                                   image: AssetImage(
//                                       'assets/images/all/all-1.jpg'),
//                                   height:
//                                   MediaQuery.of(context).size.height / 2.5,
//                                   width: MediaQuery.of(context).size.width,
//                                   fit: BoxFit.fill,
//                                 ),
//                               )
//                   ),
//
//                   Padding(
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       // mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 40,),
//                         FxText.bodyLarge(
//                           'Dubai visa',
//                           style: const TextStyle(
//                             fontSize: 36,
//                             fontWeight: FontWeight.w800,
//                             color: Colors.black,
//                           ),
//                         ),
//                         SizedBox(height: 20,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             FxText.bodyMedium(
//                               'Processing Time',
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             FxText.bodyMedium(
//                               'Starting from',
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                             // Text("Processing Time"),
//                             // Text("Starting from"),
//
//                           ],
//                         ),
//                         SizedBox(height: 20,),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             FxText.bodyMedium(
//                               'Up to 48 hours',
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             FxText.bodyMedium(
//                               'AED 310.00',
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black,
//                               ),
//                             ),
//
//
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//
//                   Positioned(
//                     top: 24,
//                     child: IconButton(
//                       onPressed: () => Navigator.of(context).pop(),
//                       icon: const Icon(
//                         MdiIcons.chevronLeft,
//                         color: Colors.black,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(30),
//                         topLeft: Radius.circular(30)),
//                     color: Color(0xfff5f5f5)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       height: 60,
//                       width: MediaQuery.of(context).size.width,
//                       color: Colors.transparent,
//                       child: TabBar(
//                         controller: controller.tabController,
//                         onTap: (index) {
//                           setState(() {
//                             controller.tabController.index = index;
//                           });
//                         },
//                         labelColor: Colors.black,
//                         unselectedLabelColor: Colors.black.withOpacity(0.6),
//                         labelStyle: const TextStyle(
//                             fontFamily: 'inter', fontWeight: FontWeight.w500),
//                         indicatorColor: Colors.black,
//                         isScrollable: true,
//                         tabs: const [
//                           Tab(
//                             text: 'Visas',
//                           ),
//                           Tab(
//                             text: 'Documents',
//                           ),
//                           Tab(
//                             text: 'Process',
//                           ),
//                           // Tab(
//                           //   text: 'FAQs',
//                           // ),
//                           // Tab(
//                           //   text: 'Terms & conditions',
//                           // ),
//                         ],
//                       ),
//                     ),
//
//                     IndexedStack(
//                       index: controller.tabController.index,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             FxText.bodyLarge(
//                               'Types of Dubai visa',
//                               style: const TextStyle(
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             Container(
//                               height: 250,
//                               child: Card(
//                                 color: Colors.white,
//                                 child: Container(
//                                   padding: EdgeInsets.all(10),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                      SizedBox(height: 10,),
//                                       FxText.bodyMedium("30 Days Single Entry Tourist Visa",
//                                       style: TextStyle(
//                                           fontSize: 20,
//                                         fontWeight: FontWeight.normal,
//                                         color: Colors.grey
//                                       ),
//                                       ),
//                                       SizedBox(height: 10,),
//                                       FxText.bodyMedium("AED 320",
//                                         style: TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.normal,
//                                             color: Colors.blue,
//                                           decoration: TextDecoration.underline
//                                         ),
//                                       ),
//                                       SizedBox(height: 10,),
//                                       Divider(height: 2,color: Colors.black,),
//                                       SizedBox(height: 10,),
//                                       FxText.bodyMedium("30 days UAE Tourist Visa Medical Insurance(COVID)",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.normal,
//                                             color: Colors.grey,
//                                         ),
//                                       ),
//                                       SizedBox(height: 10,),
//                                       Divider(height: 2,color: Colors.black,),
//                                       SizedBox(height: 10,),
//                                       FxText.bodySmall("Child Age Limit: 18",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.normal,
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                       ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )
//
//
//                           ],
//                         ),
//
//
//
//
//                         Text("Documents"),
//                         Text("Process"),
//                         // ListView.builder(
//                         //   shrinkWrap: true,
//                         //   padding: EdgeInsets.zero,
//                         //   itemCount: 1,
//                         //   // itemCount: controller.product.description.length,
//                         //   physics: const NeverScrollableScrollPhysics(),
//                         //   itemBuilder: (context, index) {
//                         //     return const Text('Description');
//                         //     // return StepTile(
//                         //     //   // data: widget.data.tutorial[index],
//                         //     //   data: widget.product,
//                         //     // );
//                         //   },
//                         // ),
//
//                         // ListView.builder(
//                         //   shrinkWrap: true,
//                         //   padding: EdgeInsets.zero,
//                         //   itemCount: 1,
//                         //   // itemCount: controller.product.description.length,
//                         //   physics: const NeverScrollableScrollPhysics(),
//                         //   itemBuilder: (context, index) {
//                         //     return Text("Body");
//                         //     // return StepTile(
//                         //     //   // data: widget.data.tutorial[index],
//                         //     //   data: widget.product,
//                         //     // );
//                         //   },
//                         // ),
//                         // ListView.builder(
//                         //   shrinkWrap: true,
//                         //   padding: EdgeInsets.zero,
//                         //   itemCount: 1,
//                         //   physics: const NeverScrollableScrollPhysics(),
//                         //   itemBuilder: (context, index) {
//                         //     return Text("controllerString()");
//                         //     // return Html(
//                         //     //   data: ${controller
//                         //     //     .detailattraction.first.highlights
//                         //     //     .toString()};,
//                         //     //   tagsList: Html.tags..addAll(["bird", "flutter"]),
//                         //     // );
//                         //     // return StepTile(
//                         //     //   // data: widget.data.tutorial[index],
//                         //     //   data: widget.product,
//                         //     // );
//                         //   },
//                         // ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ));
//   }
// }

