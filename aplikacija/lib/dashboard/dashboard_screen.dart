import 'package:flutter/material.dart';
import 'package:quiz_city_rmas/controllers/profile_controller.dart';
import 'package:get/get.dart';
import '../authentication/models/user_model.dart';
import '../widgets/bottom_nav_widget.dart';

class DashboardTest extends StatelessWidget {
  const DashboardTest({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    var _fullName;
    var _username;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Quiz City'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(30.0),
                child: FutureBuilder(
                  future: controller.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        UserModel initUserData = snapshot.data as UserModel;
                        _fullName = initUserData.fullName;
                        _username = initUserData.username;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(_fullName),
                            Text(_username),
                            SizedBox(
                              height: 30.0,
                            ),
                            Text("Stats:"),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(TextSpan(
                                    text: '# Answered Questions: ',
                                    children: [TextSpan(text: 'TODO')])),
                                Text.rich(TextSpan(
                                    text: '# Points: ',
                                    children: [TextSpan(text: 'TODO')])),
                                Text.rich(TextSpan(
                                    text: '# Posted Questions: ',
                                    children: [TextSpan(text: 'TODO')])),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  //TODO: go to leaderboards page
                                },
                                child: Text('LEADERBOARDS'),
                              ),
                            ),
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
            BottomNavWidget(isMap: false,),
          ],
        ),
      ),
    );
  }
}


