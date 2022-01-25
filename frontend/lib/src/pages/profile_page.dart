import 'dart:convert';
import '../widgets/top10.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:frontend/src/constants/api.dart';
import 'package:frontend/src/models/achievement.dart';
import 'package:frontend/src/models/quiz.dart';
import 'package:frontend/src/utils/fetch.dart';

import '../models/user.dart';
import '../widgets/point_last_week.dart';
import '../widgets/rating.dart';
import '../widgets/sum_points.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage(this.user, {Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState(user);
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState(this.user);
  User user;
  late ScrollController _controller;
  final UserFetch userfetchInstance = UserFetch();
  late List<User> users;
  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    users = userfetchInstance.getAll();
    _controller.addListener(_scrollListener); //the listener for up and down.
    super.initState();
  }

  List<double> getDoubles(list) {
    List<double> ans = [];
    list.cast<List<Map<String, double>>>();
    for (var item in list) {
      ans.add(double.parse(item['value'].toString()));
    }
    return ans;
  }

  Widget _userStatsPoints() {
    users = userfetchInstance.getAll();
    return ListView(
      controller: _controller,
      shrinkWrap: true,
      children: [
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: 2,
          shrinkWrap: true,
          children: [
            SizedBox(
                width: 100, height: 100, child: AllPoints(user.currentPoints)),
            SizedBox(width: 100, height: 100, child: CustomRating(user.id)),
            //todo: implement something more
          ],
        ),
        PointWeek(getDoubles(user.points)),
        // Flexible(child: child)
        // TopTen(user: user, users: users),
        Text('Top 10: ', style: TextStyle(fontSize: 30)),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("test13",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("test12",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("test1",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("test3",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "test2",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("test8",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("test10",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("test4",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("test5",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("admin",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22)),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: ListView(
        children: [
          Container(
              alignment: Alignment.centerRight,
              child: Ink(
                  decoration: const ShapeDecoration(
                      shape: CircleBorder(), color: Colors.cyan),
                  child: IconButton(
                      splashColor: Colors.grey,
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              CustomAlertDialog()),
                      icon: const Icon(Icons.edit),
                      color: Colors.white))),
          Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 4),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4), color: Colors.amber),
              width: double.infinity,
              padding: EdgeInsets.only(left: 10),
              child: Text(
                user.name,
                style: const TextStyle(fontSize: 42),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.amber[200]),
                child: Text(
                  user.email,
                  style: const TextStyle(fontSize: 20),
                )),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: user.contact.isEmpty
                  ? TextButton(
                      onPressed: null,
                      child: Text(
                        'Add contact info',
                        style: const TextStyle(color: Colors.cyan),
                      ),
                      style: ButtonStyle(
                          // backgroundColor: (Colors.grey[200])!,
                          ))
                  : Text(user.contact)),
          Divider(),
          _userStatsPoints(),
          AchievementsList(
            achievements: user.achievements,
          ),
          user.participating.isEmpty
              ? const Text(
                  'nothing in histrory, join a quiz and have fun, friend😃')
              : QuizHistory(
                  user: user,
                ),
        ],
      ),
    ));
  }

  AlertDialog CustomAlertDialog() {
    bool _obscureText = false;
    String username = user.name;
    String email = user.email;
    String confirmPassword = user.password;
    String password = user.password;
    return AlertDialog(
      title: Text('edit personal data'),
      content: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                  obscureText: _obscureText,
                  initialValue: username,
                  decoration: InputDecoration(
                    label: const Text('username'),
                    fillColor: Colors.white54,
                    focusColor: Colors.cyan,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(8))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please, enter some text';
                    return null;
                  },
                  onChanged: (value) => setState(() => username = value)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                  obscureText: _obscureText,
                  initialValue: email,
                  decoration: InputDecoration(
                    label: Text('email'),
                    fillColor: Colors.white54,
                    focusColor: Colors.cyan,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please, enter some text';
                    return null;
                  },
                  onChanged: (value) => setState(() => email = value)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                  obscureText: _obscureText,
                  initialValue: password,
                  decoration: InputDecoration(
                      label: Text('password'),
                      fillColor: Colors.white54,
                      focusColor: Colors.cyan,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () => setState(() {
                          _obscureText = !_obscureText;
                        }),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please, enter some text';
                    return null;
                  },
                  onChanged: (value) => password = value),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                  obscureText: _obscureText,
                  initialValue: confirmPassword,
                  decoration: InputDecoration(
                      label: Text('confirm password'),
                      fillColor: Colors.white54,
                      focusColor: Colors.cyan,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () => setState(() {
                          _obscureText = !_obscureText;
                        }),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please, enter some text';
                    return null;
                  },
                  onChanged: (value) => confirmPassword = value),
            ),
            TextButton(
                onPressed: () async {
                  users = userfetchInstance.getAll();
                  String endpoint = api_users;
                  users.forEach((element) {
                    element.output();
                  });
                  int finding_index = 0;
                  for (var item in users) {
                    finding_index += 1;
                    if (item.name == user.name) break;
                  }
                  var data = User(
                          id: finding_index - 1,
                          name: username,
                          email: email,
                          password: password,
                          contact: users[finding_index - 1].contact,
                          currentPoints: users[finding_index - 1].currentPoints,
                          participating: users[finding_index - 1].participating,
                          achievements: users[finding_index - 1].achievements,
                          points: users[finding_index - 1].points)
                      .getData();
                  try {
                    var response = await http.put(
                        Uri.parse(api_users + user.id.toString() + '/'),
                        body: json.encode(data),
                        headers: {
                          "Content-Type": "application/json",
                          "Authorization":
                              "TOKEN 8b220811a6b2cfe4bfe129bbce2c55c5cb014fda"
                        });
                    print(response.headers);
                    print(response.body);
                  } catch (e) {
                    print(e);
                  }
                  // Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => super.widget));
                  setState(() {
                    user.name = username;
                    user.email = email;
                  });
                  Navigator.of(context).pop();
                },
                child: Text("Accept"))
          ],
        ),
      ),
    );
  }
}

