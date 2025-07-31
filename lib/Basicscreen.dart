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
      home: Basicscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Basicscreen extends StatefulWidget {
  const Basicscreen({super.key});

  @override
  State<Basicscreen> createState() => _BasicscreenState();
}

class _BasicscreenState extends State<Basicscreen> {
  final List<Map<String, String>> yogaGifs = const [
    {
      'name': 'Gomukhasana(Cow Face pose)',
      'gif': 'assets/Basics/gomukhasana.png',
      'desc': 'Gomukhasana, also known as Cow Face Pose, is a seated yoga posture that stretches the hips, shoulders, and chest, while also improving flexibility and posture.  ',
    },
    {
      'name': 'Trikonasana(triangle Pose)',
      'gif': 'assets/Basics/trikonmasana.png',
      'desc':'Place the fingers of your right hand behind the right foot. The left arm should now be in a straight line aligned with your right arm. ',
    },
    {
      'name': 'Virabhadrasana(Half Warrior Pose)',
      'gif': 'assets/Basics/veerabadhrasana(trans).png',
      'desc':'Half Warrior Pose: This is another Warrior I variation that focuses on keeping both hands overhead and bending the upper body slightly forward for a gentle to deep stretch around the vertebral column, shoulders, arms, and hamstrings.',
    },
    {
      'name': 'Vrikshasana(Tree Pose)',
      'gif': 'assets/Basics/vrikshasana(trans).png',
      'desc': 'Vrikshasana, also known as Tree Pose, is a balancing yoga asana that strengthens the legs and improves balance and concentration. ',   
    },
    {
      'name': 'Marjaryasana(Cat Pose)',
      'gif': 'assets/Basics/Marjaryasana.png',
      'desc': 'Marjaryasana, also known as the Cat Pose, is a yoga posture where the spine is rounded upwards, similar to a cat stretching. ',   
    },
    {
      'name': 'Bhujangasana(cobra pose)',
      'gif': 'assets/Basics/1.png',
      'desc': 'Bhujangasana, also known as the Cobra Pose, is a popular yoga asana that involves lifting your upper body off the ground, mimicking the posture of a cobra with its hood raised.',    
    },
    {
      'name': 'Mukha Svanasana(Downward-facing Dog pose)',
      'gif': 'assets/Basics/MukhaSvanasana.png',
       'desc': 'Mukha Svanasana, or Downward-Facing Dog Pose, is a popular and beneficial yoga asana that resembles a dog stretching with its face downwards. ',   
    },
    //{
      //'name': 'Seated Forward Bend',
      //'gif': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAR93cyZ8M2u94c7165HcnHdbMDyox2G-yMw&s',
      //'desc': '',   
    //},
   // {
    //  'name': 'Balasana(child Pose)',
   //   'gif': 'https://media.istockphoto.com/id/1357380553/vector/wide-childs-pose-prasarita-balasana-beautiful-girl-practice-prasarita-balasana.jpg?s=612x612&w=0&k=20&c=vwv2LthGsdIDsRRsMfLlLzuzKWtBKpN6c_5zbJ2AmTs=',
    //  'desc': 'Balasana, also known as Child Pose, is a restorative and calming yoga posture that gently stretches the hips, thighs, ankles, and lower back. ',    
   // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Basics Excises",style: TextStyle(color: Colors.white),),
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