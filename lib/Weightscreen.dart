import 'package:flutter/material.dart';

class Weightscreen extends StatefulWidget {
  const Weightscreen({super.key});

  @override
  State<Weightscreen> createState() => _WeightscreenState();
}

class _WeightscreenState extends State<Weightscreen> {
  final List<Map<String, String>> yogaGifs = const [
    {
      'name': 'Chair Push-up',
      'gif': 'assets/Weight/chairPush.png',
      'desc':'Chair push-ups are an effective and adaptable exercise for building upper body strength, particularly for beginners or individuals with limitations.',
    },
    {
      'name': 'Full-body Exercise',
      'gif': 'assets/Weight/fullbody.png',
      'desc':'A full-body workout is a type of exercise routine that involves exercises targeting multiple major muscle groups in a single session.',
    },
    {
      'name': 'Crescent Moon Pose',
      'gif': 'assets/Weight/crescent.png',
      'desc':'a yoga pose that involves stepping one leg back into a lunge, with the back knee lowered to the ground, and the arms raised overhead.',
    },
    {
      'name': 'Fish Pose',
      'gif': 'assets/Weight/fish.png',
      'desc':'Fish Pose, or Matsyasana in Sanskrit, is a reclining backbend in yoga that stretches the chest, throat, and abdomen while opening the shoulders. ',
    },
    {
      'name': 'Side Plank Pose',
      'gif': 'assets/Weight/sideplank.png',
      'desc':'The Side Plank Pose, also known as Vasisthasana in yoga, is a powerful exercise that strengthens the core, arms, shoulders, and legs while improving balance and flexibility. ',
    },
    {
      'name': 'Wall Calf Stretch',
      'gif': 'assets/Weight/wall.png',
      'desc':'standing facing a wall, placing your hands on it for support, and then stepping one leg back while keeping the heel on the ground.',
    },
    {
      'name': 'Bridge Pose',
      'gif': 'assets/Weight/Bridge.png',
      'desc':'Bridge Pose, also known as Setu Bandhasana, is a yoga posture where you lie on your back, bend your knees, and lift your hips, creating a bridge-like shape with your body. ',
    },
    {
      'name': 'Downward-Facing Tress pose',
      'gif': 'assets/Weight/Downward.png',
      'desc':'Downward-Facing Tree Pose, also known as Handstand Pose or Adho Mukha Vrksasana, is an advanced inversion in yoga that builds strength, balance, and focus. ',
    },
    
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 178, 205, 238),
        centerTitle: true,
        title: const Text(
          "Weight loss Yoga",
          style: TextStyle(color: Colors.black),
        ),
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
                    Image.network(
                        pose['gif']!,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Text("Image failed to load"));
                        },
                      ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${pose['desc']}"),
                  ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

