import 'package:f_medi_minders/mediremainder.dart';
import 'package:f_medi_minders/services/notification_service.dart';
import 'package:f_medi_minders/water_intake_sreen.dart';
import 'package:f_medi_minders/welcome_main_screen.dart';
import 'package:f_medi_minders/welcome_yoga_screen.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

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

  final List<Map<String, dynamic>> pages = [
    {
      "title": "Meds Reminder",
      "image": "https://cdn-icons-png.freepik.com/256/13578/13578518.png?semt=ais_hybrid",
      "screen": const MediReminderApp(),
    },
    {
      "title": "Physical Fitness",
      "image": "https://img.lovepik.com/free-png/20211107/lovepik-yoga-for-ladies-png-image_400483716_wh1200.png",
      "screen": const YogaHomePage(),
    },
    {
      "title": "BMI Calculator",
      "image": "https://static.vecteezy.com/system/resources/previews/042/168/277/non_2x/body-mass-index-infographic-chart-colorful-bmi-chart-illustration-with-white-isolated-background-vector.jpg",
      "screen": const WelcomeMainScreen(),
    },
    {
      "title": "Water Reminder",
      "image": "https://is1-ssl.mzstatic.com/image/thumb/Purple126/v4/d6/67/64/d66764ec-189b-fa7d-cb07-420b146e273d/AppIcon-1x_U007emarketing-0-5-0-85-220.png/1200x600wa.png",
      "screen": const WaterReminderApp(),
    },
  ];

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
        backgroundColor: Colors.blueAccent,
        leading: const Icon(Icons.menu),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue,Colors.white])
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hi, Welcome to Medi Minder..",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
          
              // 🟢 Carousel with navigation
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
                          MaterialPageRoute(builder: (context) => item['screen']),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                item['image']!,
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              item['title']!,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          
              const SizedBox(height: 10),
          
              // 🟢 Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pages.asMap().entries.map((entry) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
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
          
              // 🟢 Bottom Illustration
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      "https://static.vecteezy.com/system/resources/thumbnails/002/127/173/small_2x/medicine-and-healthcare-concept-illustration-male-and-female-doctor-character-medical-service-can-use-for-homepage-mobile-apps-web-banner-character-cartoon-illustration-flat-style-free-vector.jpg",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              ),
          
              const SizedBox(height: 10),
          
              // 🟢 Quotes
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "💊 “The art of medicine consists in amusing the patient while nature cures the disease.”",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "🩺 “Wherever the art of medicine is loved, there is also a love of humanity.”",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "💙 “Health is the greatest gift, contentment the greatest wealth.”",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}
