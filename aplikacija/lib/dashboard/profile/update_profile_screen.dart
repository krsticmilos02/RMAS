import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_city_rmas/controllers/profile_controller.dart';

import '../../authentication/models/user_model.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final ImagePicker _picker = ImagePicker();
    var image;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Edit Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel initUserData = snapshot.data as UserModel;

                  final fullName = TextEditingController(text: initUserData.fullName);
                  final email = TextEditingController(text: initUserData.email);
                  final phoneNo = TextEditingController(text: initUserData.phoneNo);
                  final password = TextEditingController(text: initUserData.password);

                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                  'images/ja.jpg'),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey.withOpacity(0.1),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  image = await _picker.pickImage(source: ImageSource.gallery);

                                  print("success");
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fullName,
                              decoration: InputDecoration(
                                label: Text('Full name'),
                                hintText: 'Enter your full name',
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                label: Text('E-mail'),
                                hintText: 'Enter your E-mail',
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: phoneNo,
                              decoration: InputDecoration(
                                label: Text('Phone Number'),
                                hintText: 'Enter your phone number',
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: password,
                              decoration: InputDecoration(
                                label: Text('Password'),
                                hintText: 'Enter your password',
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final userData = UserModel(
                                      id: initUserData.id,
                                      email: email.text.trim(),
                                      username: initUserData.username,
                                      fullName: fullName.text.trim(),
                                      password: password.text.trim(),
                                      phoneNo: phoneNo.text.trim(),
                                      profilePic: initUserData.profilePic);

                                  await controller.updateRecord(userData);
                                },
                                child: const Text('Save changes'),
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide.none,
                                  shape: const StadiumBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
