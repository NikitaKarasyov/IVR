import 'quiz_theme.dart';

class Quiz {
  int id;
  String name;
  String description;
  DateTime date;
  List<dynamic> quiz_theme;
  String url;
  Quiz({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.quiz_theme,
    required this.url,
  });
}
