import 'dart:async';

import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../constants/api.dart';
import 'dart:convert';

class UserFetch {
  // final User user = User.UserDefault();
  List<User> users = [];
  http.Response? response;
  UserFetch() {
    _fetchData();
  }

  getAll() => users;

  Future<List<User>> getAllAsync() async {
    List<User> _users = [];
    try {
      http.Response userResponse = await http.get(Uri.parse(api_users));
      var userData = json.decode(userResponse.body);
      userData.forEach((user) {
        User u = User(
          id: user['id'],
          name: user['name'],
          email: user['email'],
          password: user['password'],
          contact: user['contact'],
          currentPoints: user['current_points'],
          participating: user['participating'],
          achievements: user['achievements'],
          points: user['points'],
        );
        _users.add(u);
      });
    } catch (e) {
      print(e);
    }
    return _users;
  }

  _fetchData() async {
    try {
      http.Response userResponse = await http.get(Uri.parse(api_users));
      var userData = json.decode(userResponse.body);
      userData.forEach((user) {
        User u = User(
          id: user['id'],
          name: user['name'],
          email: user['email'],
          password: user['password'],
          contact: user['contact'],
          currentPoints: user['current_points'],
          participating: user['participating'],
          achievements: user['achievements'],
          points: user['points'],
        );
        users.add(u);
      });
    } catch (e) {
      print(e);
    }
  }

  correct(User input) async {
    try {
      http.Response response = await http.get(Uri.parse(api_users));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> postUser(User user) async {
    var endpoint = api_users;
    Map data = {};
    data['name'] = user.name;
    data['password'] = user.password;
    data['email'] = user.email;
    print(json.encode(data));
    try {
      var response = await http
          .post(Uri.parse(endpoint), body: json.encode(data), headers: {
        "Content-Type": "application/json",
        "Authorization": "TOKEN 8b220811a6b2cfe4bfe129bbce2c55c5cb014fda"
      });
      print(response.headers);
      // print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<void> putUser(int id) async {
    final UserFetch uf = UserFetch();
    List<User> temp_users = uf.getAll();
    var endpoint = api_users;

    users.forEach((element) {
      element.output();
    });
    var data = temp_users[id].getData();
    print(json.encode(data));
    try {
      var response = await http
          .put(Uri.parse(api_users), body: json.encode(data), headers: {
        "Content-Type": "application/json",
        "Authorization": "TOKEN 8b220811a6b2cfe4bfe129bbce2c55c5cb014fda"
      });
    } catch (e) {
      print(e);
    }
  }

  sortByPoints(List<User> tmp_users) =>
      tmp_users.sort((a, b) => a.currentPoints.compareTo(b.currentPoints));
}
