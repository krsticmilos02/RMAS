import 'package:flutter/material.dart';
import 'package:quiz_city_rmas/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _formLoginKey = GlobalKey<FormState>();

    return Form(
      key: _formLoginKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: 'Email',
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.remove_red_eye_sharp))),
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {}, child: Text('Forgot Password?')),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if(_formLoginKey.currentState!.validate()){
                    LoginController.instance.loginUser(controller.email.text.trim(), controller.password.text.trim());
                  }
                },
                child: Text('Login'),
              ),
            ),
          ],
        ));
  }
}