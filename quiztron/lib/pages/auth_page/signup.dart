import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiztron/env.dart';
import 'package:quiztron/models/achievement.dart';
import 'package:quiztron/models/quiz.dart';
import 'package:quiztron/models/user.dart';
import 'package:quiztron/pages/profile_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  void pushdata(User user) async {
    try {
      final response = await http.post(Uri.parse("${Env.URL_PREFIX}/users/"),
          body: user.toJson());

      print(response.body);
    } catch (er) {}
  }

  @override
  Widget build(BuildContext context) {
    String username = "";
    String password = "";
    String contact_data = "";
    String email = "";
    String repeat_password = "don't thread on me";
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "Repeat password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32))),
                      suffixIcon: Icon(Icons.account_circle)),
                  onChanged: (content) => repeat_password = content),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32))),
                      suffixIcon: Icon(Icons.account_circle)),
                  onChanged: (content) => email = content),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "other contacts (like telegram, etc.)",
                      hintText: "it's not neccessary",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32))),
                      suffixIcon: Icon(Icons.account_circle)),
                  onChanged: (content) => contact_data = content),
              SizedBox(
                height: 15,
              ),
              OutlinedButton.icon(
                  onPressed: () {
                    User instance = new User(
                        id: 1000 + DateTime.now().day,
                        username: username,
                        participating: List<Quiz>.empty(),
                        achievements: List<Achievement>.empty(),
                        curPoints: 0,
                        points: List<int>.empty(),
                        password: password,
                        email: email,
                        contact: contact_data);
                    pushdata(instance);
                    if (username != "" &&
                        password != "" &&
                        password == repeat_password) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else if (repeat_password != password) {
                      final SnackBar sb = SnackBar(
                          content: const Text("passwords don't match"));
                      ScaffoldMessenger.of(context).showSnackBar(sb);
                    }
                  },
                  icon: Icon(
                    Icons.login_rounded,
                    size: 18,
                  ),
                  label: Text("Login"))
            ],
          ),
        ),
      ),
    ));
  }
}
