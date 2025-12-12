import 'dart:convert';

class TodoModel {
  final int id;
  final String todo;
  final bool completed;
  final int userId;

  TodoModel({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  TodoModel copyWith({
    int? id,
    String? todo,
    bool? completed,
    int? userId,
  }) {
    return TodoModel(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      completed: completed ?? this.completed,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] is int ? map['id'] : (map['id'] is num ? (map['id'] as num).toInt() : 0),
      todo: map['todo']?.toString() ?? '',
      completed: map['completed'] is bool ? map['completed'] : false,
      userId: map['userId'] is int ? map['userId'] : (map['userId'] is num ? (map['userId'] as num).toInt() : 0),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TodoModel(id: $id, todo: $todo, completed: $completed, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TodoModel &&
      other.id == id &&
      other.todo == todo &&
      other.completed == completed &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      todo.hashCode ^
      completed.hashCode ^
      userId.hashCode;
  }
}
