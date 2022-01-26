import 'package:flutter/material.dart';
import 'package:frontend/src/models/quiz.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/api.dart';

import '../models/user.dart';
// import '../models/quiz.dart';
import '../models/achievement.dart';
import '../widgets/quiz_card.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final User user;

  const HomePage(this.user, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(user);
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];
  List<Quiz> quizes = [];
  bool isLoading = true;
  int _selectedIndex = 0;
  User user;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _HomePageState(this.user);
  void fetchData() async {
    try {
      http.Response quizResponse = await http.get(Uri.parse(api_quizes));
      var quizData = json.decode(quizResponse.body);
      print(quizData);
      quizData.forEach((quiz) {
        Quiz q = Quiz(
            id: quiz['id'],
            name: quiz['name'],
            description: quiz['description'],
            date: DateTime.parse(quiz['date']),
            quiz_theme: quiz['themes'],
            url: quiz['url']);
        quizes.add(q);
      });
      print(quizes);
      print(quizes.length);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Exception happened. See the full trace: \n$e");
    }
  }

  List<Widget> _subpages = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: [
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                      child: ListView(
                          children: quizes.map((e) {
                        return QuizCard(
                          id: e.id,
                          name: e.name,
                          description: e.description,
                          date: e.date,
                          theme: e.quiz_theme,
                          url: e.url,
                          currentUser: user,
                        );
                      }).toList()),
                      onRefresh: _refresh,
                    ),
              ProfilePage(user)
            ].elementAt(_selectedIndex)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Browse"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Account")
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Future<void> _refresh() {
    print('refreshing');
    quizes = [];
    users = [];
    fetchData();
    return Future.delayed(Duration(seconds: 1));
  }
}
