import 'package:flutter/material.dart';
import 'package:quiz_city_rmas/repository/user_repository/user_repository.dart';
import 'package:get/get.dart';

import '../authentication/models/user_model.dart';

class LeaderboardsScreen extends StatefulWidget {
  const LeaderboardsScreen({super.key});

  @override
  State<LeaderboardsScreen> createState() => _LeaderboardsScreenState();
}

class _LeaderboardsScreenState extends State<LeaderboardsScreen> {
  final userRepo = Get.put(UserRepository());
  late String orderBy = "NumOfPoints";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leaderboards"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          orderBy = "NumOfPoints";
                        });
                      },
                      child: Text(
                        "Most \nPOINTS",
                        textAlign: TextAlign.center,
                      ))),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          orderBy = "NumOfAnsweredQuestions";
                        });
                      },
                      child: Text(
                        "Most ANSWERED",
                        textAlign: TextAlign.center,
                      ))),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          orderBy = "NumOfPostedQuestions";
                        });
                      },
                      child: Text(
                        "Most \nPOSTED",
                        textAlign: TextAlign.center,
                      ))),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          buildLeaderboards(orderBy),
        ],
      ),
    );
  }

  SingleChildScrollView buildLeaderboards(String orderBy) {
    if(orderBy == "NumOfPoints"){
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: FutureBuilder(
            future: userRepo.getAllUsers(orderBy),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<UserModel> userData =
                  snapshot.data as List<UserModel>;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (c, index) {
                      return Column(
                        children: [
                          ListTile(
                            iconColor: Colors.blue,
                            tileColor: Colors.blue.withOpacity(0.1),
                            leading: Text(
                              "${index + 1}.",
                              style: TextStyle(fontSize: 20),
                            ), //TODO
                            title: Text(
                              "${snapshot.data![index].username}: ${snapshot.data![index].numOfPoints}pts",
                                textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
    } else if (orderBy == "NumOfAnsweredQuestions"){
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: FutureBuilder(
            future: userRepo.getAllUsers(orderBy),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<UserModel> userData =
                  snapshot.data as List<UserModel>;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (c, index) {
                      return Column(
                        children: [
                          ListTile(
                            iconColor: Colors.blue,
                            tileColor: Colors.blue.withOpacity(0.1),
                            leading: Text(
                              "${index + 1}.",
                              style: TextStyle(fontSize: 20),
                            ), //TODO
                            title: Text(
                              "${snapshot.data![index].username}: ${snapshot.data![index].numOfAnsweredQuestions}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: FutureBuilder(
            future: userRepo.getAllUsers(orderBy),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<UserModel> userData =
                  snapshot.data as List<UserModel>;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (c, index) {
                      return Column(
                        children: [
                          ListTile(
                            iconColor: Colors.blue,
                            tileColor: Colors.blue.withOpacity(0.1),
                            leading: Text(
                              "${index + 1}.",
                              style: TextStyle(fontSize: 20),
                            ), //TODO
                            title: Text(
                              "${snapshot.data![index].username}: ${snapshot.data![index].numOfPostedQuestions}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
    }
  }
}
