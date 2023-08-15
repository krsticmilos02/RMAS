import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_city_rmas/authentication/models/user_model.dart';
import 'package:quiz_city_rmas/repository/authentication_repository/authentication_repository.dart';
import 'package:quiz_city_rmas/repository/user_repository/user_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  //TextField Controlleri za podatke iz TextFields

  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final profilePic = TextEditingController();

  final userRepo = Get.put(UserRepository());

  void registerUser(String email, String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }

 Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    registerUser(user.email!, user.password!);
  }
}