import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  final String id;
  final String userId;
  final List<OrderItem> orderItems;
  final int orderTotal;
  final double deliveryFee;
  final double grandTotal;
  final DeliveryAddress deliveryAddress;
  final String paymentMethod;
  final String paymentStatus;
  final String orderStatus;
  final DateTime orderDate;
  final int rating;
  final String feedback;
  final String orderNote;
  final double discountAmount;
  final String promoCode;
  final int v;

  OrderModel({
    required this.id,
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
    required this.rating,
    required this.feedback,
    required this.orderNote,
    required this.discountAmount,
    required this.promoCode,
    required this.v,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["_id"],
        userId: json["userId"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        orderTotal: json["orderTotal"],
        deliveryFee: json["deliveryFee"]?.toDouble(),
        grandTotal: json["grandTotal"]?.toDouble(),
        deliveryAddress: DeliveryAddress.fromJson(json["deliveryAddress"]),
        paymentMethod: json["paymentMethod"],
        paymentStatus: json["paymentStatus"],
        orderStatus: json["orderStatus"],
        orderDate: DateTime.parse(json["orderDate"]),
        rating: json["rating"],
        feedback: json["feedback"],
        orderNote: json["orderNote"],
        discountAmount: json["discountAmount"]?.toDouble(),
        promoCode: json["promoCode"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "orderTotal": orderTotal,
        "deliveryFee": deliveryFee,
        "grandTotal": grandTotal,
        "deliveryAddress": deliveryAddress.toJson(),
        "paymentMethod": paymentMethod,
        "paymentStatus": paymentStatus,
        "orderStatus": orderStatus,
        "orderDate": orderDate.toIso8601String(),
        "rating": rating,
        "feedback": feedback,
        "orderNote": orderNote,
        "discountAmount": discountAmount,
        "promoCode": promoCode,
        "__v": v,
      };
}

class DeliveryAddress {
  final String id;
  final String addressTitle;
  final String location;
  final String customerName;
  final String phone;
  final double latitude;
  final double longitude;

  DeliveryAddress({
    required this.id,
    required this.addressTitle,
    required this.location,
    required this.customerName,
    required this.phone,
    required this.latitude,
    required this.longitude,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        id: json["_id"],
        addressTitle: json["addressTitle"],
        location: json["location"],
        customerName: json["customerName"],
        phone: json["phone"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "addressTitle": addressTitle,
        "location": location,
        "customerName": customerName,
        "phone": phone,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class OrderItem {
  final String foodId;
  final String title;
  final int quantity;
  final int price;
  final String instructions;
  final String id;

  OrderItem({
    required this.foodId,
    required this.title,
    required this.quantity,
    required this.price,
    required this.instructions,
    required this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        foodId: json["foodId"],
        title: json["title"],
        quantity: json["quantity"],
        price: json["price"],
        instructions: json["instructions"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "foodId": foodId,
        "title": title,
        "quantity": quantity,
        "price": price,
        "instructions": instructions,
        "_id": id,
      };
}
