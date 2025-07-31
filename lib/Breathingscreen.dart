import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(DevicePreview(builder: (context)=>MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Breathingscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Breathingscreen extends StatefulWidget {
  const Breathingscreen({super.key});

  @override
  State<Breathingscreen> createState() => _BreathingscreenState();
}

class _BreathingscreenState extends State<Breathingscreen> {
  final List<Map<String, String>> yogaGifs = const [
    {
      'name': 'Deep Breathing',
      'gif': 'assets/Breathing/Deepbreathing.png',
      'desc':'Deep breathing exercises, also known as diaphragmatic or belly breathing, focus on engaging your diaphragm to take full, conscious breaths. ',
    },
    {
      'name': 'Nadi Shodhana',
      'gif':'assets/Breathing/NadiShodhana.png',
      'desc':'Nadi Shodhana Pranayama, also known as Alternate Nostril Breathing, is a powerful breathing technique in yoga that can help to calm the nervous system, balance the brain hemispheres, and improve mental clarity and emotional stability. ',
    },
    {
      'name': 'Pranayama for Headche',
      'gif': 'assets/Breathing/Pranayama.png',
      'desc': 'This involves sitting comfortably, closing one nostril to inhale deeply through the other, then closing that nostril and exhaling through the first.  ',
    },
    {
      'name': 'Humming bee breath',
      'gif': 'assets/Breathing/Humming.png',
      'desc': 'Bhramari pranayama is a quick and effective practice that is scientifically proven to help you calm your mind during normal, everyday moments of life and in times of stress.',   
    },
    {
      'name': 'Ujjayi pranayama',
      'gif': 'assets/Breathing/ujjayi.png',
  
      'desc': 'Ujjayi Pranayama, also known as "ocean breath" or "victorious breath," is a yoga breathing technique involving a gentle constriction at the back of the throat during both inhalation and exhalation. ',   
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Breathing Execises",style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 178, 205, 238),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 178, 205, 238),
              Color.fromARGB(255, 189, 205, 227),
              Color.fromARGB(255, 213, 227, 236),
              Color.fromARGB(255, 246, 247, 248),
              Color.fromARGB(255, 246, 247, 248),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
     child: ListView.builder(
        itemCount: yogaGifs.length,
        itemBuilder: (context, index) {
          final pose = yogaGifs[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                margin: const EdgeInsets.all(10),
                elevation: 5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        pose['name']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ExerciseTimerDialog(pose: pose),
                        );
                      },
                      child: Image.network(
                        pose['gif']!,
                        //fit: BoxFit.cover,
                        height: 300,
                        width: double.infinity,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Text("Image failed to load"));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${pose['desc']}"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    )
    );
  }
}

class ExerciseTimerDialog extends StatelessWidget {
  final Map<String, String> pose;

  const ExerciseTimerDialog({super.key, required this.pose});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(pose['name'] ?? 'Yoga Pose'),
      content: const Text('Timer or exercise description can be shown here.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        )
      ],
    );
  }
}