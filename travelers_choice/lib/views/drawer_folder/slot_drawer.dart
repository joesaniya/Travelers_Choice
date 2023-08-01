import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/Activity_Controller.dart';
import '../../models/Slot_Time.dart';
import '../../models/atteraction_model.dart';
import '../../models/slot_pick.dart';
import '../../services/app_constants.dart';
import '../../theme/app_theme.dart';

class SlotTimeDrawer extends StatefulWidget {
  List<Activity> excursionSlot;
  final String excursionidSlot;
  final void Function(SlotTime) onOptionSelected;
  // List<SlotTime>? Slots;
  List<CustomSlots> Slots;
  // final String selectedDate;

  // final Function getdataSlot;
  SlotTimeDrawer({
    super.key,
    required this.excursionSlot,
    required this.excursionidSlot,
    required this.onOptionSelected,
    // required this.getdataSlot
    required this.Slots,
    // required this.selectedDate
  });

  @override
  State<SlotTimeDrawer> createState() => _SlotTimeDrawerState();
}

class _SlotTimeDrawerState extends State<SlotTimeDrawer>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late ActivityController controller;
  @override
  void initState() {
    super.initState();
    log('SlotTimeDrawer calling');

    theme = AppTheme.shoppingTheme;

    controller = FxControllerStore.put(ActivityController(this));
    initializingData();
    // controller.SlotPick(
    //   "83",
    //   "54",
    //   "2023-08-20",
    // );

    log('Slots:${widget.Slots}');
    log('Slots:${widget.Slots.map((e) => e.slots!.first.eventName).toList()}');
    // log('Date:${widget.selectedDate}');

    // log(controller.person_count);
  }

  String? currencySymbol;
  double? conversionRate;
  void initializingData() {
    SharedPreferences.getInstance().then((sharedPrefValue) {
      setState(() {
        conversionRate = sharedPrefValue.getDouble(AppConstants.rate);
        log('conversionRate:$conversionRate');
        currencySymbol = sharedPrefValue.getString(AppConstants.symbol);
        log('currencySymbol:$currencySymbol');
      });
    });
  }

  // void updateDrawerData(String newData) {
  //   log('New:$newData');

  //   controller.drawerData = newData;
  // }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<ActivityController>(
        controller: controller,
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    return SafeArea(
      child: widget.Slots.isEmpty
          ? const CircularProgressIndicator()
          : Container(
              margin: FxSpacing.fromLTRB(16, 16, 16, 80),
              width: 300,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Color(0xff1529e8),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Drawer(
                child: Container(
                  // color: const Color(0xff1529e8),
                  color: const Color(0xfff5f5f5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: FxSpacing.xy(16, 12),
                        color: const Color(0xff1529e8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: FxText(
                                  "Pick Your Time Slot",
                                  fontWeight: 700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            FxContainer.rounded(
                                onTap: () {
                                  // controller.closeEndDrawer();

                                  log('close');

                                  Navigator.of(context).pop();
                                  // controller.scaffoldKey.currentState
                                  //     ?.closeEndDrawer();
                                },
                                paddingAll: 6,
                                color: const Color(0xff1529e8).withAlpha(40),
                                child: const Icon(
                                  FeatherIcons.x,
                                  size: 12,
                                  color: Colors.white,
                                  // color: Color(0xff1529e8),
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: 1,
                            padding: FxSpacing.all(16),
                            itemBuilder: (context, index) {
                              return Container(
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FxText.bodyMedium(
                                            "Selected Date:",
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 600,
                                          ),
                                          FxText.bodySmall(
                                            widget.excursionSlot[index]
                                                .selectedDate
                                                .toString(),
                                            // '24.05.2023',
                                            color:
                                                theme.colorScheme.onBackground,
                                            fontWeight: 600,
                                            xMuted: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                    FxSpacing.height(16),
                                    Container(
                                      child: GridView(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10.0,
                                          mainAxisSpacing: 10.0,
                                          mainAxisExtent: 170, // ** add this **
                                        ),
                                        // crossAxisCount: 2,
                                        // crossAxisSpacing: 10.0,
                                        // // mainAxisSpacing: 10.0,
                                        // mainAxisExtent: 300,
                                        shrinkWrap: true,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        children: List.generate(
                                          // controller.timeslotstart,
                                          9,
                                          (index) {
                                            return FxContainer(
                                              onTap: () {
                                                // controller.closeEndDrawer();
                                                setState(() {});
                                                log('selected:${controller.defaultChoiceIndex}');
                                              },
                                              padding: FxSpacing.y(12),
                                              color: controller
                                                          .defaultChoiceIndex ==
                                                      index
                                                  ? Colors.red
                                                  : const Color(0xff22C55E),
                                              child: Column(
                                                children: [
                                                  FxText.bodyMedium(
                                                    "Start Time",
                                                    color: Colors.white,
                                                    fontWeight: 600,
                                                  ),
                                                  FxText.bodyMedium(
                                                    controller
                                                        .timeslotstart[index],
                                                    color: Colors.white,
                                                    fontWeight: 600,
                                                  ),
                                                  FxText.bodyMedium(
                                                    "End Time",
                                                    color: Colors.white,
                                                    fontWeight: 600,
                                                  ),
                                                  FxText.bodyMedium(
                                                    controller
                                                        .timeslotend[index],
                                                    color: Colors.white,
                                                    fontWeight: 600,
                                                  ),
                                                  FxText.bodyMedium(
                                                    "Adult Price",
                                                    color: Colors.white,
                                                    fontWeight: 600,
                                                  ),
                                                  FxText.bodyMedium(
                                                    // '${widget.Slots![index].adultPrice}AED',
                                                    // '${((widget.Slots[index].adultPrice.toDouble() * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                                                    '554 AED',
                                                    color: Colors.white,
                                                    fontWeight: 600,
                                                  ),
                                                  FxText.bodyMedium(
                                                    "Child Price",
                                                    color: Colors.white,
                                                    fontWeight: 600,
                                                  ),
                                                  FxText.bodyMedium(
                                                    '0 AED',
                                                    // '${widget.Slots[index].adultPrice}AED',
                                                    // '${((widget.Slots[index].childPrice.toDouble() * conversionRate!)).toStringAsFixed(2)} $currencySymbol',
                                                    color: Colors.white,
                                                    fontWeight: 600,
                                                  ),
                                                  Expanded(child: Container())
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    FxSpacing.height(16),
                                  ],
                                ),
                              );
                            }),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                                child: FxContainer(
                              onTap: () {
                                controller.closeEndDrawer();
                              },
                              padding: FxSpacing.y(12),
                              child: Center(
                                child: FxText(
                                  "Clear",
                                  color: Colors.black,
                                  fontWeight: 600,
                                ),
                              ),
                            )),
                            Expanded(
                                child: FxContainer.none(
                              onTap: () {
                                // widget
                                //     .onOptionSelected(controller.slottimeget![index]);
                                // controller.closeEndDrawer();
                                // updateDrawerData('Data for Item 1');
                                controller.closeEndDrawer();
                              },
                              padding: FxSpacing.y(12),
                              color: const Color(0xff1529e8),
                              child: Center(
                                child: FxText(
                                  "Apply",
                                  color: Colors.white,
                                  fontWeight: 600,
                                ),
                              ),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
