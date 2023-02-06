// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutx/flutx.dart';
// import 'package:hotel_travel/models/TopAttraction.dart';
// import 'package:iconsax/iconsax.dart';

// import '../card_widgets/attraction_tile.dart';
// import '../controllers/home_controller.dart';
// import '../helperdata/helper.dart';
// import '../models/product.dart';

// class TopAttractionCard extends StatefulWidget {
//   const TopAttractionCard({Key? key}) : super(key: key);

//   @override
//   State<TopAttractionCard> createState() => _TopAttractionCardState();
// }

// class _TopAttractionCardState extends State<TopAttractionCard>
//     with TickerProviderStateMixin {
//   final List<TopAttraction> recentattraction =
//       ActivityHelper.newlyTopAttraction;
//   List<TopAttraction> searchResult = ActivityHelper.newlyTopAttraction;
//   List<TopAttraction>? foundCompany;
//   // late ThemeData theme;
//   late HomeController controller;
//   @override
//   void initState() {
//     log('top');
//     foundCompany = searchResult;
//     super.initState();
//     // theme = AppTheme.shoppingTheme;
//     log(foundCompany!.length.toString());
//     controller = FxControllerStore.put(HomeController(this));
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       // addCategories();
//     });
//   }

//   Widget _buildProductList() {
//     List<Widget> list = [];

