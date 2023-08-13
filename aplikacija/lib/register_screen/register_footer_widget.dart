import 'package:flutter/material.dart';

import '../login_screen/login_screen.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text('OR'),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text.rich(
              TextSpan(
                text: 'Already have an Account?',
                style: TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: ' Log in',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
