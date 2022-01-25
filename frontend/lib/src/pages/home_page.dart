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
  Random _random = Random();
  late List<QuizTheme> themePredicate;
  late DateTime datePredicate;
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
    themePredicate = ThemeFetch().themes;
    datePredicate = DateTime.now();
    datePredicate.add(const Duration(days: 365));
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
                                  icon: const Icon(Icons.filter_list))),
                          Expanded(
                            child: ListView(
                                children: quizes.map<Widget>((e) {
                              for (Map<String, dynamic> item in e.quiz_theme) {
                                QuizTheme _tmp = QuizTheme(
                                    id: item['id'], name: item['name']);
                                for (var item2 in themePredicate) {
                                  if (item2.id == _tmp.id) {
                                    if (e.date.isAfter(datePredicate))
                                      return QuizCard(
                                        id: e.id,
                                        name: e.name,
                                        description: e.description,
                                        date: e.date,
                                        theme: e.quiz_theme,
                                        url: e.url,
                                        currentUser: user,
                                      );
                                  }
                                }

                                return Container(
                                  width: 0,
                                  height: 0,
                                  child: Text(''),
                                );
                              }
                              return Container(
                                width: 0,
                                height: 0,
                                child: Text(''),
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
                    height: 300,
                    width: 300,
                    child: Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.white,
                          title: TabBar(indicatorColor: Colors.cyan, tabs: [
                            Text(
                              'theme',
                              style: const TextStyle(color: Colors.cyan),
                            ),
                            Text(
                              'date',
                              style: const TextStyle(color: Colors.cyan),
                            )
                          ]),
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
                                    bool _selected = false;
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 6),
                                      color: pasteleColors[_random
                                          .nextInt(pasteleColors.length)],
                                      child: FilterChip(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 3),
                                        selectedColor: Colors.amber,

                                        elevation: 10,
                                        selected: _selected,
                                        backgroundColor: Colors.transparent,
                                        // backgroundColor: pasteleColors[_random
                                        //     .nextInt(pasteleColors.length)],
                                        label: Text(element.name.toString()),
                                        onSelected: (bool selected) =>
                                            setState(() {
                                          filter(element);
                                          _selected = !_selected;
                                        }),
                                      ),
                                    );
                                  }).toList());
                                else
                                  return CircularProgressIndicator();
                              }),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 200,
                                child: TextButton.icon(
                                    onPressed: () => nearestDay(),
                                    icon: const Icon(Icons.upgrade),
                                    label: const Text("The nearest day")),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 200,
                                child: TextButton.icon(
                                    onPressed: () => atWeekend(),
                                    icon: Icon(Icons.upgrade),
                                    label: const Text('At weekend')),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 200,
                                child: TextButton.icon(
                                    onPressed: () => _selectDate(context),
                                    icon: Icon(Icons.calendar_today),
                                    label: Text("Pick a day")),
                              )
                            ],
                          )
                        ])),
                  )));
        });
  }

  filter(QuizTheme quiztheme) {
    setState(() {
      if (themePredicate
          .firstWhere((element) => element.id == quiztheme.id)
          .toString()
          .isNotEmpty)
        themePredicate.remove(
            themePredicate.firstWhere((element) => element.id == quiztheme.id));
      else
        themePredicate.add(quiztheme);
    });
  }

  nearestDay() {
    setState(() {
      datePredicate = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
    });
  }

  atWeekend() => setState(() {
        DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day - DateTime.now().weekday % 7);
      });

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2021, 3, 25), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != datePredicate) {
      setState(() {
        datePredicate = picked;
      });
    }
  }
}
