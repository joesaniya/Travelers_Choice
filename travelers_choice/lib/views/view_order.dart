import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

import 'package:hotel_travel/models/order_attraction_modal.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/view_controller.dart';

class ViewOrder extends StatefulWidget {
  // String? Id;
  // List<Datum>? bookingorders;
  AllAttractionOrders? bookingorders;
  ViewOrder(
      Datum ordermodal,
      {super.key,
      // this.Id
      this.bookingorders});

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> with TickerProviderStateMixin {
  late ViewOrderController controller;
  @override
  void initState() {
    super.initState();
    // log('Order Id:$Id');
    controller = FxControllerStore.put(ViewOrderController(
      this,
      //  widget.productid
    ));
    // controller.getOrder(widget.Id, setState);
  }

  Widget _buildnew() {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        backgroundColor: const Color(0xfff5f5f5),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            MdiIcons.chevronLeft,
            size: 20,
            color: Colors.black,
            // color: theme.colorScheme.onBackground,
          ),
        ),
        title: FxText("Reviews", fontWeight: 600),
      ),
      body: ListView(
        padding: FxSpacing.x(20),
        children: [
          FxContainer(
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
                        alignment: Alignment.centerLeft,
                        child: FxText.bodyMedium(
                          // '\$' + controller.order.precise,
                          'I ly',
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

                    // widget.Transfer == null
                    //     ? FxText.bodyMedium(
                    //         'without',
                    //         fontWeight: 700,
                    //       )
                    //     :
                    FxText.bodyMedium(
                      'widget.Transfer.toString()',
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
                      'gg',
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
                              FxText.bodyMedium('hh',
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
                              FxText.bodyMedium('hh',
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
                              FxText.bodyMedium('3',
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
                      "150 AED",
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
                    const Expanded(
                      child: FxDashedDivider(
                        dashSpace: 4,
                        dashWidth: 8,
                        color: Colors.black,
                        // color: theme.colorScheme.onBackground.withAlpha(180),
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
                      "150 AED",
                      fontWeight: 800,
                      color: const Color(0xff1529e8),
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

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ViewOrderController>(
        controller: controller,
        builder: (controller) {
          return _buildnew();
        });
  }
}
