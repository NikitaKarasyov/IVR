import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:frontend/src/models/QuizOfUser.dart';
import 'package:frontend/src/models/quiz_theme.dart';

import '../constants/api.dart';
import '../models/quiz.dart';
import '../models/user.dart';

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
      http.Response userResponse =
          await http.get(Uri.parse(api_users), headers: {
        // HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
        // 'Accept-Encoding': 'utf-8'
      });
      var userData = json.decode(utf8.decode(userResponse.bodyBytes));
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
      http.Response userResponse =
          await http.get(Uri.parse(api_users), headers: {
        // HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8 ',
        // 'Accept-Encoding': 'urf-8'
      });
      var userData = json.decode(utf8.decode(userResponse.bodyBytes));
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
      // headers: {'Content-Type': 'application/json; charset=utf-8'});
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
        // "Content-Type": "application/json; charset=utf-8",
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
        // "Content-Type": "application/json; ; charset=utf-8",
        "Authorization": "TOKEN 8b220811a6b2cfe4bfe129bbce2c55c5cb014fda"
      });
    } catch (e) {
      print(e);
    }
  }

  sortByPoints(List<User> tmp_users) =>
      tmp_users.sort((a, b) => a.currentPoints.compareTo(b.currentPoints));
}

class QuizOfUserFetch {
  List<QuizOfUser> qof = [];

  QuizOfUserFetch() {
    fetchQOF();
  }

  fetchQOF() async {
    try {
      http.Response response =
          await http.get(Uri.parse(api_quizOfUser), headers: {
        HttpHeaders.contentTypeHeader: 'application/json; ; charset=utf-8',
        'Accept-Encoding': 'utf-8',
      });
      // print(
      // '---------- RESPONSE [fetchQOF]: ${utf8.decode(response.bodyBytes).toString()}');
      var data = json.decode(utf8.decode(response.bodyBytes));
      for (var item in data) {
        print('item: $item');
        qof.add(QuizOfUser(
            quiz_id: item["quiz"], user_id: item["user"], id: item["id"]));
      }
    } catch (e) {
      print("fetchQOF error");
      print(e);
    }
  }

  postQOF(QuizOfUser obj) async {
    try {
      Map data = {'id': obj.id, 'user': obj.user_id, 'quiz': obj.quiz_id};
      http.Response response = await http.post(Uri.parse(api_quizOfUser),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json;  charset=utf-8",
            "Authorization": "TOKEN 8b220811a6b2cfe4bfe129bbce2c55c5cb014fda"
          },
          body: json.encode(data));
    } catch (e) {
      print("postQOF error");
      print(e);
    }
  }

  deleteQOF(QuizOfUser obj) async {
    try {
      Map data = {'id': obj.id, 'user': obj.user_id, 'quiz': obj.quiz_id};
      http.Response response =
          await http.delete(Uri.parse(api_quizOfUser + obj.id.toString() + "/"),
              headers: {
                "Content-Type": "application/json; charset=utf-8",
                "Authorization":
                    "TOKEN 8b220811a6b2cfe4bfe129bbce2c55c5cb014fda"
              },
              body: json.encode(data));
    } catch (e) {
      print(e);
    }
  }

  Future<List<QuizOfUser>> getallAsync() async {
    List<QuizOfUser> _qof = [];
    try {
      http.Response response =
          await http.get(Uri.parse(api_quizOfUser), headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      });
      print('---------- RESPONSE [getAllAsync]: ${response.toString()})');
      for (var item in json.decode(utf8.decode(response.bodyBytes))) {
        print('item: $item');
        _qof.add(QuizOfUser(
            id: item['id'], quiz_id: item['quiz'], user_id: item['quiz']));
      }
    } catch (e) {
      print("getAllAsync() [qof] error");
      print(e);
    }

    return _qof;
  }
}

class ThemeFetch {
  List<QuizTheme> themes = [];
  ThemeFetch() {
    _fetchAll();
  }

  _fetchAll() async {
    try {
      http.Response response = await http.get(Uri.parse(api_themes),
          headers: {'Content-type': 'application/json; charset=utf-8'});
      var data = json.decode(utf8.decode(response.bodyBytes));
      for (var item in data) {
        print('item of data of _fetchAll [ThemeFetch] $item');
        themes.add(QuizTheme(id: item['id'], name: item['name']));
      }
    } catch (e) {
      print("_fetchAll [ThemeFetch] error: ");
      print(e);
    }
  }
}
