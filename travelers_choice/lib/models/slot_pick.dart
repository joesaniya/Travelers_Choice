import 'Slot_Time.dart';

class CustomSlots {
  String? id;
  int SelectedIndex;
  List<SlotTime>? slots;
  SlotTime? event;

  CustomSlots({
    this.id,
    this.SelectedIndex =-1,
    this.slots,
    this.event,
  });
}
