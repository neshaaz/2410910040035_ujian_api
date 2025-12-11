import 'dart:convert';

import 'package:quiz_api/models/todo_model.dart';
import 'package:quiz_api/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // REGISTER US
  Future<UserModel> registerUser({
    required String firstName,
    required String lastName,
    required int age,
    required String email,
  }) async {
    final url = Uri.parse("https://dummyjson.com/users/add");

    print("REGISTER URL: $url"); // debug check

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "firstName": firstName,
        "lastName": lastName,
        "age": age,
        "email": email,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Gagal register: ${response.body}");
    }
  }

  // GET TODOS
  Future<List<TodoModel>> getTodos() async {
    final url = Uri.parse("https://dummyjson.com/todos");

    print("TODO URL: $url"); // debug check

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List list = data["todos"];
      return list.map((e) => TodoModel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal load todos");
    }
  }
}