//     for (Product product in controller.products!) {
//       list.add(FadeTransition(
//         opacity: controller.fadeAnimation,
//         child: InkWell(
//           onTap: () {
//             controller.goToSingleProduct(product);
//           },
//           child: Container(
//             margin: const EdgeInsets.all(5.0),
//             // width: 800,
//             // height: 155,
//             height: 250,
//             decoration: BoxDecoration(
//                 // color: Color(0xffe6e1e5),
//                 color: Colors.white,
//                 // color: Color(0xffe5fdfd),
//                 borderRadius: const BorderRadius.all(Radius.circular(10)),
//                 border: Border.all(color: Colors.grey.shade300, width: 1)
//                 // color: theme!.colorScheme.onPrimaryContainer,
//                 ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.all(8),
//                   height: 150,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       image: DecorationImage(
//                           image: AssetImage(product.image.toString()
//                               // 'assets/images/apps/shopping2/images/Ferraiworld.jpg',
//                               ),
//                           fit: BoxFit.fill)),
//                 ),
//                 Flexible(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             FxContainer(
//                               borderRadiusAll: 10,
//                               // padding: FxSpacing.xy(8, 4),
//                               padding: FxSpacing.xy(6, 2),
//                               // color: Color(0xff1529e8),
//                               color: Colors.blueGrey,
//                               child: FxText.bodySmall(
//                                 // 'Theme Park',
//                                 product.types.toString(),
//                                 fontWeight: 300,
//                                 color: Colors.white,
//                                 // color: theme.colorScheme.onPrimary,
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             FxContainer(
//                               borderRadiusAll: 10,
//                               // padding: FxSpacing.xy(8, 4),
//                               padding: FxSpacing.xy(6, 2),
//                               // color: Color(0xff1529e8),
//                               color: Colors.blueGrey,
//                               child: FxText.bodySmall(
//                                 'Ticket',
//                                 fontWeight: 300,
//                                 color: Colors.white,
//                                 // color: theme.colorScheme.onPrimary,
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 5,
//                             ),
//                             FxContainer(
//                               borderRadiusAll: 10,
//                               // padding: FxSpacing.xy(8, 4),
//                               padding: FxSpacing.xy(6, 2),
//                               // color: Color(0xff1529e8),
//                               color: Colors.blueGrey,
//                               child: FxText.bodySmall(
//                                 'Offer',
//                                 fontWeight: 300,
//                                 color: Colors.white,
//                                 // color: theme.colorScheme.onPrimary,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 const Icon(
//                                   // FeatherIcons.star,
//                                   Icons.star,
//                                   color: Colors.yellow,
//                                   size: 12,
//                                 ),
//                                 FxSpacing.width(4),
//                                 FxText.bodySmall(
//                                   // '4.5',
//                                   product.rating.toString(),
//                                   fontWeight: 600,
//                                   color: Colors.black,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 FxSpacing.height(20),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: FxText.bodyLarge(
//                     // 'Ferrari world',
//                     product.name.toString(),
//                     fontWeight: 800,
//                   ),
//                 ),
//                 FxSpacing.height(10),
//                 Padding(
//                   // padding: EdgeInsets.symmetric(horizontal: 0),
//                   padding: const EdgeInsets.only(right: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           FxContainer(
//                             borderRadiusAll: 8,
//                             padding: FxSpacing.xy(8, 4),
//                             // color: theme.colorScheme.primary,
//                             // color: Colors.yellow.shade400,
//                             color: Colors.white,
//                             child: Row(
//                               children: [
//                                 const Icon(
//                                   Iconsax.location,
//                                   color: Colors.black,
//                                   // color: theme.colorScheme.onPrimary,
//                                   size: 12,
//                                 ),
//                                 FxSpacing.width(4),
//                                 FxText.labelLarge(
//                                   // '\$' + product.price.toString(),
//                                   product.location.toString(),
//                                   // product.price.toString() + " " + "AED",
//                                   // "\$" + product.price.toString() + "/hour",
//                                   // fontWeight: 700,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           // FxContainer.bordered(
//                           //   paddingAll: 4,
//                           //   borderRadiusAll: 4,
//                           //   child: Icon(
//                           //     FeatherIcons.plus,
//                           //     size: 14,
//                           //     color: theme.colorScheme.onBackground,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                       FxText(
//                         product.price.toString(),
//                         color: const Color(0xff1529e8),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ));
//     }

//     return ListView(
//       // scrollDirection: Axis.horizontal,
//       // physics: const NeverScrollableScrollPhysics(),
//       children: list,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     // return SizedBox(
//     //   height: 280,
//     //   child: ListView.builder(
//     //     itemExtent: 250,
//     //     scrollDirection: Axis.horizontal,
//     //     itemBuilder: (context, index) {
//     //       // return AttractionTile();
//     //       return AttractionTile(data: recentattraction[index]);
//     //     },
//     //     // itemBuilder: (context, index) => Container(
//     //     //       margin: EdgeInsets.all(5.0),
//     //     //       // width: 800,
//     //     //       height: 150,
//     //     //       decoration: BoxDecoration(
//     //     //         color: Color(0xffe6e1e5),
//     //     //         // color: Color(0xffe5fdfd),
//     //     //         borderRadius: BorderRadius.all(Radius.circular(10)),
//     //     //         // color: theme!.colorScheme.onPrimaryContainer,
//     //     //       ),
//     //     //       child: Column(
//     //     //         children: [
//     //     //           Container(
//     //     //             height: 200,

//     //     //             decoration:BoxDecoration(image: DecorationImage(image: AssetImage(recentattraction[index].))) ,
//     //     //           )
//     //     //         ],
//     //     //       ),
//     //     //     ),
//     //     itemCount: foundCompany!.length,
//     //     // itemCount: recentattraction.length
//     //   ),
//     // );
//     return FxBuilder<HomeController>(
//         controller: controller,
//         builder: (controller) {
//           return SizedBox(
//             height: 280,
//             child: ListView.builder(
//               itemExtent: 250,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 // return AttractionTile();

//                 return AttractionTile(data: recentattraction[index]);
//               },
//               // itemBuilder: (context, index) => Container(
//               //       margin: EdgeInsets.all(5.0),
//               //       // width: 800,
//               //       height: 150,
//               //       decoration: BoxDecoration(
//               //         color: Color(0xffe6e1e5),
//               //         // color: Color(0xffe5fdfd),
//               //         borderRadius: BorderRadius.all(Radius.circular(10)),
//               //         // color: theme!.colorScheme.onPrimaryContainer,
//               //       ),
//               //       child: Column(
//               //         children: [
//               //           Container(
//               //             height: 200,

//               //             decoration:BoxDecoration(image: DecorationImage(image: AssetImage(recentattraction[index].))) ,
//               //           )
//               //         ],
//               //       ),
//               //     ),
//               itemCount: foundCompany!.length,
//               // itemCount: recentattraction.length
//             ),
//           );
//           // return _buildProductList();
//         });
//   }
// }
