import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:quiz_city_rmas/authentication/models/user_model.dart';
import 'package:quiz_city_rmas/repository/authentication_repository/authentication_repository.dart';

import '../repository/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get intance => Get.find();



  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null){
     return _userRepo.getUserDetails(email);
    }
    else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  updateRecord(UserModel user) async{
    await _userRepo.updateUser(user);
  }
}