import 'dart:convert';

OrderRequest orderRequestFromJson(String str) =>
    OrderRequest.fromJson(json.decode(str));

String orderRequestToJson(OrderRequest data) => json.encode(data.toJson());

class OrderRequest {
  final String userId;
  final List<OrderItem> orderItems;
  final double orderTotal;
  final double deliveryFee;
  final double grandTotal;
  final String deliveryAddress;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final DateTime orderDate;
  // final int rating;
  // final String feedback;
  final double? rating; // Optional
  final String? feedback; // Optional
  final String orderNote;
  final double discountAmount;
  final String promoCode;

  OrderRequest({
    required this.userId,
    required this.orderItems,
    required this.orderTotal,
    required this.deliveryFee,
    required this.grandTotal,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.orderStatus,
    required this.orderDate,
    this.rating,
    this.feedback,
    required this.orderNote,
    required this.discountAmount,
    required this.promoCode,
  });

  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
        userId: json["userId"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        orderTotal: json["orderTotal"],
        deliveryFee: json["deliveryFee"],
        grandTotal: json["grandTotal"],
        deliveryAddress: json["deliveryAddress"],
        paymentMethod: json["paymentMethod"],
        paymentStatus: json["paymentStatus"],
        orderStatus: json["orderStatus"],
        orderDate: DateTime.parse(json["orderDate"]),
        rating: json["rating"]?.toDouble(),
        feedback: json["feedback"],
        orderNote: json["orderNote"],
        discountAmount: json["discountAmount"],
        promoCode: json["promoCode"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "orderTotal": orderTotal,
        "deliveryFee": deliveryFee,
        "grandTotal": grandTotal,
        "deliveryAddress": deliveryAddress,
        "paymentMethod": paymentMethod,
        "paymentStatus": paymentStatus,
        "orderStatus": orderStatus,
        "orderDate": orderDate.toIso8601String(),
        "rating": rating,
        "feedback": feedback,
        "orderNote": orderNote,
        "discountAmount": discountAmount,
        "promoCode": promoCode,
      };
}

class OrderItem {
  final String foodId;
  final String title;
  final int quantity;
  final int price;
  final String instructions;

  OrderItem({
    required this.foodId,
    required this.title,
    required this.quantity,
    required this.price,
    required this.instructions,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        foodId: json["foodId"],
        title: json["title"],
        quantity: json["quantity"],
        price: json["price"],
        instructions: json["instructions"],
      );

  Map<String, dynamic> toJson() => {
        "foodId": foodId,
        "title": title,
        "quantity": quantity,
        "price": price,
        "instructions": instructions,
      };
}
