import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:f_medi_minders/landing_page/landing_screen.dart'; // your home screen

class NameSetupScreen extends StatefulWidget {
  const NameSetupScreen({super.key});

  @override
  State<NameSetupScreen> createState() => _NameSetupScreenState();
}

class _NameSetupScreenState extends State<NameSetupScreen> {
  final TextEditingController _controller = TextEditingController();

  Future<void> saveName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", _controller.text.trim());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LandingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to Medi Minder",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: "Enter your name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveName,
                child: const Text("Continue"),
              )
            ],
          ),
        ),
      ),
    );
  }
}