// To parse this JSON data, do
//
//     final foodsWithOfferModel = foodsWithOfferModelFromJson(jsonString);

import 'dart:convert';

List<FoodsWithOffersModel> foodsWithOffersModelFromJson(String str) =>
    List<FoodsWithOffersModel>.from(
        json.decode(str).map((x) => FoodsWithOffersModel.fromJson(x)));

String foodsWithOffersModelToJson(List<FoodsWithOffersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodsWithOffersModel {
  final String id;
  final String title;
  final String type;
  final String? category;
  final String code;
  final bool isAvailable;
  final int rating;
  final String ratingCount;
  final String description;
  final double price;
  final List<String> imageUrl;
  final String time;
  final Offer offer;
  final int v;
  final DateTime createdAt;
  final DateTime updatedAt;
  // final double discountedPrice;

  FoodsWithOffersModel({
    required this.id,
    required this.title,
    required this.type,
    this.category,
    required this.code,
    required this.isAvailable,
    required this.rating,
    required this.ratingCount,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.time,
    required this.offer,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
    // required this.discountedPrice,
  });

  factory FoodsWithOffersModel.fromJson(Map<String, dynamic> json) =>
      FoodsWithOffersModel(
        id: json["_id"],
        title: json["title"],
        type: json["type"],
        category: json["category"],
        code: json["code"],
        isAvailable: json["isAvailable"],
        rating: json["rating"],
        ratingCount: json["ratingCount"],
        description: json["description"],
        price: json["price"].toDouble(),
        // discountedPrice: json["discountedPrice"].toDouble(),
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        time: json["time"],
        offer: Offer.fromJson(json["offer"]),
        v: json["__v"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "type": type,
        "category": category,
        "code": code,
        "isAvailable": isAvailable,
        "rating": rating,
        "ratingCount": ratingCount,
        "description": description,
        "price": price,
        // "discountedPrice": discountedPrice,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "time": time,
        "offer": offer.toJson(),
        "__v": v,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Offer {
  final String discountType;
  final int discountValue;
  final String offerDescription;
  final DateTime startDate;
  final DateTime endDate;
  final String id;

  Offer({
    required this.discountType,
    required this.discountValue,
    required this.offerDescription,
    required this.startDate,
    required this.endDate,
    required this.id,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        discountType: json["discountType"],
        discountValue: json["discountValue"],
        offerDescription: json["offerDescription"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "discountType": discountType,
        "discountValue": discountValue,
        "offerDescription": offerDescription,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "_id": id,
      };
}
