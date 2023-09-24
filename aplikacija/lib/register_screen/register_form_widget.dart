import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../authentication/models/user_model.dart';
import '../controllers/register_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final controller = Get.put(RegisterController());
  final _formRegisterKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  XFile? profilePic;
  UploadTask? uploadTask;
  late String profilePicUrl;

  Future uploadPicture() async {
    final path = 'files/pictures/${profilePic!.name}';
    final file = File(profilePic!.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    profilePicUrl = urlDownload.toString();
    print('Download link: ${urlDownload}');
  }

  Future selectFileGallery() async {
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result == null)
      return;
    setState(() {
      profilePic = result;
    });
    uploadPicture();
  }
  Future selectFileCamera() async {
    final result = await picker.pickImage(source: ImageSource.camera);
    if (result == null)
      return;
    setState(() {
      profilePic = result;
    });
    uploadPicture();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formRegisterKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
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
            obscureText: true,
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
          Text(
            "Set your profile picture",
            style: TextStyle(
              fontSize: 20,

            ),
            textAlign: TextAlign.center,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: selectFileGallery,
                  child: Text('Upload photo'),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: selectFileCamera,
                  child: Text('Use camera'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formRegisterKey.currentState!.validate()) {
                  // RegisterController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());

                  final user = UserModel(
                    email: controller.email.text.trim(),
                    username: controller.username.text.trim(),
                    password: controller.password.text.trim(),
                    fullName: controller.fullName.text.trim(),
                    phoneNo: controller.phoneNo.text.trim(),
                    profilePic: profilePicUrl,
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

//
// class RegisterForm extends StatelessWidget {
//   const RegisterForm({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(RegisterController());
//     final _formRegisterKey = GlobalKey<FormState>();
//
//     return Form(
//       key: _formRegisterKey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextFormField(
//             controller: controller.email,
//             decoration: InputDecoration(
//               label: Text('Email'),
//               hintText: 'Enter email for your login',
//               prefixIcon: Icon(Icons.mail),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//           TextFormField(
//             controller: controller.username,
//             decoration: InputDecoration(
//               label: Text('Username'),
//               hintText: 'Enter username for your login',
//               prefixIcon: Icon(Icons.person_outline_outlined),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//           TextFormField(
//             controller: controller.password,
//             decoration: InputDecoration(
//               label: Text('Passowrd'),
//               hintText: 'Enter password',
//               prefixIcon: Icon(Icons.fingerprint),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//           TextFormField(
//             controller: controller.fullName,
//             decoration: InputDecoration(
//               label: Text('Full Name'),
//               hintText: 'Enter password',
//               prefixIcon: Icon(Icons.drive_file_rename_outline),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//           TextFormField(
//             controller: controller.phoneNo,
//             decoration: InputDecoration(
//               label: Text('Phone number'),
//               hintText: 'Enter password',
//               prefixIcon: Icon(Icons.phone_enabled),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//           ElevatedButton(
//             onPressed: selectFile,
//             child: Text('Select profile image'),
//           ),
//           TextFormField(
//             controller: controller.profilePic,
//             decoration: InputDecoration(
//               label: Text('Profile picture'),
//               hintText: 'Enter password',
//               prefixIcon: Icon(Icons.portrait),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(
//             height: 20.0,
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_formRegisterKey.currentState!.validate()) {
//                   // RegisterController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
//
//                   final user = UserModel(
//                     email: controller.email.text.trim(),
//                     username: controller.username.text.trim(),
//                     password: controller.password.text.trim(),
//                     fullName: controller.fullName.text.trim(),
//                     phoneNo: controller.phoneNo.text.trim(),
//                     profilePic: controller.profilePic.text.trim(),
//                   );
//
//                   RegisterController.instance.createUser(user);
//                 }
//               },
//               child: Text('SIGNUP'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
