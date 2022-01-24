import 'package:flutter/material.dart';
import 'package:frontend/src/pages/home_page.dart';
import '../models/user.dart';
import '../utils/fetch.dart';
import 'sign_up_page.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter_svg/svg.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final userfetchInstance = UserFetch();
  String username = "";
  String password = "";
  List<User>? users;
  @override
  Widget build(BuildContext context) {
    users = userfetchInstance.getAll();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Stack(children: [
            SvgPicture.asset(
              "assets/auth/layered-waves-haikei.svg",
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 45, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Welcome to quiztron!",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                              label: Text("password"),
                              fillColor: Colors.white54,
                              focusColor: Colors.cyan,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)))),
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Please, enter password';
                            return null;
                          },
                          onChanged: (value) => password = value,
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  bool found = false;
                                  print('username value:  $username');
                                  print('password value: $password');
                                  for (var item in users!) {
                                    item.output();
                                  }
                                  for (var user in users!) {
                                    if (username == user.name &&
                                        password == user.password &&
                                        _formKey.currentState!.validate()) {
                                      found = true;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage(user)));
                                    }
                                  }
                                  if (!found) {
                                    SnackBar sb = SnackBar(
                                      content: Text('invalid credentials'),
                                      backgroundColor: Colors.amber,
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(sb);
                                  }
                                },
                                child: Text("Sign in")),
                            TextButton(
                                onPressed: () => Navigator.push<void>(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage())),
                                child: Text("Sign up"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  sign_in(GlobalKey<FormState> key) {
    bool found = false;

    for (var user in users!) {
      if (username == user.name &&
          password == user.password &&
          key.currentState!.validate()) {
        found = true;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage(user)));
      }
    }
    if (!found) {
      SnackBar sb = SnackBar(
        content: Text('invalid credentials'),
        backgroundColor: Colors.amber,
      );
      ScaffoldMessenger.of(context).showSnackBar(sb);
    }
    // if (!key.currentState!.validate()) {
    //   SnackBar sb = SnackBar(
    //     content: Text('Please enter some text'),
    //     backgroundColor: Colors.amber,
    //   );
    //   ScaffoldMessenger.of(context).showSnackBar(sb);
    // }
  }
}
