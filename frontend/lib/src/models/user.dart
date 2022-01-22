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

  static User UserDefault() => User(
      id: 0,
      name: "",
      email: "",
      password: "",
      contact: "",
      currentPoints: 0,
      participating: [],
      achievements: [],
      points: []);

  output() {
    print('id $id');
    print('name $name');
    print('password $password');
    print('email $email');
    print('contact $contact');
    print('current points $currentPoints');
    print('achievements $achievements');
    print('points ${points.runtimeType}');
    print('participating $participating');
  }

  getData() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "contact": contact,
      "current_points": currentPoints,
      "achievements": achievements,
      "points": points,
      "participating": participating
    };
  }
}
