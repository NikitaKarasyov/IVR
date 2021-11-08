import 'package:flutter/material.dart';
import 'package:quiztron/pages/profile_page.dart';
import 'pages/auth_page/login.dart';

main(List<String> args) => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      title: 'quiztron',
    );
  }
}
