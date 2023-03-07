import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import '../controllers/new_cart_controller.dart';
import '../loading_effect.dart';
import '../models/atteraction_model.dart';
import '../models/cart.dart';
import '../theme/app_theme.dart';

//
// class AttractionCartPage extends StatefulWidget {
//   dynamic? length;
//
//   List<Activity> selectedtourOption;
//
//   String textdate;
//   String? Transfer;
//   double? totalAmount;
//
//   @override
//   Key? key;
//
//   AttractionCartPage(
//       this.length,
//       this.selectedtourOption,
//       // this.selectedtours,
//       // this.name,
//       // this.adultCount,
//       // this.childCount,
//       // this.infantCount,
//       // this.grandTotal,
//       // // this.finalAmount,
//       this.textdate,
//       this.Transfer,
//       // this.onButtonTap,
//       // this.TotalCalculation,
//       this.totalAmount,
//       {super.key});
//
//   @override
//   State<AttractionCartPage> createState() => _AttractionCartPageState();
// }
//
// class _AttractionCartPageState extends State<AttractionCartPage>
//     with TickerProviderStateMixin {
//   late ThemeData theme;
//   late CustomTheme customTheme;
//
//   late CheckOutController controller;
//   late ActivityController controller1;
//   List? selectedExcursions;
//   @override
//   void initState() {
//     super.initState();
//     customTheme = AppTheme.customTheme;
//     selectedExcursions = widget.selectedtourOption;
//     log('Selected Tour length:${widget.selectedtourOption.first.sId}');
//     log('Selected Total Amount:${widget.totalAmount}');
//
//     fetchlog();
//     log('Selected Final Amount:${widget.selectedtourOption.first.grandTotal}');
//
//     // fetchData();
//     theme = AppTheme.shoppingTheme;
//     controller1 = FxControllerStore.put(ActivityController(this));
//     controller = FxControllerStore.put(CheckOutController(this));
//   }
//
//   fetchlog() async {
//     log('fetch log calling');
//     log('Excursions:$selectedExcursions');
//     // selectedExcursions!.map((e) {
//     //   // e.sId;
//     //   // e.createdAt;
//     //   // e.adultCount;
//     //   // e.infantCount;
//     //   // e.childCount;
//     //   // e.activityType;
//
//     //   log('Sid:${e.sId.toString()}');
//     // });
//     for (var element in selectedExcursions!) {
//       log('Sid:${element.sId.toString()}');
//     }
//   }
//
//   Widget getSinglePayment(
//       {int? index, required String image, required String method}) {
//     log('method:$method');
//     log('index:$index');
//     bool isSelected = index == controller.selectedPayment;
//
//     return FxContainer(
//       onTap: () {
//         setState(() {
//           controller.selectedPayment = index;
//         });
//       },
//       margin: FxSpacing.bottom(16),
//       padding: FxSpacing.all(16),
//       bordered: !isSelected,
//       border: Border.all(
//           // color: customTheme.border
//           color: Colors.indigo),
//       color: isSelected ? Colors.white : Colors.transparent,
//       // color: isSelected ? customTheme.card : theme.scaffoldBackgroundColor,
//       borderRadiusAll: 8,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             width: 48,
//             height: 36,
//             child: Image.asset(
//               image,
//             ),
//           ),
//           FxSpacing.width(16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 FxText.bodyMedium(method, fontWeight: 600),
//                 // FxSpacing.height(8),
//                 // FxText.labelSmall(
//                 //     "8765  \u2022\u2022\u2022\u2022  \u2022\u2022\u2022\u2022  7983",
//                 //     muted: true,
//                 //     letterSpacing: 0)
//               ],
//             ),
//           ),
//           // isSelected ? Space.width(16) : Space.width(20),
//           isSelected
//               ? Container(
//                   padding: FxSpacing.all(8),
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: const Color(0xff1529e8).withAlpha(40)),
//                   child: const Icon(
//                     FeatherIcons.check,
//                     color: Color(0xff1529e8),
//                     size: 14,
//                   ),
//                 )
//               : Container(
//                   height: 26,
//                   width: 26,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: const Color(0xff1529e8))),
//                 ),
//         ],
//       ),
//     );
//   }
//
//   Widget _billingWidget() {
//     List<Widget> list = [];
//     log('message');
//     log(widget.length.toString());
//     return SizedBox(
//       child: ListView.separated(
//         itemCount: widget.length,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           return FadeTransition(
//             opacity: controller.fadeAnimation,
//             child: FxContainer(
//               borderRadiusAll: 4,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   FxText.bodyMedium(
//                     'Billing Information',
//                     muted: true,
//                     fontWeight: 700,
//                   ),
//                   FxSpacing.height(20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       FxText.bodyMedium(
//                         'Option',
//                         fontWeight: 600,
//                       ),
//                       FxSpacing.width(20),
//                       // Expanded(child: Container()),
//                       Expanded(
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: FxText.bodyMedium(
//                             // '\$' + controller.order.precise,
//                             widget.selectedtourOption[index].name.toString(),
//                             fontWeight: 700,
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   FxSpacing.height(4),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       FxText.bodyMedium(
//                         'Transfer',
//                         fontWeight: 600,
//                       ),
//                       // widget.selectedtourOption[index].isSharing == null
//                       //     ? FxText.bodyMedium(
//                       //         // '\$' + controller.order.precise,
//                       //         'without',
//                       //         fontWeight: 700,
//                       //       )
//                       //     : FxText.bodyMedium(
//                       //         widget.Transfer.toString(),
//                       //         fontWeight: 700,
//                       //       ),
//                       widget.Transfer == null
//                           ? FxText.bodyMedium(
//                               'without',
//                               fontWeight: 700,
//                             )
//                           : FxText.bodyMedium(
//                               widget.Transfer.toString(),
//                               fontWeight: 700,
//                             ),
//                     ],
//                   ),
//                   FxSpacing.height(4),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       FxText.bodyMedium(
//                         'Date',
//                         fontWeight: 600,
//                       ),
//                       FxText.bodyMedium(
//                         widget.selectedtourOption[index].selectedDate
//                             .toString(),
//                         fontWeight: 700,
//                       ),
//                       // widget.textdate.isEmpty
//                       //     ? FxText.bodyMedium(
//                       //         'select Date',
//                       //         fontWeight: 700,
//                       //       )
//                       //     : FxText.bodyMedium(
//                       //         // widget.textdate.toString(),
//                       //         widget.selectedtourOption[index].selectedDate
//                       //             .toString(),
//                       //         fontWeight: 700,
//                       //       ),
//                     ],
//                   ),
//                   FxSpacing.height(4),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       FxText.bodyMedium(
//                         'Pax',
//                         fontWeight: 600,
//                       ),
//                       Expanded(child: Container()),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           FxContainer(
//                             padding: FxSpacing.fromLTRB(8, 6, 8, 6),
//                             color: const Color(0xff1529e8).withAlpha(40),
//                             child: Row(
//                               children: [
//                                 FxText.bodyMedium(
//                                     widget.selectedtourOption[index].adultCount
//                                         .toString(),
//                                     color: const Color(0xff1529e8),
//                                     // color: customTheme.groceryPrimary,
//                                     fontWeight: 500,
//                                     letterSpacing: -0.2),
//                                 FxSpacing.width(4),
//                                 FxText.bodyMedium('Adult',
//                                     color: const Color(0xff1529e8),
//                                     // color: customTheme.groceryPrimary,
//                                     fontWeight: 500,
//                                     letterSpacing: -0.2),
//                               ],
//                             ),
//                           ),
//                           FxSpacing.width(10),
//                           FxContainer(
//                             padding: FxSpacing.fromLTRB(8, 6, 8, 6),
//                             color: const Color(0xff1529e8).withAlpha(40),
//                             child: Row(
//                               children: [
//                                 FxText.bodyMedium(
//                                     widget.selectedtourOption[index].childCount
//                                         .toString(),
//                                     color: const Color(0xff1529e8),
//                                     // color: customTheme.groceryPrimary,
//                                     fontWeight: 500,
//                                     letterSpacing: -0.2),
//                                 FxSpacing.width(4),
//                                 FxText.bodyMedium('child',
//                                     color: const Color(0xff1529e8),
//                                     // color: customTheme.groceryPrimary,
//                                     fontWeight: 500,
//                                     letterSpacing: -0.2),
//                               ],
//                             ),
//                           ),
//                           FxSpacing.width(10),
//                           FxContainer(
//                             padding: FxSpacing.fromLTRB(8, 6, 8, 6),
//                             color: const Color(0xff1529e8).withAlpha(40),
//                             child: Row(
//                               children: [
//                                 FxText.bodyMedium(
//                                     widget.selectedtourOption[index].infantCount
//                                         .toString(),
//                                     color: const Color(0xff1529e8),
//                                     // color: customTheme.groceryPrimary,
//                                     fontWeight: 500,
//                                     letterSpacing: -0.2),
//                                 FxSpacing.width(4),
//                                 FxText.bodyMedium('Infant',
//                                     color: const Color(0xff1529e8),
//                                     // color: customTheme.groceryPrimary,
//                                     fontWeight: 500,
//                                     letterSpacing: -0.2),
//                               ],
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   FxSpacing.height(4),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       FxText.bodyMedium(
//                         'Amount',
//                         fontWeight: 600,
//                       ),
//                       FxText.bodyMedium(
//                         "${widget.selectedtourOption[index].grandTotal}AED",
//                         fontWeight: 700,
//                       ),
//                     ],
//                   ),
//                   FxSpacing.height(12),
//                   Row(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: Container(),
//                       ),
//                       Expanded(
//                         child: FxDashedDivider(
//                           dashSpace: 4,
//                           dashWidth: 8,
//                           color: theme.colorScheme.onBackground.withAlpha(180),
//                           height: 1.2,
//                         ),
//                       )
//                     ],
//                   ),
//                   FxSpacing.height(12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       FxText.bodyMedium(
//                         'Grand Total',
//                         fontWeight: 700,
//                         color: const Color(0xff1529e8),
//                       ),
//                       FxText.bodyMedium(
//                         // '\$' + controller.total.precise,
//                         "${widget.selectedtourOption[index].grandTotal}AED",
//                         fontWeight: 800,
//                         color: const Color(0xff1529e8),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//         separatorBuilder: (context, index) {
//           return FxSpacing.height(10);
//         },
//       ),
//     );
//
//     // for (var dataselect in controller1.selectedtour.length) {
//     //   list.add(FadeTransition);
//     // }
//     // return Column(
//     //   children: list,
//     // );
//   }
//
//   Widget paymentInfo() {
//     return Container(
//       padding: FxSpacing.x(20),
//       child: ListView(
//         shrinkWrap: true,
//         physics: const AlwaysScrollableScrollPhysics(),
//         // crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           FxSpacing.height(20),
//
//           //bill
//           _billingWidget(),
//           FxSpacing.height(20),
//           FxText.bodyLarge(
//             'Select Payment Method',
//             fontWeight: 800,
//           ),
//           FxSpacing.height(12),
//           FxDashedDivider(
//             dashSpace: 4,
//             dashWidth: 8,
//             color: theme.colorScheme.onBackground.withAlpha(180),
//             height: 1.2,
//           ),
//           FxSpacing.height(20),
//
//           getSinglePayment(
//               index: 1,
//               method: "CCavenue",
//               image: 'assets/images/apps/shopping2/icons/cc-avenue.png'),
//           // getSinglePayment(
//           //     index: 2,
//           //     method: "RazorPay",
//           //     image: 'assets/images/apps/shopping2/icons/razor_logo.png'),
//
//           FxSpacing.height(20),
//           // MaterialButton(
//           //   onPressed: () {
//           //     controller.initPlatformState();
//           //     // controller.nextPage(
//           //     //     selectedExcursions, context, widget.totalAmount);
//           //   },
//           //   // child: const Text('Button')
//           //   child: controller.selectedPayment == 1
//           //       ? const Text('ccavenue')
//           //       : controller.selectedPayment == 2
//           //           ? const Text('razor')
//           //           : const Text('select'),
//           // ),
//           FxButton.block(
//             onPressed: () {
//               log('book');
//               controller1.goToCheckout1();
//               // controller.Cartnext(
//               //     selectedExcursions, context, widget.totalAmount);
//               // controller.selectedPayment == 1
//               //     ? controller.nextPage
//               //         // controller.Cartnext
//               //         (selectedExcursions, context, widget.totalAmount)
//               //     : controller.selectedPayment == 2
//               //         ? controller.nextPage
//               //             // controller.Cartnext
//               //             (selectedExcursions, context, widget.totalAmount)
//               //         : ScaffoldMessenger.of(context).showSnackBar(
//               //             const SnackBar(
//               //                 content: Text('Select payment method')));
//             },
//             borderRadiusAll: 4,
//             elevation: 0,
//             splashColor: const Color(0xff1529e8).withAlpha(40),
//             backgroundColor: const Color(0xff1529e8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 FxText.bodyMedium(
//                   'Book Now',
//                   fontWeight: 600,
//                   color: theme.colorScheme.onPrimary,
//                 ),
//                 FxText.bodyMedium(
//                   ' ${widget.totalAmount} AED',
//                   // '${widget.selectedtourOption.first.GrandTotalAmount}',
//                   // '${widget.totalAmount} AED',
//                   // widget.finalAmount.toString(),
//                   // widget.TotalCalculation.toString(),
//                   // controller1.grandSelectedTourAmount().toString(),
//                   fontWeight: 700,
//                   color: theme.colorScheme.onPrimary,
//                 ),
//               ],
//             ),
//           ),
//           FxSpacing.height(80),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FxBuilder<CheckOutController>(
//         controller: controller,
//         builder: (controller) {
//           return Scaffold(
//             backgroundColor: const Color(0xfff5f5f5),
//             // backgroundColor: theme.scaffoldBackgroundColor,
//             appBar: AppBar(
//               backgroundColor: const Color(0xfff5f5f5),
//               elevation: 0,
//               centerTitle: true,
//               title: FxText.titleMedium(
//                 'Cart',
//                 fontWeight: 600,
//               ),
//               leading: InkWell(
//                 onTap: () {
//                   controller.goBack();
//                 },
//                 child: const Icon(
//                   FeatherIcons.chevronLeft,
//                   size: 20,
//                 ),
//               ),
//             ),
//             body: paymentInfo(),
//           );
//         });
//   }
// }


// class CartScreen extends StatefulWidget {
//   const CartScreen({Key? key}) : super(key: key);
//
//   @override
//   _CartScreenState createState() => _CartScreenState();
// }
//
// class _CartScreenState extends State<CartScreen>
//     with TickerProviderStateMixin {
//   late ThemeData theme;
//
//   late CartController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     theme = AppTheme.shoppingTheme;
//
//     controller = FxControllerStore.put(CartController(this));
//   }
//
//   Widget _buildCartList() {
//     List<Widget> list = [];
//
//     for (Cart cart in controller.carts!) {
//       bool increaseAble = controller.increaseAble(cart);
//       bool decreaseAble = controller.decreaseAble(cart);
//       list.add(FadeTransition(
//         opacity: controller.fadeAnimation,
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(child: Container()),
//                 InkWell(
//                   onTap: () {
//                     // Navigator.pop(context);
//                   },
//                   child: FxContainer.bordered(
//                     paddingAll: 4,
//                     color: theme.colorScheme.onPrimary,
//                     borderColor: Colors.black,
//                     child: Icon(
//                       FeatherIcons.minus,
//                       color: Colors.red.withAlpha(200),
//                       size: 12,
//                     ),
//                   ),
//                 ),
//                 // FxContainer(
//                 //   onTap: () {
//                 //     // controller.decrement(cart);
//                 //   },
//                 //   paddingAll: 4,
//                 //   borderRadiusAll: 2,
//                 //   alignment: Alignment.centerRight,
//                 //   // bordered: decreaseAble,
//
//                 //   border: Border.all(color: Colors.grey.withAlpha(120)),
//                 //   color: Colors.grey,
//                 //   child: const Icon(
//                 //     FeatherIcons.minus,
//                 //     size: 12,
//                 //     color: Colors.indigo,
//                 //   ),
//                 // ),
//               ],
//             ),
//             FxSpacing.height(10),
//             FxContainer(
//               margin: FxSpacing.bottom(20),
//               borderRadiusAll: 4,
//               paddingAll: 12,
//               child: Column(
//                 children: [
//                   // InkWell(
//                   //   onTap: () {
//                   //     // Navigator.pop(context);
//                   //   },
//                   //   child: FxContainer.bordered(
//                   //     paddingAll: 4,
//                   //     child: Icon(
//                   //       Icons.chevron_left_outlined,
//                   //       color: theme.colorScheme.onBackground.withAlpha(200),
//                   //     ),
//                   //   ),
//                   // ),
//                   // Row(
//                   //   children: [
//                   //     Expanded(child: Container()),
//                   //     InkWell(
//                   //       onTap: () {
//                   //         // Navigator.pop(context);
//                   //       },
//                   //       child: FxContainer.bordered(
//                   //         paddingAll: 4,
//                   //         color: theme.colorScheme.onPrimary,
//                   //         borderColor: Colors.black,
//                   //         child: Icon(
//                   //           FeatherIcons.minus,
//                   //           color: Colors.red.withAlpha(200),
//                   //           size: 12,
//                   //         ),
//                   //       ),
//                   //     ),
//                   //     // FxContainer(
//                   //     //   onTap: () {
//                   //     //     // controller.decrement(cart);
//                   //     //   },
//                   //     //   paddingAll: 4,
//                   //     //   borderRadiusAll: 2,
//                   //     //   alignment: Alignment.centerRight,
//                   //     //   // bordered: decreaseAble,
//
//                   //     //   border: Border.all(color: Colors.grey.withAlpha(120)),
//                   //     //   color: Colors.grey,
//                   //     //   child: const Icon(
//                   //     //     FeatherIcons.minus,
//                   //     //     size: 12,
//                   //     //     color: Colors.indigo,
//                   //     //   ),
//                   //     // ),
//                   //   ],
//                   // ),
//                   // FxSpacing.height(10),
//                   Row(
//                     children: [
//                       FxContainer(
//                         paddingAll: 0,
//                         borderRadiusAll: 4,
//                         height: 80,
//                         width: 80,
//                         clipBehavior: Clip.antiAliasWithSaveLayer,
//                         child: Image(
//                           fit: BoxFit.cover,
//                           image: AssetImage(cart.product.image),
//                         ),
//                       ),
//                       FxSpacing.width(16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             FxText.titleMedium(
//                               cart.product.name,
//                               fontWeight: 700,
//                             ),
//                             FxSpacing.height(8),
//                             FxText.bodyMedium(
//                               '\$${cart.product.price}',
//                               fontWeight: 700,
//                             ),
//                             FxSpacing.height(8),
//                             // Row(
//                             //   children: [
//                             //     FxText.bodySmall(
//                             //       'Size : ${cart.selectedSize}',
//                             //       fontWeight: 600,
//                             //     ),
//                             //     FxSpacing.width(20),
//                             //     FxText.bodySmall('Color : '),
//                             //     FxContainer(
//                             //         paddingAll: 8,
//                             //         borderRadiusAll: 2,
//                             //         color: cart.selectedColor,
//                             //         child: Container()),
//                             //   ],
//                             // ),
//                           ],
//                         ),
//                       ),
//                       FxSpacing.width(20),
//                       // Column(
//                       //   children: [
//                       //     FxContainer(
//                       //       onTap: () {
//                       //         controller.increment(cart);
//                       //       },
//                       //       bordered: increaseAble,
//                       //       paddingAll: 4,
//                       //       borderRadiusAll: 2,
//                       //       border: Border.all(color: theme.colorScheme.primary),
//                       //       color: increaseAble
//                       //           ? theme.colorScheme.primary
//                       //           : theme.colorScheme.onBackground.withAlpha(200),
//                       //       child: Icon(
//                       //         FeatherIcons.plus,
//                       //         size: 12,
//                       //         color: increaseAble
//                       //             ? theme.colorScheme.onPrimary
//                       //             : theme.colorScheme.onPrimary,
//                       //       ),
//                       //     ),
//                       //     FxSpacing.height(8),
//                       //     FxText.bodyMedium(
//                       //       cart.person.toString(),
//                       //       fontWeight: 700,
//                       //     ),
//                       //     FxSpacing.height(8),
//                       //     FxContainer(
//                       //       onTap: () {
//                       //         controller.decrement(cart);
//                       //       },
//                       //       paddingAll: 4,
//                       //       borderRadiusAll: 2,
//                       //       bordered: decreaseAble,
//                       //       border: Border.all(
//                       //           color: theme.colorScheme.primary.withAlpha(120)),
//                       //       color: decreaseAble
//                       //           ? theme.colorScheme.primary.withAlpha(28)
//                       //           : theme.colorScheme.onBackground.withAlpha(200),
//                       //       child: Icon(
//                       //         FeatherIcons.minus,
//                       //         size: 12,
//                       //         color: decreaseAble
//                       //             ? theme.colorScheme.primary
//                       //             : theme.colorScheme.onPrimary,
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ));
//     }
//     return Column(
//       children: list,
//     );
//   }
//
//   Widget _billingWidget() {
//     return FadeTransition(
//       opacity: controller.fadeAnimation,
//       child: FxContainer(
//         borderRadiusAll: 4,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             FxText.bodyMedium(
//               'Billing Information',
//               muted: true,
//               fontWeight: 700,
//             ),
//             FxSpacing.height(20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 FxText.bodyMedium(
//                   'Order Total',
//                   fontWeight: 600,
//                 ),
//                 FxText.bodyMedium(
//                   '\$${controller.order.precise}',
//                   fontWeight: 700,
//                 ),
//               ],
//             ),
//             FxSpacing.height(4),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 FxText.bodyMedium(
//                   'Tax',
//                   fontWeight: 600,
//                 ),
//                 FxText.bodyMedium(
//                   '\$${controller.tax.precise}',
//                   fontWeight: 700,
//                 ),
//               ],
//             ),
//             FxSpacing.height(4),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 FxText.bodyMedium(
//                   'Offer',
//                   fontWeight: 600,
//                 ),
//                 FxText.bodyMedium(
//                   '- \$${controller.offer.precise}',
//                   fontWeight: 700,
//                 ),
//               ],
//             ),
//             FxSpacing.height(12),
//             Row(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Container(),
//                 ),
//                 Expanded(
//                   child: FxDashedDivider(
//                     dashSpace: 4,
//                     dashWidth: 8,
//                     color: theme.colorScheme.onBackground.withAlpha(180),
//                     height: 1.2,
//                   ),
//                 )
//               ],
//             ),
//             FxSpacing.height(12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 FxText.bodyMedium(
//                   'Grand Total',
//                   fontWeight: 700,
//                 ),
//                 FxText.bodyMedium(
//                   '\$${controller.total.precise}',
//                   fontWeight: 800,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FxBuilder<CartController>(
//         controller: controller,
//         builder: (controller) {
//           return _buildBody();
//         });
//   }
//
//   Widget _buildBody() {
//     if (controller.uiLoading) {
//       return Scaffold(
//         body: Container(
//             padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
//             child: LoadingEffect.getCartLoadingScreen(
//               context,
//             )),
//       );
//     } else {
//       return Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           automaticallyImplyLeading: false,
//           title: FxText.titleMedium(
//             'Cart',
//             fontWeight: 700,
//           ),
//           centerTitle: true,
//         ),
//         body: controller.carts!.isEmpty
//             ? const Center(
//                 child: Text(
//                   'Add in Your Cart',
//                 ),
//               )
//             : ListView(
//                 padding: FxSpacing.nTop(20),
//                 children: [
//                   _buildCartList(),
//                   _billingWidget(),
//                   FxSpacing.height(20),
//                   FadeTransition(
//                     opacity: controller.fadeAnimation,
//                     child: FxButton.block(
//                         onPressed: () {
//                           controller.goToCheckout();
//                         },
//                         backgroundColor: const Color(0xff1529e8),
//                         // backgroundColor: theme.colorScheme.primary,
//                         elevation: 0,
//                         borderRadiusAll: 4,
//                         child: Row(
//                           children: [
//                             SlideTransition(
//                               position: controller.animation,
//                               child: Image(
//                                 height: 22,
//                                 width: 22,
//                                 color: theme.colorScheme.onPrimary,
//                                 image: const AssetImage(
//                                     'assets/images/apps/shopping2/icons/clear_cart_outline.png'),
//                               ),
//                             ),
//                             Expanded(
//                               child: Center(
//                                 child: FxText.bodyMedium(
//                                   'Checkout',
//                                   fontWeight: 600,
//                                   color: theme.colorScheme.onPrimary,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )),
//                   ),
//                   FxSpacing.height(80),
//                 ],
//               ),
//       );
//     }
//   }
// }


import 'package:hotel_travel/models/all_attraction_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/attraction_Controller.dart';
import '../controllers/saved_controller.dart';
import '../loading_effect.dart';
import '../theme/app_theme.dart';
import 'full_app.dart';

class NewCart extends StatefulWidget {
  final List<Activity> cartMeal;
  const NewCart(this.cartMeal, {super.key});

  @override
  _NewCartState createState() => _NewCartState();
}

class _NewCartState extends State<NewCart>
    with TickerProviderStateMixin {
  late ThemeData theme;

  late NewCartController controller;
  List<AllattractionModal>? allattractionList;
  SharedPreferences? sharedPreferences;

  bool isLoading = true;
  getAttraction(BuildContext context) async {
    // await AuthService().getCountry();
    log('getAttraction function called');
    sharedPreferences = await SharedPreferences.getInstance();
    Future.delayed(Duration.zero, () async {
      await AttractionController().getAllattractionList(context).then((value) {
        if (value != null) {
          isLoading = false;
          allattractionList = [];
          allattractionList!.add(value);
          log('All1:$allattractionList');
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAttraction(context);
    log('saved:${favouriteListCart.length}');
    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(NewCartController(this));
    log('Item:${favouriteListCart.map((e) => e.sId)}');
  }

  Widget _billingWidget(Activity product) {
    List<Widget> list = [];
    log('message');
    // log(widget.length.toString());
    return SizedBox(
      child: ListView.separated(
        itemCount: favouriteListCart.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return FadeTransition(
            opacity: controller.fadeAnimation,
            child: FxContainer(
              borderRadiusAll: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FxText.bodyMedium(
                  //   'Billing Information',
                  //   muted: true,
                  //   fontWeight: 700,
                  // ),
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
                          alignment: Alignment.centerLeft,
                          child: FxText.bodyMedium(
                            // '\$' + controller.order.precise,
                            product.name!,
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
                      product.transferType == null
                          ? FxText.bodyMedium(
                        'without',
                        fontWeight: 700,
                      )
                          : FxText.bodyMedium(
                        product.transferType.toString(),
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
                        product.selectedDate
                            .toString(),
                        fontWeight: 700,
                      ),
                    ],
                  ),
                  FxSpacing.height(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FxText.bodyMedium(
                        'Pax',
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
                                   product.adultCount
                                        .toString(),
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                                FxSpacing.width(4),
                                FxText.bodyMedium('Adult',
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                              ],
                            ),
                          ),
                          FxSpacing.width(10),
                          FxContainer(
                            padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                            color: const Color(0xff1529e8).withAlpha(40),
                            child: Row(
                              children: [
                                FxText.bodyMedium(
                                    product.childCount
                                        .toString(),
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                                FxSpacing.width(4),
                                FxText.bodyMedium('child',
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                              ],
                            ),
                          ),
                          FxSpacing.width(10),
                          FxContainer(
                            padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                            color: const Color(0xff1529e8).withAlpha(40),
                            child: Row(
                              children: [
                                FxText.bodyMedium(
                                    product.infantCount
                                        .toString(),
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                                FxSpacing.width(4),
                                FxText.bodyMedium('Infant',
                                    color: const Color(0xff1529e8),
                                    // color: customTheme.groceryPrimary,
                                    fontWeight: 500,
                                    letterSpacing: -0.2),
                              ],
                            ),
                          )
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
                      FxText.bodyMedium(
                        "${product.grandTotal}AED",
                        fontWeight: 700,
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
                      FxText.bodyMedium(
                        // '\$' + controller.total.precise,
                        "${product.grandTotal}AED",
                        fontWeight: 800,
                        color: const Color(0xff1529e8),
                      ),
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

  }

  Widget _buildSingleProduct(Activity product) {
    String text = product.name!;

    text = text.replaceAll("_", " ");

    List<String> words = text.split(" ");

    for (int i = 0; i < words.length; i++) {
      words[i] =
          words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }

    text = words.join(" ");

    return FadeTransition(
      opacity: controller.fadeAnimation,
      child: FxContainer(
        borderRadiusAll: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FxText.bodyMedium(
            //   'Billing Information',
            //   muted: true,
            //   fontWeight: 700,
            // ),
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
                    alignment: Alignment.centerLeft,
                    child: FxText.bodyMedium(
                      // '\$' + controller.order.precise,
                      product.name!,
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
                product.transferType == null
                    ? FxText.bodyMedium(
                  'without',
                  fontWeight: 700,
                )
                    : FxText.bodyMedium(
                  product.transferType.toString(),
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
                  product.selectedDate
                      .toString(),
                  fontWeight: 700,
                ),
              ],
            ),
            FxSpacing.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FxText.bodyMedium(
                  'Pax',
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
                              product.adultCount
                                  .toString(),
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                          FxSpacing.width(4),
                          FxText.bodyMedium('Adult',
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                        ],
                      ),
                    ),
                    FxSpacing.width(10),
                    FxContainer(
                      padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                      color: const Color(0xff1529e8).withAlpha(40),
                      child: Row(
                        children: [
                          FxText.bodyMedium(
                              product.childCount
                                  .toString(),
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                          FxSpacing.width(4),
                          FxText.bodyMedium('child',
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                        ],
                      ),
                    ),
                    FxSpacing.width(10),
                    FxContainer(
                      padding: FxSpacing.fromLTRB(8, 6, 8, 6),
                      color: const Color(0xff1529e8).withAlpha(40),
                      child: Row(
                        children: [
                          FxText.bodyMedium(
                              product.infantCount
                                  .toString(),
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                          FxSpacing.width(4),
                          FxText.bodyMedium('Infant',
                              color: const Color(0xff1529e8),
                              // color: customTheme.groceryPrimary,
                              fontWeight: 500,
                              letterSpacing: -0.2),
                        ],
                      ),
                    )
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
                FxText.bodyMedium(
                  "${product.grandTotal}AED",
                  fontWeight: 700,
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
                FxText.bodyMedium(
                  // '\$' + controller.total.precise,
                  "${product.grandTotal}AED",
                  fontWeight: 800,
                  color: const Color(0xff1529e8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<NewCartController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        body: Container(
            padding: FxSpacing.top(FxSpacing.safeAreaTop(context) + 20),
            child: LoadingEffect.getCartLoadingScreen(
              context,
            )),
      );
    } else {
      return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: FxText.titleMedium(
            'Cart',
            fontWeight: 700,
          ),
          centerTitle: true,
          backgroundColor: const Color(0xfff5f5f5),
        ),
        body: favouriteListCart.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              // Lottie.asset('assets/lottie/confirmation.json',
              //     height: 300, width: 300),
              Text('You have no cart itmes - start adding some item!',
                  style: TextStyle(
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 16))
            ],
          ),
        )
            :

            Stack(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(5),
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: favouriteListCart.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildSingleProduct(
                      // widget.favouriteMeals.first.attractions.data.first
                        favouriteListCart[index]);
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: FxSpacing.xy(12, 8),
                    child: PhysicalModel(
                      color: theme.cardTheme.color!.withAlpha(200),
                      elevation: 12,
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      shadowColor: theme.colorScheme.onBackground.withAlpha(12),
                      shape: BoxShape.rectangle,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.cardTheme.color!.withAlpha(200),
                          borderRadius: const BorderRadius.all(Radius.circular(32)),
                        ),
                        padding: FxSpacing.xy(16, 12),
                        child: Column(
                          children: <Widget>[
                            FadeTransition(
                              opacity: controller.fadeAnimation,
                              child: FxButton.block(
                                  onPressed:
                                      ()  {
                                    controller.goToCheckout();
                                  },
                                  //     () {
                                  //   // token == null
                                  //   //     ? controller.Login()
                                  //   //     :
                                  //
                                  //   // favouriteListCart
                                  //   //     .add(controller.selectedtour as Activity);
                                  // },
                                  backgroundColor: const Color(0xff1529e8),
                                  // backgroundColor: theme.colorScheme.primary,
                                  elevation: 0,
                                  borderRadiusAll: 4,
                                  child: Row(
                                    children: [
                                      SlideTransition(
                                        position: controller.animation,
                                        child: Image(
                                          height: 22,
                                          width: 22,
                                          color: theme.colorScheme.onPrimary,
                                          image: const AssetImage(
                                              'assets/images/apps/shopping2/icons/clear_cart_outline.png'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: FxText.bodyMedium(
                                            'Checkout',
                                            fontWeight: 600,
                                            color: theme.colorScheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )

      );
    }
  }
}