class AchievementsList extends StatefulWidget {
  final List achievements;
  const AchievementsList({
    Key? key,
    required this.achievements,
  }) : super(key: key);

  @override
  _AchievementsListState createState() => _AchievementsListState();
}

class _AchievementsListState extends State<AchievementsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: widget.achievements.length == 1
            ? Card(
                color: Colors.grey.shade200,
                child: Column(
                  children: [
                    Text(widget.achievements.first['name'],
                        style: const TextStyle(
                          fontSize: 20,
                        )),
                    Text(widget.achievements.first['description'],
                        style: const TextStyle(
                          fontSize: 15,
                        ))
                  ],
                ),
              )
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                shrinkWrap: true,
                itemBuilder: (context, index) => _achievementItem(index),
                itemCount: widget.achievements.length,
              ));
  }

  _achievementItem(int index) => SizedBox(
        width: 100,
        height: 100,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(8),
        //     border: Border(
        //         left: BorderSide(
        //           color: Colors.cyan,
        //         ),
        //         right: BorderSide(color: Colors.amber))),
        child: Card(
            color: Colors.grey.shade200,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.achievements[index]['name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Text(widget.achievements[index]['description'],
                      style: TextStyle(fontSize: 15))
                ])),
      );
}

class QuizHistory extends StatefulWidget {
  final User user;
  const QuizHistory({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _QuizHistoryState createState() => _QuizHistoryState();
}

class _QuizHistoryState extends State<QuizHistory> {
  List _filter() {
    List obj = [];
    for (var item in widget.user.participating) {
      if (DateTime.parse(item['date']).compareTo(DateTime.now()) < 0)
        obj.add(item);
    }
    return obj;
  }

  @override
  Widget build(BuildContext context) {
    List obj = _filter();
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: obj.length,
        itemBuilder: (context, index) => _genCard(obj, index));
  }

  _genCard(List obj, int index) => Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.only(top: 10),
        child: Card(
            color: Colors.cyan,
            child: Column(
              children: [
                Text(
                  obj[index]['name'],
                  style: const TextStyle(color: Colors.white),
                ),
                Divider(color: Colors.white),
                Text(
                  obj[index]['description'],
                  style: const TextStyle(color: Colors.white),
                ),
                Divider(color: Colors.white),
                Text(
                  'Team: ',
                  style: const TextStyle(color: Colors.white),
                ),
                //todo: add team to history
                // Wrap(children: List.generate(, (index) => null),),
              ],
            )),
      );
}
