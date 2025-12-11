import 'dart:convert';

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final int age;
  final String email;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.email,
  });

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    int? age,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      age: map['age']?.toInt() ?? 0,
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, age: $age, email: $email)';
  }

}
