import 'package:flutter/material.dart';
import 'package:frontend/src/pages/login_page.dart';
import 'pages/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, title: 'Quiztron', home: AuthPage());
  }
}
