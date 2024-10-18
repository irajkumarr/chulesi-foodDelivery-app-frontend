// To parse this JSON data, do
//
//     final categoriesModel = categoriesModelFromJson(jsonString);

import 'dart:convert';

List<CategoriesModel> categoriesModelFromJson(String str) =>
    List<CategoriesModel>.from(
        json.decode(str).map((x) => CategoriesModel.fromJson(x)));

String categoriesModelToJson(List<CategoriesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriesModel {
  final String id;
  final String title;
  final String value;
  final bool bestCategory;
  final String imageUrl;

  CategoriesModel({
    required this.id,
    required this.title,
    required this.value,
    required this.bestCategory,
    required this.imageUrl,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        id: json["_id"],
        title: json["title"],
        value: json["value"],
        bestCategory: json["bestCategory"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "value": value,
        "bestCategory": bestCategory,
        "imageUrl": imageUrl,
      };
}
