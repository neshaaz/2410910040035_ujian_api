import 'package:flutter/material.dart';
import '../helpers/api_service.dart';
import '../models/user_model.dart';
import 'todo_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ApiService api = ApiService();

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final ageCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  bool isLoading = false;

  InputDecoration _fieldStyle(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  void submit() async {
    // Validate form fields before submission
    if (firstNameCtrl.text.trim().isEmpty ||
        lastNameCtrl.text.trim().isEmpty ||
        ageCtrl.text.trim().isEmpty ||
        emailCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field harus diisi")),
      );
      return;
    }

    int? age;
    try {
      age = int.parse(ageCtrl.text.trim());
      if (age <= 0) {
        throw FormatException("Umur harus lebih dari 0");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Umur harus berupa angka yang valid")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      UserModel user = await api.registerUser(
        firstName: firstNameCtrl.text.trim(),
        lastName: lastNameCtrl.text.trim(),
        age: age,
        email: emailCtrl.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registrasi sukses! ID: ${user.id}")),
      );
      

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TodoPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registrasi gagal: ${e.toString()}")),
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffF6D6FF), Color(0xffD6E6FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 12,
                    color: Colors.black.withOpacity(0.1),
                  )
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Registrasi User",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6A4BBC),
                    ),
                  ),
                  const SizedBox(height: 20),

                  TextField(
                    controller: firstNameCtrl,
                    decoration: _fieldStyle("First Name"),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: lastNameCtrl,
                    decoration: _fieldStyle("Last Name"),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: ageCtrl,
                    keyboardType: TextInputType.number,
                    decoration: _fieldStyle("Age"),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: emailCtrl,
                    decoration: _fieldStyle("Email"),
                  ),
                  const SizedBox(height: 20),

                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6A4BBC),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: submit,
                          child: const Text(
                            "DAFTAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}