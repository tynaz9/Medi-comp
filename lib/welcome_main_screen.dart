import 'package:flutter/material.dart';
import 'input_screen.dart';

class WelcomeMainScreen extends StatelessWidget {
  const WelcomeMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(
                  'https://static.vecteezy.com/system/resources/thumbnails/000/545/277/small/BmiWord.jpg',
                ),
                backgroundColor: Colors.transparent,
              ),

              const SizedBox(height: 5),

             
              const Text(
                "BMI Calculator",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Text(
                  "Welcome to BMI Calculator, your personal tool for tracking your Body Mass Index (BMI) and monitoring your health.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const InputScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "START",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}