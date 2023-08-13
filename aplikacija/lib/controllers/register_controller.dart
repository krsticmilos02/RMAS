import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_city_rmas/authentication_repository/authentication_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  //TextField Controlleri za podatke iz TextFields

  final email = TextEditingController();
  final password = TextEditingController();
  final  fullname = TextEditingController();
  final phoneNo = TextEditingController();

  void registerUser(String email, String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }
}