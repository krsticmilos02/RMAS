import 'package:flutter/material.dart';
import 'package:quiz_city_rmas/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:quiz_city_rmas/dashboard/profile/profile_screen.dart';

class DashboardTest extends StatelessWidget {
  const DashboardTest({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Testing'),
        ),
        body: Container(
          padding: EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Welcome to dashboard!'),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      AuthenticationRepository.instance.logout();
                    },
                    child: Text('Sign out'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                        Get.to(ProfileScreen());
                    },
                    child: Text('Go to profile'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
