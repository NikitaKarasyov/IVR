import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/api.dart';
import '../models/user.dart';
// import '../models/quiz.dart';
import '../models/achievement.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];
  bool isLoading = true;

  void fetchData() async {
    try {
      http.Response user_response = await http.get(Uri.parse(api_users));
      var user_data = json.decode(user_response.body);
      print(user_data);
      user_data.forEach((user) {
        User u = User(
            id: user['id'],
            name: user['name'],
            email: user['email'],
            password: user['password'],
            contact: user['contact'],
            currentPoints: user['current_points'],
            participating: user['participating'],
            achievements: user['achievements'],
            points: user['points']);
        users.add(u);
      });
      print(users.length);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Exception happened. See the full trace: \n$e");
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
