/*import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:medi_minder/screens/bmi_screen.dart';

class ResultScreen extends StatelessWidget {
  final double bmi;
  final int height;
  final int weight;

  const ResultScreen({
    super.key,
    required this.bmi,
    required this.height,
    required this.weight,
  });

  // Get BMI category & recommendation
    Map<String, String> getBmiStatus(double bmi) {
  if (bmi < 18.5) {
    return {
      'status': 'Underweight',
      'message':
          'A BMI below 18.5 is considered underweight. Add more nutritious meals and strength exercises to build healthy mass.',
    };
  } else if (bmi >= 18.5 && bmi < 25) {
    return {
      'status': 'Normal',
      'message':
          'You are in the healthy range! Keep up the good work with a balanced diet and regular physical activity.',
    };
  } else if (bmi >= 25 && bmi < 30) {
    return {
      'status': 'Overweight',
      'message':
          'A BMI between 25–29.9 is considered overweight. Consider adding more exercise and lighter meals to your daily routine.',
    };
  } else {
    return {
      'status': 'Obese',
      'message':
          'A BMI of 30 or above is classified as obese. It’s a good idea to talk to a healthcare provider and adopt healthy habits like walking, eating fresh food, and reducing screen time.',
    };
  }
}
 
  @override
  Widget build(BuildContext context) {
    final result = getBmiStatus(bmi);

    return Scaffold(
     // backgroundColor: Colors.lightBlue.shade50,
      body: Stack(
        children: [
          Image.asset('images/img2.jpg',fit: BoxFit.cover,height: double.infinity,),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Result',style: TextStyle(fontSize: 32,color: Colors.blue.shade900,fontWeight: FontWeight.bold),)),
                    SizedBox(height: 100,),
                      Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.blueAccent, width: 4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          bmi.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          result['status']!, // e.g., Overweight
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

          
                  const SizedBox(height: 16),
                  Text(
                    "Height: $height cm  |  Weight: $weight kg",
                    style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 44),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        result['message']!,
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontStyle: FontStyle.italic,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                        ),
                        speed: const Duration(milliseconds: 80),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 800),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),

                  const SizedBox(height: 150),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>BMIScreen())); // Goes back to input screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: const Text(
                      "RETRY",
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:f_medi_minders/input_screen.dart';

class ResultScreen extends StatelessWidget {
  final double bmi;
  final int height;
  final int weight;

   ResultScreen({
    super.key,
    required this.bmi,
    required this.height,
    required this.weight,
  });

  // Get BMI category, message and color range
  Map<String, dynamic> getBmiStatus(double bmi) {
    if (bmi < 18.5) {
      return {
        'status': 'Underweight',
        'message':
            'Your BMI is below 18.5, which is considered underweight for adults. Include more calories in your meals and aim for strength exercises.',
        'color': Colors.blue,
        'index': 0,
      };
    } else if (bmi >= 18.5 && bmi < 25) {
      return {
        'status': 'Normal',
        'message':
            'Your BMI is in the normal range! Keep up your great routine with healthy food and consistent workouts.',
        'color': Colors.green,
        'index': 1,
      };
    } else if (bmi >= 25 && bmi < 30) {
      return {
        'status': 'Overweight',
        'message':
            'Your BMI is considered overweight. Stay active and try reducing sugary and fatty foods.',
        'color': Colors.orange,
        'index': 2,
      };
    } else {
      return {
        'status': 'Obese',
        'message':
            'A BMI of 30+ is in the obese category. Consult a doctor for safe planning. Start with short walks, reduce screen time, and eat fresher meals.',
        'color': Colors.red,
        'index': 3,
      };
    }
  }

  final List<String> quotes = [
    "🏃‍♂️ One step at a time leads to miles of progress.",
    "🍎 Healthy outside starts from the inside.",
    "💪 Your body can stand almost anything. It’s your mind you have to convince.",
    "⏳ Don’t wish for a good body. Work for it!",
  ];

  @override
  Widget build(BuildContext context) {
    final result = getBmiStatus(bmi);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.lightBlue,Colors.white])
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Result',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Circular BMI value container
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: result['color'], width: 5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3)),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        bmi.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: result['color'],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        result['status'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  "Height: $height cm | Weight: $weight kg",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 30),

                // Typewriter animated message
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      result['message'],
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      speed: const Duration(milliseconds: 70),
                    ),
                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 700),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),

                const SizedBox(height: 30),

                // BMI Color Range Bar
                Text("BMI Range Indicator",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    )),
                const SizedBox(height: 10),

                Row(
                  children: [
                    _buildRangeBox("Underweight", Colors.blue,
                        result['index'] == 0),
                    _buildRangeBox("Normal", Colors.green,
                        result['index'] == 1),
                    _buildRangeBox("Overweight", Colors.orange,
                        result['index'] == 2),
                    _buildRangeBox("Obese", Colors.red,
                        result['index'] == 3),
                  ],
                ),

                const SizedBox(height: 30),

                // Motivational Quote
                AnimatedTextKit(
                  animatedTexts: quotes
                      .map((quote) => TypewriterAnimatedText(
                            quote,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            speed: const Duration(milliseconds: 60),
                          ))
                      .toList(),
                  totalRepeatCount: 100,
                  pause: const Duration(seconds: 2),
                  displayFullTextOnTap: true,
                ),

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const InputScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    "RETRY",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRangeBox(String label, Color color, bool active) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: active ? color : color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
              color: active ? color : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}