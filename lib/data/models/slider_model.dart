// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);


import 'dart:convert';

List<SliderModel> sliderModelFromJson(String str) => List<SliderModel>.from(
    json.decode(str).map((x) => SliderModel.fromJson(x)));

String sliderModelToJson(List<SliderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SliderModel {
  final String id;
  final String title;
  final String imageUrl;
  final bool isOffer;

  SliderModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.isOffer,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: json["_id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        isOffer: json["isOffer"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "imageUrl": imageUrl,
        "isOffer": isOffer,
      };
}
