import 'package:f_medi_minders/welcome_main_screen.dart';
//import 'package:f_medi_minders/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'result_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  bool isMale = true;
  int height = 161;
  int weight = 60;
  int age = 29;

  final Color lightBlue = const Color(0xFFD6F0FA); // light blue color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ✅ Back Button
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => WelcomeMainScreen()),
                    );
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),

                const SizedBox(height: 20),

                /// ✅ Title
                const Text(
                  "BMI Calculator",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 20),

                /// ✅ Gender Selection
                Row(
                  children: [
                    Expanded(child: genderCard(Icons.male, "Male", true)),
                    const SizedBox(width: 10),
                    Expanded(child: genderCard(Icons.female, "Female", false)),
                  ],
                ),

                const SizedBox(height: 20),

                /// ✅ Height Picker (cm + ft/in)
                Card(
                  color: lightBlue,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    child: Column(
                      children: [
                        const Text(
                          "Height",
                          style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 120,
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: height - 60),
                            itemExtent: 32.0,
                            onSelectedItemChanged: (index) {
                              setState(() {
                                height = 60 + index;
                              });
                            },
                            children: List<Widget>.generate(161, (index) {
                              int cmValue = 60 + index;
                              double totalInches = cmValue / 2.54;
                              int feet = totalInches ~/ 12;
                              int inches = (totalInches % 12).round();

                              return Center(
                                  child: Text(
                                      "$cmValue cm  ($feet ft $inches in)",
                                      style: const TextStyle(fontSize: 16)));
                            }),
                          ),
                        ),
                        Text(
                          "Selected Height: $height cm  (${(height / 30.48).toStringAsFixed(2)} ft)",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                /// ✅ Weight & Age
                Row(
                  children: [
                    Expanded(
                      child: cardValueBox(
                        "Weight",
                        weight,
                        "kg",
                        () => setState(() => weight++),
                        () => setState(() {
                          if (weight > 1) weight--;
                        }),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: cardValueBox(
                        "Age",
                        age,
                        "years",
                        () => setState(() => age++),
                        () => setState(() {
                          if (age > 1) age--;
                        }),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// ✅ Calculate BMI Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      double bmi = weight / ((height / 100) * (height / 100));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ResultScreen(
                            bmi: bmi,
                            height: height,
                            weight: weight,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(" Calculate BMI",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ Gender card widget
  Widget genderCard(IconData icon, String label, bool maleOption) {
    bool isSelected = isMale == maleOption;
    return GestureDetector(
      onTap: () => setState(() => isMale = maleOption),
      child: Card(
        elevation: isSelected ? 8 : 3,
        color: isSelected ? Colors.blue[100] : lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: isSelected
              ? const BorderSide(color: Colors.blue, width: 2)
              : BorderSide.none,
        ),
        child: SizedBox(
          height: 100,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon,
                    size: 40,
                    color: isSelected ? Colors.blue : Colors.grey),
                const SizedBox(height: 8),
                Text(label,
                    style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? Colors.blue : Colors.black)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ Weight & Age Box
  Widget cardValueBox(String title, int value, String unit,
      VoidCallback onIncrement, VoidCallback onDecrement) {
    return Card(
      elevation: 5,
      color: lightBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.blue),
                  onPressed: onDecrement,
                ),
                Text(
                  value.toString(),
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.blue),
                  onPressed: onIncrement,
                ),
              ],
            ),
            Text(unit, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
