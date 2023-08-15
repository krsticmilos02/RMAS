import 'package:flutter/material.dart';
import 'register_form_widget.dart';
import 'register_footer_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Testing'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: RegisterForm(),
                ),
                RegisterFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

