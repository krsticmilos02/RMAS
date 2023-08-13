import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final _formRegisterKey = GlobalKey<FormState>();

    return Form(
      key: _formRegisterKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller.email,
            decoration: InputDecoration(
              label: Text('Username'),
              hintText: 'Enter username for your login',
              prefixIcon: Icon(Icons.person_outline_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: controller.password,
            decoration: InputDecoration(
              label: Text('Passowrd'),
              hintText: 'Enter password',
              prefixIcon: Icon(Icons.fingerprint),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: controller.fullname,
            decoration: InputDecoration(
              label: Text('Full Name'),
              hintText: 'Enter password',
              prefixIcon: Icon(Icons.drive_file_rename_outline),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: controller.phoneNo,
            decoration: InputDecoration(
              label: Text('Phone number'),
              hintText: 'Enter password',
              prefixIcon: Icon(Icons.phone_enabled),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              label: Text('Profile picture'),
              hintText: 'Enter password',
              prefixIcon: Icon(Icons.portrait),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if(_formRegisterKey.currentState!.validate()){
                  RegisterController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                }
              },
              child: Text('SIGNUP'),
            ),
          ),
        ],
      ),
    );
  }
}