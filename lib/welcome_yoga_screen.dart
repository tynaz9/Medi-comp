import 'package:flutter/material.dart';
import 'Basicscreen.dart';
import 'Breathingscreen.dart';
import 'Namaskarscreen.dart';
import 'Weightscreen.dart';

class YogaHomePage extends StatelessWidget {
  const YogaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 178, 205, 238),
        title: const Text(
          'YOGA 🧘🏻',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 178, 205, 238),
              const Color.fromARGB(255, 189, 205, 227),
              const Color.fromARGB(255, 213, 227, 236),
              const Color.fromARGB(255, 246, 247, 248),
              const Color.fromARGB(255, 246, 247, 248),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Yoga is mirror to look at ourselves from within",
                  style: TextStyle(fontSize: 12,fontStyle: FontStyle.normal,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,selectionColor: Colors.white,
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      levelCard(context,"Basics", Basicscreen()),
                      levelCard(context,"Breathing",Breathingscreen()),
                      levelCard(context,"  Weight loss",Weightscreen()),
                      levelCard(context,"Surya Namaskar",Namaskarscreen()),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
                SizedBox(
                  height: 290,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      'https://media4.giphy.com/media/v1.Y2lkPTc5MGI3NjExd2pwMzA0NGJyaTA3OWc2em0ycDM3ZWhlc2MydWVuYm80ejFtcmNhdCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/XyakWW6WwplIPSHfuR/giphy.gif',
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Text('Image failed to load'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget levelCard(BuildContext context,String label,Widget screen) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        width: 150,
        height: 60,
         child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
             );
          },
        child: Card(
          elevation: 4,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 80, 123, 178),
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}