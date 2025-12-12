import 'dart:convert';

import 'package:quiz_api/models/todo_model.dart';
import 'package:quiz_api/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // REGISTER USER
  Future<UserModel> registerUser({
    required String firstName,
    required String lastName,
    required int age,
    required String email,
  }) async {
    // Validate inputs to prevent null values
    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
      throw Exception("Semua field harus diisi");
    }
    if (age <= 0) {
      throw Exception("Umur harus lebih dari 0");
    }

    // siapkan uri endpoint register
    var uri = Uri.parse("https://dummyjson.com/users/add");
    var respon = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "firstName": firstName.trim(),
        "lastName": lastName.trim(),
        "age": age,
        "email": email.trim(),
      }),
    );

    if (respon.statusCode == 200 || respon.statusCode == 201) {
      var data = jsonDecode(respon.body);
      return UserModel.fromMap(data);
    } else {
      throw Exception("Koneksi terganggu: ${respon.body}");
    }
  }

  // GET TODOS
  Future<List<TodoModel>> getTodos() async {
    // siapkan uri endpoint todos
    var uri = Uri.parse("https://dummyjson.com/todos");
    var respon = await http.get(uri);

    if (respon.statusCode == 200) {
      var data = jsonDecode(respon.body);
      List<dynamic> list = data["todos"] ?? [];
      return list.map((json) => TodoModel.fromMap(json)).toList();
    } else {
      throw Exception("Koneksi terganggu");
    }
  }
}