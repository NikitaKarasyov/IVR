import 'dart:convert';

class Achievement {
  int id;
  String name;
  String description;
  Achievement({
    required this.id,
    required this.name,
    required this.description,
  });

  Achievement copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return Achievement(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Achievement.fromMap(Map<String, dynamic> map) {
    return Achievement(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Achievement.fromJson(String source) => Achievement.fromMap(json.decode(source));

  @override
  String toString() => 'Achievement(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Achievement &&
      other.id == id &&
      other.name == name &&
      other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
