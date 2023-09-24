import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_city_rmas/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser;
  late var retrievedUserId;

  createUser(UserModel user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
    });
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();

    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;

    retrievedUserId = userData.id;

    print(userData.id);

    return userData;
  }

  Future<List<UserModel>> getAllUsers(String orderBy) async{

    final snapshot = await _db.collection("Users").orderBy("${orderBy}", descending: true).get();

    snapshot.docs.length = 1;

    final listOfUsers = snapshot.docs.map((e)=> UserModel.fromSnapshot(e)).toList();

    return listOfUsers;
  }


  Future<void> updateUser(UserModel user) async {
    await _db
        .collection("Users")
        .doc(user.id)
        .update(user.toJson())
        .catchError((e) {
      print(user.id);
    });
  }
}
