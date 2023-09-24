import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? username;
  final String? fullName;
  final String? password;
  final String? phoneNo;
  final String? profilePic;
  final int numOfAnsweredQuestions;
  final int numOfPoints;
  final int numOfPostedQuestions;

  const UserModel({this.id,
    required this.email,
    required this.username,
    required this.fullName,
    required this.password,
    required this.phoneNo,
    required this.profilePic,
    this.numOfAnsweredQuestions = 0,
    this.numOfPoints = 0,
    this.numOfPostedQuestions = 0,});

  toJson() {
    return {
      "Email": email,
      "Username": username,
      "FullName": fullName,
      "Password": password,
      "PhoneNo": phoneNo,
      "ProfilePic": profilePic,
      "NumOfAnsweredQuestions": numOfAnsweredQuestions,
      "NumOfPoints": numOfPoints,
      "NumOfPostedQuestions": numOfPostedQuestions,

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
    numOfAnsweredQuestions: data["NumOfAnsweredQuestions"],
    numOfPoints: data["NumOfPoints"],
    numOfPostedQuestions: data["NumOfPostedQuestions"],

    );
  }


}
