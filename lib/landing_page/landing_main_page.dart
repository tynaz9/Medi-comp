import 'package:f_medi_minders/meds_reminder/mediremainder.dart';
import 'package:f_medi_minders/services/notification_service.dart';
import 'package:f_medi_minders/water_reminder/water_intake_sreen.dart';
import 'package:f_medi_minders/bmi_calculator/welcome_main_screen.dart';
import 'package:f_medi_minders/physical_fitness/welcome_yoga_screen.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ ADDED
import "package:f_medi_minders/quotes_screen_model/encouragement_box.dart";

class LandingMainPage extends StatelessWidget {
  const LandingMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medi Minder',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  String userName = "User"; // ✅ ADDED

  final List<Map<String, dynamic>> pages = [
    {
      "title": "Meds Reminder",
      "image": "assets/m11.png",
      "screen": const MediReminderApp(),
    },
    {
      "title": "Physical Fitness",
      "image": "assets/y11.png",
      "screen": const YogaHomePage(),
    },
    {
      "title": "BMI Calculator",
      "image": "assets/b1.jpg",
      "screen": const WelcomeMainScreen(),
    },
    {
      "title": "Water Reminder",
      "image": "assets/w1.png",
      "screen": const WaterReminderApp(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserName(); // ✅ ADDED
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("username") ?? "User";
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MEDI MINDER"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue, Colors.white],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                  
                // ✅ UPDATED GREETING ONLY
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hi $userName 👋 Welcome to Medi Minder..",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                  
                const SizedBox(height: 16),
                  
                SizedBox(
                  height: 170,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      final item = pages[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => item['screen']),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin:
                              const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[200],
                            boxShadow: [
                              if (index == _currentPage)
                                BoxShadow(
                                  color: Colors.blueAccent.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(12),
                                child: Image.asset(
                                  item['image']!,
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(Icons.broken_image),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item['title']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                  
                const SizedBox(height: 10),
                  
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: pages.asMap().entries.map((entry) {
                    return Container(
                      width: 8,
                      height: 8,
                      margin:
                          const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == entry.key
                            ? Colors.blueAccent
                            : Colors.grey,
                      ),
                    );
                  }).toList(),
                ),
                  
                const SizedBox(height: 20),
                  
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(16),
                      child: Image.network(
                        "https://static.vecteezy.com/system/resources/thumbnails/002/127/173/small_2x/medicine-and-healthcare-concept-illustration-male-and-female-doctor-character-medical-service-can-use-for-homepage-mobile-apps-web-banner-character-cartoon-illustration-flat-style-free-vector.jpg",
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
                                const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                ),
                  
                const SizedBox(height: 10),
                const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  EncouragementBox(
                    text: "💊 Stay consistent — every dose you take is a step toward better health.",
                  ),
              
                  EncouragementBox(
                    text: "💙 Small healthy habits today create a stronger tomorrow.",
                  ),
              
                  EncouragementBox(
                    text: "🌿 Your body hears everything your mind says — speak strength.",
                  ),
              
                  EncouragementBox(
                    text: "🩺 Taking care of yourself is not a luxury, it’s a necessity.",
                  ),
              
                  EncouragementBox(
                    text: "💧 Hydration, medication, movement — progress happens daily.",
                  ),
              
                  EncouragementBox(
                    text: "🌞 One reminder at a time, one healthy choice at a time.",
                  ),
              
                  EncouragementBox(
                    text: "🏃‍♂️ A little progress each day adds up to big results.",
                  ),
              
                  EncouragementBox(
                    text: "✨ Your health journey is important — keep going!",
                  ),
              
                  ],
                ),
            ),
                  ),
                
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}