import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_city_rmas/repository/authentication_repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //TextField Controlleri za podatke iz TextFields

  final email = TextEditingController();
  final password = TextEditingController();

  void loginUser(String email, String password) {
    AuthenticationRepository.instance.loginUserWithEmailAndPassword(email, password);
  }
}