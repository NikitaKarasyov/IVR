import 'package:flutter/material.dart';
import 'package:frontend/src/constants/api.dart';

import '../widgets/theme_chip.dart';
import '../utils/to_normal_date.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class QuizCard extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final DateTime date;
  final List<dynamic> theme;
  final String url;
  // final User currentUser;
  const QuizCard(
      {Key? key,
      required this.id,
      required this.name,
      required this.description,
      required this.date,
      required this.theme,
      // required this.currentUser,
      required this.url})
      : super(key: key);

  // void liked(int quiz_id, User currentUser) async {
  //   try {
  //     http.Response response = await http.(Uri.parse(api_quizes));
  //   } catch (e) {}
  // }

  List<Widget> generateThemeWrap() {
    List<Widget> chips = [];
    theme.forEach((element) {
      print(element.toString());
      chips.add(ThemeChip(name: element['name']));
    });
    return chips;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.cyan,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            Text(toNormal(date).toLocal().toString().substring(5, 16)),
            Text(
              description,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: generateThemeWrap(),
              crossAxisAlignment: WrapCrossAlignment.end,
            ),
            Divider(
              color: Colors.accents.first,
            ),
            TextButton.icon(
                style: ButtonStyle(),
                onPressed: null,
                icon: Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                ),
                label: Text("Join"))
          ],
        ),
      ),
    );
  }
}
