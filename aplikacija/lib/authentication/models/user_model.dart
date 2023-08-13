import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? username;
  final String? fullName;
  final String? password;
  final String? phoneNo;
  final String? profilePic;

  const UserModel({this.id,
    required this.email,
    required this.username,
    required this.fullName,
    required this.password,
    required this.phoneNo,
    required this.profilePic});

  toJson() {
    return {
      "Email": email,
      "Username": username,
      "FullName": fullName,
      "Password": password,
      "PhoneNo": phoneNo,
      "ProfilePic": profilePic,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;

    return UserModel(
    id: document.id,
    email: data["Email"],
    username: data["Username"],
    fullName: data["FullName"],
    password: data["Password"],
    phoneNo: data["PhoneNo"],
    profilePic: data["ProfilePic"],

    );
  }
}
