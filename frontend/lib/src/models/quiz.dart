import 'theme.dart';

class Quiz {
  int id;
  String name;
  String description;
  DateTime date;
  Theme theme;
  String url;
  Quiz({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.theme,
    required this.url,
  });
}
