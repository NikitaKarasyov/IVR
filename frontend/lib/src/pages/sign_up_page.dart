import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/pages/home_page.dart';
import '../utils/fetch.dart';
import '../models/user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String email = "";
  String password = "";
  String confirmPassword = "";

  bool _obscureText = true;

  List<User> users = UserFetch().getAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 45, horizontal: 40),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("New here?"),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                            label: Text('username'),
                            fillColor: Colors.white54,
                            focusColor: Colors.cyan,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please, enter some text';
                          return null;
                        },
                        onChanged: (value) => username = value),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                            label: Text('email'),
                            fillColor: Colors.white54,
                            focusColor: Colors.cyan,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)))),
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please, enter some text';
                          return null;
                        },
                        onChanged: (value) => email = value),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            label: Text('password'),
                            fillColor: Colors.white54,
                            focusColor: Colors.cyan,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(Icons.visibility),
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
                        decoration: InputDecoration(
                            label: Text('confirm password'),
                            fillColor: Colors.white54,
                            focusColor: Colors.cyan,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
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
                      onPressed: () {
                        bool found = false;
                        for (var user in users) {
                          if (username == user.name) {
                            found = true;
                            SnackBar sb = SnackBar(
                                content:
                                    Text('this username was allready picked'));
                            ScaffoldMessenger.of(context).showSnackBar(sb);
                          }
                          if (email == user.email) {
                            found = true;
                            SnackBar sb = SnackBar(
                              content: Text('this email was allready picked'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(sb);
                          }
                        }
                        if (password == confirmPassword && !found) {
                          User new_user = User(
                              id: users.length,
                              name: username,
                              email: email,
                              password: password,
                              contact: "",
                              currentPoints: 0,
                              participating: [],
                              achievements: [],
                              points: []);
                          UserFetch().postUser(new_user);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage(new_user)));
                        }
                      },
                      child: Text('Sign up')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Back to Login'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
