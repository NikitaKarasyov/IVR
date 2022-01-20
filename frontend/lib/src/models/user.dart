import 'achievement.dart';
import 'point.dart';
import 'quiz.dart';

class User {
  int id;
  String name;
  String email;
  String password;
  String contact;
  int currentPoints;
  List<dynamic> participating;
  List<dynamic> achievements;
  List<dynamic> points;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.contact,
    required this.currentPoints,
    required this.participating,
    required this.achievements,
    required this.points,
  });
}
