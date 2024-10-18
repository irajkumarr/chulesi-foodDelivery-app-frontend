// class NotificationModel {
//   final String title;
//   final String body;
//   final DateTime date;  // Add date field

//   NotificationModel({
//     required this.title,
//     required this.body,
//     required this.date,
//   });

//   Map<String, dynamic> toJson() => {
//         'title': title,
//         'body': body,
//         'date': date.toIso8601String(),  // Convert date to string
//       };

//   factory NotificationModel.fromJson(Map<String, dynamic> json) {
//     return NotificationModel(
//       title: json['title'],
//       body: json['body'],
//       date: DateTime.parse(json['date']),  // Parse date from string
//     );
//   }
// }
class NotificationModel {
  final String title;
  final String body;
  final DateTime date;
  final String? imageUrl;

  NotificationModel({
    required this.title,
    required this.body,
    required this.date,
    this.imageUrl,
  });

  // Convert NotificationModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'date': date.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }

  // Create NotificationModel from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      date: DateTime.parse(json['date']),
      imageUrl: json['imageUrl'],
    );
  }
}
