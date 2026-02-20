import 'package:flutter/material.dart';

class Namaskarscreen extends StatefulWidget {
  const Namaskarscreen({super.key});

  @override
  State<Namaskarscreen> createState() => _NamaskarscreenState();
}

class _NamaskarscreenState extends State<Namaskarscreen> {
  final List<Map<String, String>> yogaImages = const [
    {
      'name': '1. Pranamasana (Prayer Pose)',
      'image': 'assets/Surya/1.jpg',
      'desc': 'Stand tall, hands in Namaste; calm the mind and center yourself.',
    },
    {
      'name': '2. Hastauttanasana (Raised Arms Pose)',
      'image': 'assets/Surya/2.jpg',
      'desc': 'Stretch arms overhead, arch slightly; opens lungs and energizes the body.',
    },
    {
      'name': '3. Padahastasana (Hand to Foot Pose)',
      'image': 'assets/Surya/3.jpg',
      'desc': 'Bend forward, touch the floor; improves flexibility and digestion.',
    },
    {
      'name': '4. Ashwa Sanchalanasana (Equestrian Pose)',
      'image': 'assets/Surya/4.jpg',
      'desc': 'Right leg back, chest lifted; strengthens legs and opens hips.',
    },
    {
      'name': '5. Dandasana (Plank Pose)',
      'image': 'assets/Surya/5.jpg',
      'desc': 'Both legs back, body straight; builds core and arm strength.',
    },
    {
      'name': '6. Ashtanga Namaskara (Eight-Limbed Salute)',
      'image': 'assets/Surya/6.jpg',
      'desc': 'Knees, chest, chin down; full-body surrender and strength.',
    },
    {
      'name': '7. Bhujangasana (Cobra Pose)',
      'image': 'assets/Surya/7.jpg',
      'desc': 'Lift chest in a backbend; opens heart and spine.',
    },
    {
      'name': '8. Parvatasana (Mountain/Downward Dog Pose)',
      'image': 'assets/Surya/8.jpg',
      'desc': 'Hips up, heels down; stretches spine and calms the mind.',
    },
    {
      'name': '9. Ashwa Sanchalanasana (Equestrian Pose - Left Leg)',
      'image': 'assets/Surya/9.jpg',
      'desc': 'Left leg forward, gaze up; balances both sides of the body.',
    },
    {
      'name': '10. Padahastasana (Hand to Foot Pose)',
      'image': 'assets/Surya/3.jpg',
      'desc': 'Bend forward again; lengthens spine, relieves tension.',
    },
    {
      'name': '11. Hastauttanasana (Raised Arms Pose)',
      'image': 'assets/Surya/2.jpg',
      'desc': 'Stretch up and arch back; enhances circulation and vitality.',
    },
    {
      'name': '12. Pranamasana (Prayer Pose)',
      'image': 'assets/Surya/1.jpg',
      'desc': 'Return to Namaste; grounding and gratitude to end the cycle.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 178, 205, 238),
        centerTitle: true,
        title: const Text(
          "Surya Namaskara Yoga",
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
          itemCount: yogaImages.length,
          itemBuilder: (context, index) {
            final pose = yogaImages[index];
            return Card(
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
                    child: Image.asset(
                      pose['image']!,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${pose['desc']}"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
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