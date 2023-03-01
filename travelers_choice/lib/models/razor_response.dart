// To parse this JSON data, do
//
//     final razorpayOrderResponse1 = razorpayOrderResponse1FromJson(jsonString);

import 'dart:convert';

RazorpayOrderResponse1 razorpayOrderResponse1FromJson(String str) =>
    RazorpayOrderResponse1.fromJson(json.decode(str));

String razorpayOrderResponse1ToJson(RazorpayOrderResponse1 data) =>
    json.encode(data.toJson());

class RazorpayOrderResponse1 {
  RazorpayOrderResponse1({
    required this.order,
    required this.orderId,
  });

  Order order;
  String orderId;

  factory RazorpayOrderResponse1.fromJson(Map<String, dynamic> json) =>
      RazorpayOrderResponse1(
        // order: json["order"]
        //     .map<Order>((gallery) => Order.fromJson(gallery))
        //     .toList(),
        order: Order.fromJson(json["order"]),
        orderId: json["orderId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "order": order.toJson(),
        "orderId": orderId,
      };
}

class Order {
  Order({
    required this.id,
    required this.entity,
    required this.amount,
    required this.amountPaid,
    required this.amountDue,
    required this.currency,
    this.receipt,
    this.offerId,
    required this.status,
    required this.attempts,
    required this.notes,
    required this.createdAt,
  });

  String id;
  String entity;
  int amount;
  int amountPaid;
  int amountDue;
  String currency;
  dynamic receipt;
  dynamic offerId;
  String status;
  int attempts;
  List<dynamic> notes;
  int createdAt;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] ?? '',
        entity: json["entity"] ?? '',
        amount: json["amount"] ?? 0,
        amountPaid: json["amount_paid"] ?? 0,
        amountDue: json["amount_due"] ?? 0,
        currency: json["currency"] ?? '',
        receipt: json["receipt"] ?? '',
        offerId: json["offer_id"] ?? '',
        status: json["status"] ?? '',
        attempts: json["attempts"] ?? 0,
        notes: List<dynamic>.from(json["notes"].map((x) => x)),
        createdAt: json["created_at"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entity": entity,
        "amount": amount,
        "amount_paid": amountPaid,
        "amount_due": amountDue,
        "currency": currency,
        "receipt": receipt,
        "offer_id": offerId,
        "status": status,
        "attempts": attempts,
        "notes": List<dynamic>.from(notes.map((x) => x)),
        "created_at": createdAt,
      };
}
