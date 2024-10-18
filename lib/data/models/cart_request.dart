// To parse this JSON data, do
//
//     final cartRequest = cartRequestFromJson(jsonString);

import 'dart:convert';

CartRequest cartRequestFromJson(String str) => CartRequest.fromJson(json.decode(str));

String cartRequestToJson(CartRequest data) => json.encode(data.toJson());

class CartRequest {
    final String productId;
    final int totalPrice;
    final int quantity;

    CartRequest({
        required this.productId,
        required this.totalPrice,
        required this.quantity,
    });

    factory CartRequest.fromJson(Map<String, dynamic> json) => CartRequest(
        productId: json["productId"],
        totalPrice: json["totalPrice"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "totalPrice": totalPrice,
        "quantity": quantity,
    };
}
