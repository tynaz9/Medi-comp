//import 'package:flutter/foundation.dart';
import 'package:f_medi_minders/landing_main_page.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:intl/intl.dart';

class WaterReminderApp extends StatelessWidget {
  const WaterReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Reminder',
      debugShowCheckedModeBanner: false,
      builder: DevicePreview.appBuilder,
      home: const WaterReminderScreen(),
    );
  }
}

class WaterReminderScreen extends StatefulWidget {
  const WaterReminderScreen({super.key});

  @override
  State<WaterReminderScreen> createState() => _WaterReminderScreenState();
}

class _WaterReminderScreenState extends State<WaterReminderScreen> {
  int totalIntake = 0;
  final int dailyGoal = 3000;

  List<Map<String, dynamic>> intakeHistory = [];

  void addWater(int amount, DateTime dateTime) {
    setState(() {
      totalIntake += amount;
      final time = DateFormat('hh:mm a').format(dateTime);
      intakeHistory.insert(0, {
        'text': '$amount ml at $time',
        'checked': true,
        'amount': amount,
      });
    });
  }

  void openAddWaterSheet() {
    final TextEditingController mlController = TextEditingController();
    DateTime tempSelectedDateTime = DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Add Water Intake",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: mlController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Water Amount (ml)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.blueAccent),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            initialDate: tempSelectedDateTime,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(tempSelectedDateTime),
                            );
                            if (pickedTime != null) {
                              setModalState(() {
                                tempSelectedDateTime = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                              });
                            }
                          }
                        },
                        child: Text(
                          DateFormat('dd MMM yyyy - hh:mm a').format(tempSelectedDateTime),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (mlController.text.isEmpty) return;
                      int ml = int.tryParse(mlController.text) ?? 0;
                      if (ml <= 0) return;

                      addWater(ml, tempSelectedDateTime);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.water_drop),
                    label: const Text("Add Water"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = totalIntake / dailyGoal;
    if (progress > 1) progress = 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=> LandingMainPage()));
        }, icon: Icon(Icons.arrow_back),color: Colors.black,),
        title: const Text("Water Reminder"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2196f3), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddWaterSheet,
        backgroundColor: const Color(0xFF2196f3),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196f3), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  DateFormat.yMMMMEEEEd().format(DateTime.now()),
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 30),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 14,
                        backgroundColor: Colors.white30,
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "$totalIntake ml",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Goal: $dailyGoal ml",
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Today’s Intake History",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: intakeHistory.isEmpty
                      ? const Center(
                          child: Text(
                            "No intake recorded yet",
                            style: TextStyle(color: Colors.lightBlueAccent),
                          ),
                        )
                      : ListView.builder(
                          itemCount: intakeHistory.length,
                          itemBuilder: (context, index) {
                            final item = intakeHistory[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                              ),
                              child: CheckboxListTile(
                                title: Text(
                                  item['text'],
                                  style: const TextStyle(color: Colors.black),
                                ),
                                value: item['checked'],
                                activeColor: Colors.blueAccent,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == false) {
                                      totalIntake -= item['amount'] as int;
                                      intakeHistory.removeAt(index);
                                    } else {
                                      item['checked'] = true;
                                    }
                                  });
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}