import 'package:f_medi_minders/welcome_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // ✅ FIX: Makes screen scrollable on small devices
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // 🌟 App Logo & Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.medical_services, size: 40, color: Colors.blue),
                    SizedBox(width: 10),
                    Text(
                      "MediMinder",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🏥 Hero Animation
                SizedBox(
                  height: 250,
                  child: Lottie.network(
                    "https://assets10.lottiefiles.com/packages/lf20_zpjfsp1e.json", // Medicine reminder animation
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 20),

                // ✍ Tagline
                const Text(
                  "Stay on Track with Your Medications",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 10),

                // 📜 Short description
                const Text(
                  "MediMinder helps you follow your doctor’s prescription, "
                  "track doses, and receive reminders – so you never miss a pill again.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 25),

                // ✅ Key Features Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ListTile(
                      leading: Icon(Icons.alarm, color: Colors.blue),
                      title: Text("Smart Reminders",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle:
                          Text("Get alerts exactly when it’s time to take your medicine."),
                    ),
                    ListTile(
                      leading: Icon(Icons.description, color: Colors.blue),
                      title: Text("Prescription Tracker",style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle:
                          Text("Store and view all your doctor’s prescriptions easily."),
                    ),
                    ListTile(
                      leading: Icon(Icons.group, color: Colors.blue),
                      title: Text("Caregiver Notifications",style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle:
                          Text("Notify family or caregivers if a dose is missed."),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🔘 Get Started Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>WelcomeHomeScreen())); // 👉 Goes to Sign-In page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
