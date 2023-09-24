import 'package:flutter/material.dart';
import 'package:quiz_city_rmas/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _formLoginKey = GlobalKey<FormState>();
    bool hidePassword = true;

    void _hidePasswordSet() {
      if (hidePassword) {
        hidePassword = false;
        print(hidePassword);
      } else {
        hidePassword = true;
        print(hidePassword);
      }

      setState(() {});
    }

    return Form(
        key: _formLoginKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              validator: (value) => EmailValidator.validate(value!)
                  ? null
                  : "Please enter a valid email",
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
              obscureText: hidePassword,
              controller: controller.password,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.fingerprint),
                labelText: 'Password',
                hintText: 'Enter your password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.centerRight,
              child:
                  TextButton(onPressed: () {}, child: Text('Forgot Password?')),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_formLoginKey.currentState!.validate()) {
                    LoginController.instance.loginUser(
                        controller.email.text.trim(),
                        controller.password.text.trim());
                  }
                },
                child: Text('Login'),
              ),
            ),
          ],
        ));
  }
}

// class LoginForm extends StatelessWidget {
//   const LoginForm({
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(LoginController());
//     final _formLoginKey = GlobalKey<FormState>();
//     bool hidePassword = true;
//
//     void _hidePasswordSet(){
//       if(hidePassword){
//         hidePassword = false;
//       }
//       else {
//         hidePassword = true;
//       }
//     }
//
//     return Form(
//       key: _formLoginKey,
//         autovalidateMode: AutovalidateMode.always,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextFormField(
//               validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
//               controller: controller.email,
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.person_outline_outlined),
//                 labelText: 'Email',
//                 hintText: 'Enter your email',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             TextFormField(
//               obscureText: hidePassword,
//               controller: controller.password,
//               decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.fingerprint),
//                   labelText: 'Password',
//                   hintText: 'Enter your password',
//                   border: OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                       onPressed: _hidePasswordSet ,
//                       icon: Icon(Icons.remove_red_eye_sharp))),
//             ),
//             SizedBox(
//               height: 20.0,
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: TextButton(
//                   onPressed: () {}, child: Text('Forgot Password?')),
//             ),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if(_formLoginKey.currentState!.validate()){
//                     LoginController.instance.loginUser(controller.email.text.trim(), controller.password.text.trim());
//                   }
//                 },
//                 child: Text('Login'),
//               ),
//             ),
//           ],
//         ));
//
//
//
//   }
// }
