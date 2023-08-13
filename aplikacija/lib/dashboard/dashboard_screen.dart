import 'package:flutter/material.dart';
import 'package:quiz_city_rmas/authentication_repository/authentication_repository.dart';

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
