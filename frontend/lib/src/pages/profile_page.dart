import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/src/constants/api.dart';
import 'package:frontend/src/utils/fetch.dart';
import 'package:http/http.dart' as http;
import '../widgets/sum_points.dart';
import '../widgets/point_last_week.dart';
import '../widgets/rating.dart';
import '../models/user.dart';

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
          _userStatsPoints()
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
