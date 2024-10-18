// // // To parse this JSON data, do
// // //
// // //     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

List<CartResponse> cartResponseFromJson(String str) => List<CartResponse>.from(
    json.decode(str).map((x) => CartResponse.fromJson(x)));

String cartResponseToJson(List<CartResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartResponse {
  final String id;
  final ProductId productId;
  final String instructions;
  final int quantity;
  final int totalPrice;

  CartResponse({
    required this.id,
    required this.productId,
    required this.instructions,
    required this.quantity,
    required this.totalPrice,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        id: json["_id"],
        productId: ProductId.fromJson(json["productId"]),
        instructions: json["instructions"],
        quantity: json["quantity"],
        totalPrice: json["totalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "productId": productId.toJson(),
        "instructions": instructions,
        "quantity": quantity,
        "totalPrice": totalPrice,
      };
}

class ProductId {
  final String id;
  final String title;
  final int rating;
  final String ratingCount;
  final int price;
  final List<String> imageUrl;

  ProductId({
    required this.id,
    required this.title,
    required this.rating,
    required this.ratingCount,
    required this.price,
    required this.imageUrl,
  });

  factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        title: json["title"],
        rating: json["rating"],
        ratingCount: json["ratingCount"],
        price: json["price"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "rating": rating,
        "ratingCount": ratingCount,
        "price": price,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
      };
}
