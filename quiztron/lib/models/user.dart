import 'dart:convert';

import 'package:collection/collection.dart';

import 'achievement.dart';
import 'quiz.dart';

class User {
  int id;
  String username;
  String password;
  int curPoints;
  List<int> points;
  String email;
  String contact;
  List<Achievement> achievements;
  List<Quiz> participating;
  User({
    required this.id,
    required this.username,
    required this.password,
    required this.curPoints,
    required this.points,
    required this.email,
    required this.contact,
    required this.achievements,
    required this.participating,
  });

  User copyWith({
    int? id,
    String? username,
    String? password,
    int? curPoints,
    List<int>? points,
    String? email,
    String? contact,
    List<Achievement>? achievements,
    List<Quiz>? participating,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      curPoints: curPoints ?? this.curPoints,
      points: points ?? this.points,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      achievements: achievements ?? this.achievements,
      participating: participating ?? this.participating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'curPoints': curPoints,
      'points': points,
      'email': email,
      'contact': contact,
      'achievements': achievements.map((x) => x.toMap()).toList(),
      'participating': participating.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      curPoints: map['curPoints'],
      points: List<int>.from(map['points']),
      email: map['email'],
      contact: map['contact'],
      achievements: List<Achievement>.from(map['achievements']?.map((x) => Achievement.fromMap(x))),
      participating: List<Quiz>.from(map['participating']?.map((x) => Quiz.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, username: $username, password: $password, curPoints: $curPoints, points: $points, email: $email, contact: $contact, achievements: $achievements, participating: $participating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is User &&
      other.id == id &&
      other.username == username &&
      other.password == password &&
      other.curPoints == curPoints &&
      listEquals(other.points, points) &&
      other.email == email &&
      other.contact == contact &&
      listEquals(other.achievements, achievements) &&
      listEquals(other.participating, participating);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      username.hashCode ^
      password.hashCode ^
      curPoints.hashCode ^
      points.hashCode ^
      email.hashCode ^
      contact.hashCode ^
      achievements.hashCode ^
      participating.hashCode;
  }
}