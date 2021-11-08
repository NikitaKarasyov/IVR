import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_icons/flutter_icons.dart';
import 'package:quiztron/env.dart';
import 'package:quiztron/models/user.dart';
import 'package:quiztron/pages/home_page.dart';
import 'package:quiztron/pages/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart' as sp;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  var _users = [];
  void getUserList() async {
    try {
      final response = await http.get(Uri.parse("${Env.URL_PREFIX}/users/"));
      final jsondata = json.decode(response.body) as List;
      setState(() {
        _users = jsondata;
      });
    } catch (err) {
      print("failed to fetch list of users");
      throw err;
    }
  }

  void _setid(User user) async {
    final sp.SharedPreferences prefs = await sp.SharedPreferences.getInstance();
    prefs.setInt("id", user.id);
  }

  @override
  Widget build(BuildContext context) {
    String username = "";
    String password = "";
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("quiztron", style: const TextStyle(color: Color(0xFF5670))),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32))),
                      suffixIcon: Icon(Icons.account_circle)),
                  onChanged: (content) => username = content),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32))),
                    suffixIcon: Icon(Icons.password)),
                onChanged: (content) => password = content,
              ),
              SizedBox(
                height: 45,
              ),
              OutlinedButton.icon(
                  onPressed: () {
                    // if (username == _users[i].username) {
                    //   if (password == _users[i].password) {
                    // _setid(_users[]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  },
                  // final SnackBar sb = SnackBar(
                  //     content: const Text("wrong password or username"));
                  // ScaffoldMessenger.of(context).showSnackBar(sb);
                  //   }
                  // }

                  icon: Icon(
                    Icons.login_rounded,
                    size: 18,
                  ),
                  label: Text("Login")),
              Text(
                "are you new here",
                style:
                    TextStyle(color: Colors.cyan, fontStyle: FontStyle.italic),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
