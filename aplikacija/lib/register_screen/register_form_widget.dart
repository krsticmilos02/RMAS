import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../authentication/models/user_model.dart';
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
              label: Text('Email'),
              hintText: 'Enter email for your login',
              prefixIcon: Icon(Icons.mail),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: controller.username,
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
            controller: controller.fullName,
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
            controller: controller.profilePic,
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
                  // RegisterController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());

                final user = UserModel(
                  email: controller.email.text.trim(),
                  username: controller.username.text.trim(),
                  password: controller.password.text.trim(),
                  fullName: controller.fullName.text.trim(),
                  phoneNo: controller.phoneNo.text.trim(),
                  profilePic: controller.profilePic.text.trim(),
                );

                RegisterController.instance.createUser(user);
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