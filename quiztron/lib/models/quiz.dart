import 'dart:convert';

import 'package:collection/collection.dart';

class Quiz {
  int id;
  String name;
  DateTime date;
  String description;
  String url;
  List<QuizTheme> themes;
  Quiz({
    required this.id,
    required this.name,
    required this.date,
    required this.description,
    required this.url,
    required this.themes,
  });
    

  Quiz copyWith({
    int? id,
    String? name,
    DateTime? date,
    String? description,
    String? url,
    List<QuizTheme>? themes,
  }) {
    return Quiz(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      description: description ?? this.description,
      url: url ?? this.url,
      themes: themes ?? this.themes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date.millisecondsSinceEpoch,
      'description': description,
      'url': url,
      'themes': themes.map((x) => x.toMap()).toList(),
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'],
      name: map['name'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      description: map['description'],
      url: map['url'],
      themes: List<QuizTheme>.from(map['themes']?.map((x) => QuizTheme.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Quiz.fromJson(String source) => Quiz.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Quiz(id: $id, name: $name, date: $date, description: $description, url: $url, themes: $themes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return other is Quiz &&
      other.id == id &&
      other.name == name &&
      other.date == date &&
      other.description == description &&
      other.url == url &&
      listEquals(other.themes, themes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      date.hashCode ^
      description.hashCode ^
      url.hashCode ^
      themes.hashCode;
  }
}


class QuizTheme {
  int id;
  String name;
  QuizTheme({
    required this.id,
    required this.name,
  });

  QuizTheme copyWith({
    int? id,
    String? name,
  }) {
    return QuizTheme(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory QuizTheme.fromMap(Map<String, dynamic> map) {
    return QuizTheme(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizTheme.fromJson(String source) => QuizTheme.fromMap(json.decode(source));

  @override
  String toString() => 'QuizTheme(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is QuizTheme &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
