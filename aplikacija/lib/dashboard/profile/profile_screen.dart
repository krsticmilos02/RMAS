import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/profile_menu_widget.dart';
import 'update_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'My Profile',
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(isDark ? Icons.sunny : Icons.shield_moon_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
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
                        icon: Icon(Icons.edit,
                          color: Colors.black,
                          size: 20,),
                       onPressed: () {  },),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text('Testing heading'),
              Text('Testing subheading'),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(()=> const UpdateProfileScreen()),
                  child: const Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide.none,
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 10.0,
              ),

              //menu
              ProfileMenuWidget(
                title: 'Settings',
                icon: Icons.settings,
                onPress: (){},
              ),
              ProfileMenuWidget(
                title: 'User Managment',
                icon: Icons.person_outline_outlined,
                onPress: (){},
              ),
              const Divider(),
              const SizedBox(height: 10,),
              ProfileMenuWidget(
                title: 'Information',
                icon: Icons.info_outline,
                onPress: (){},
              ),
              ProfileMenuWidget(
                title: 'Logout',
                icon: Icons.logout,
                textColor: Colors.red,
                endIcon: false,
                onPress: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

