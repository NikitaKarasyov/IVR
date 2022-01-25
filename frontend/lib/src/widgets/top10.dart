import 'package:flutter/material.dart';

import '../models/user.dart';
import '../utils/fetch.dart';

class TopTen extends StatefulWidget {
  final User user;
  final List<User> users;
  const TopTen({
    Key? key,
    required this.user,
    required this.users,
  }) : super(key: key);

  @override
  _TopTenState createState() => _TopTenState();
}

class _TopTenState extends State<TopTen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: ListView(
            shrinkWrap: true,
            children: widget.users
                .map<Widget>(
                  (element) => Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        element.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                )
                .toList()));
  }
}
