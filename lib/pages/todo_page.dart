import 'package:flutter/material.dart';
import '../helpers/api_service.dart';
import '../models/todo_model.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final ApiService api = ApiService();
  bool isLoading = true;
  List<TodoModel> todos = [];

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  void loadTodos() async {
    try {
      todos = await api.getTodos();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal memuat todo")),
      );
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1EEFF),

      appBar: AppBar(
        backgroundColor: const Color(0xff6A4BBC),
        elevation: 0,
        title: const Text("Todo List"),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: todos.length,
              itemBuilder: (_, i) {
                final todo = todos[i];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black.withOpacity(0.05),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        todo.todo,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xff333333),
                        ),
                      )),
                      Icon(
                        todo.completed
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color:
                            todo.completed ? Colors.green : Colors.grey.shade500,
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}