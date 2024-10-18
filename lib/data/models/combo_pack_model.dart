// To parse this JSON data, do
//
//     final comboPackModel = comboPackModelFromJson(jsonString);

import 'dart:convert';

List<ComboPackModel> comboPackModelFromJson(String str) =>
    List<ComboPackModel>.from(
        json.decode(str).map((x) => ComboPackModel.fromJson(x)));

String comboPackModelToJson(List<ComboPackModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComboPackModel {
  final String id;
  final String title;
  final String description;
  final String ratingCount;
  final bool isAvailable;
  final int rating;
  final int price;
  final List<String> imageUrl;
  final int v;

  ComboPackModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isAvailable,
    required this.rating,
    required this.ratingCount,
    required this.price,
    required this.imageUrl,
    required this.v,
  });

  factory ComboPackModel.fromJson(Map<String, dynamic> json) => ComboPackModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        ratingCount: json["ratingCount"],
        isAvailable: json["isAvailable"],
        rating: json["rating"],
        price: json["price"],
        imageUrl: List<String>.from(json["imageUrl"].map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "ratingCount": ratingCount,
        "isAvailable": isAvailable,
        "rating": rating,
        "price": price,
        "imageUrl": List<dynamic>.from(imageUrl.map((x) => x)),
        "__v": v,
      };
}
