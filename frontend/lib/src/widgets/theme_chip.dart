import 'package:flutter/material.dart';

import '../models/quiz_theme.dart';

class ThemeChip extends StatelessWidget {
  final String name;
  final Color color = Colors.deepOrange;
  ThemeChip({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color,
      label: Text(
        name,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
      ),
    );
  }
}
