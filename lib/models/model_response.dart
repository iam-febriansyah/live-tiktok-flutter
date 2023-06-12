// To parse this JSON data, do
//
//     final loginResponse = globalResponseFromJson(jsonString);

import 'dart:convert';

import 'model_user.dart';

GlobalResponse globalResponseFromJson(String str) => GlobalResponse.fromJson(json.decode(str));

String globalResponseToJson(GlobalResponse data) => json.encode(data.toJson());

class GlobalResponse {
  bool status;
  String remarks;
  User? user;

  GlobalResponse({
    required this.status,
    required this.remarks,
    this.user,
  });

  factory GlobalResponse.fromJson(Map<String, dynamic> json) => GlobalResponse(
        status: json["status"],
        remarks: json["remarks"],
        user: json["data"] != null ? User.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "remarks": remarks,
        "user": user,
      };
}

class GeneralList {
  String id;
  String title;
  String subtitle;

  GeneralList({
    required this.id,
    required this.title,
    required this.subtitle,
  });

  factory GeneralList.fromJson(Map<String, dynamic> json) => GeneralList(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "Password": subtitle,
      };
}
