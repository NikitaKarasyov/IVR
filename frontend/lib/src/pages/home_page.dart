import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/src/models/quiz.dart';
import 'package:frontend/src/models/quiz_theme.dart';
import 'package:frontend/src/utils/fetch.dart';
import 'package:frontend/src/widgets/quiz_filter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pastele.dart';
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
  // late TabController _controller;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _HomePageState(this.user);
  void fetchData() async {
    try {
      http.Response quizResponse = await http.get(Uri.parse(api_quizes));
      var quizData = json.decode(utf8.decode(quizResponse.bodyBytes));
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
    // _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
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
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  onPressed: () => _show(),
                                  icon: Icon(Icons.filter_list))),
                          Expanded(
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
                          ),
                        ],
                      ),
                      onRefresh: _refresh,
                    ),
              // ),
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

  _show() {
    Future<List<QuizTheme>> themes = Future.sync(() => ThemeFetch().themes);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
              child: DefaultTabController(
                  length: 2,
                  child: SizedBox(
                    height: 600,
                    width: 300,
                    child: Scaffold(
                        appBar: AppBar(
                          bottom: TabBar(tabs: [Text('theme'), Text('date')]),
                        ),
                        body: TabBarView(children: [
                          FutureBuilder<List<QuizTheme>>(
                              future: themes,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.connectionState ==
                                        ConnectionState.done)
                                  return Wrap(
                                      children:
                                          snapshot.data.map<Widget>((element) {
                                    return FilterChip(
                                      backgroundColor: colors[
                                          Random().nextInt(colors.length)],
                                      label: Text(element.name.toString()),
                                      onSelected: (value) => null,
                                    );
                                  }).toList());
                                else
                                  return CircularProgressIndicator();
                              }),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              TextButton.icon(
                                  onPressed: null,
                                  icon: const Icon(Icons.date_range),
                                  label: const Text("The nearest day")),
                              TextButton.icon(
                                  onPressed: null,
                                  icon: Icon(Icons.date_range),
                                  label: const Text('At weekend')),
                              TextButton.icon(
                                  onPressed: () => showTimePicker(
                                      context: context,
                                      initialTime:
                                          TimeOfDay(hour: 4, minute: 20),
                                      initialEntryMode:
                                          TimePickerEntryMode.input),
                                  icon: Icon(Icons.calendar_today),
                                  label: Text("Pick a day"))
                            ],
                          )
                        ])),
                  )));
        });
  }
}
