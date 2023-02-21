// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class User {
  User({
    this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.photo,
  });

  int? id;
  String name;
  String email;
  String address;
  String phone;
  String photo;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        phone: json["phone"],
        photo: json["photo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "phone": phone,
        "photo": photo,
      };

  User copy() => User(
        id: id,
        name: name,
        email: email,
        address: address,
        phone: phone,
        photo: photo,
      );
}
