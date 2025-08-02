import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/notification_service.dart';

class Medicine {
  final String name;
  final DateTime date;
  final TimeOfDay time;
  final String timeOfDay;
  final int dose;
  final String type;
  bool isChecked;

  Medicine({
    required this.name,
    required this.date,
    required this.time,
    required this.timeOfDay,
    required this.dose,
    required this.type,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'date': date.toIso8601String(),
        'timeHour': time.hour,
        'timeMinute': time.minute,
        'timeOfDay': timeOfDay,
        'dose': dose,
        'type': type,
        'isChecked': isChecked,
      };

  factory Medicine.fromMap(Map<String, dynamic> map) => Medicine(
        name: map['name'],
        date: DateTime.parse(map['date']),
        time: TimeOfDay(hour: map['timeHour'], minute: map['timeMinute']),
        timeOfDay: map['timeOfDay'],
        dose: map['dose'],
        type: map['type'],
        isChecked: map['isChecked'],
      );
}

class MediReminderApp extends StatefulWidget {
  const MediReminderApp({super.key});

  @override
  State<MediReminderApp> createState() => _MediReminderAppState();
}

class _MediReminderAppState extends State<MediReminderApp> {
  int selectedDateIndex = 0;
  List<DateTime> dateList =
      List.generate(10, (i) => DateTime.now().add(Duration(days: i)));
  List<Medicine> medicines = [];

  @override
  void initState() {
    super.initState();
    _loadMedicines();
  }

  Future<void> _loadMedicines() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('medicines');
    if (saved != null) {
      final List decoded = jsonDecode(saved);
      setState(() {
        medicines = decoded.map((m) => Medicine.fromMap(m)).toList();
      });
    }
  }

  Future<void> _saveMedicines() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(medicines.map((m) => m.toMap()).toList());
    await prefs.setString('medicines', encoded);
  }

  void openAddMedicineSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => AddMedicineSheet(
        onSave: (medicine) {
          setState(() {
            medicines.add(medicine);
          });
          _saveMedicines();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = dateList[selectedDateIndex];
    final currentMonth = DateFormat.MMMM().format(selectedDate);
    final filteredMeds = medicines
        .where((m) =>
            m.date.year == selectedDate.year &&
            m.date.month == selectedDate.month &&
            m.date.day == selectedDate.day)
        .toList();

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(currentMonth,
            style: const TextStyle(color: Colors.white, fontSize: 22)),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active),
            tooltip: "Instant Test",
            onPressed: () {
              NotificationService.showInstantNotification();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("✅ Instant notification sent")),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.alarm),
            tooltip: "Fire Alarm",
            onPressed: () {
              NotificationService.fireReminderNotification();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("🚨 Fire reminder sent")),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA8C0FF), Color(0xFF667EEA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            _buildDateSlider(),
            const SizedBox(height: 12),
            Expanded(
              child: filteredMeds.isEmpty
                  ? const Center(
                      child: Text("No medicines added yet",
                          style: TextStyle(color: Colors.white, fontSize: 16)))
                  : ListView.builder(
                      itemCount: filteredMeds.length,
                      itemBuilder: (context, index) {
                        final med = filteredMeds[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          color: Colors.white.withOpacity(0.9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: med.isChecked,
                              activeColor: Colors.deepPurple,
                              onChanged: (val) {
                                setState(() => med.isChecked = val!);
                                _saveMedicines();
                              },
                            ),
                            title: Text(med.name,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                              '${med.type} • ${med.time.format(context)} - ${med.timeOfDay} - Dose: ${med.dose}',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddMedicineSheet,
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(height: 60),
      ),
    );
  }

  Widget _buildDateSlider() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dateList.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedDateIndex;
          final date = dateList[index];
          return GestureDetector(
            onTap: () => setState(() => selectedDateIndex = index),
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.white24,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat.d().format(date),
                      style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? Colors.deepPurple : Colors.white,
                          fontWeight: FontWeight.bold)),
                  Text(DateFormat.E().format(date),
                      style: TextStyle(
                          color: isSelected
                              ? Colors.deepPurpleAccent
                              : Colors.white70,
                          fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddMedicineSheet extends StatefulWidget {
  final void Function(Medicine) onSave;

  const AddMedicineSheet({super.key, required this.onSave});

  @override
  State<AddMedicineSheet> createState() => _AddMedicineSheetState();
}

class _AddMedicineSheetState extends State<AddMedicineSheet> {
  final TextEditingController _nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _doseCount = 1;
  final List<bool> _timeOfDay = [true, false, false];
  int _selectedTypeIndex = 0;

  final List<String> _types = [
    'Tablets',
    'Capsules',
    'Syrup',
    'Drops',
    'Injections'
  ];
  final List<IconData> _icons = [
    Icons.medication,
    Icons.medical_services,
    Icons.local_drink,
    Icons.opacity,
    Icons.vaccines
  ];

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Wrap(
        children: [
          const Center(
              child: Text("Add Medicine",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold))),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: "Medicine Name",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text("Date:", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Text(DateFormat.yMMMMd().format(_selectedDate)),
              const Spacer(),
              TextButton(
                  onPressed: _pickDate,
                  child: const Text("Pick Date",
                      style: TextStyle(color: Colors.deepPurpleAccent))),
            ],
          ),
          Row(
            children: [
              const Text("Time:", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Text(_selectedTime.format(context)),
              const Spacer(),
              TextButton(
                  onPressed: _pickTime,
                  child: const Text("Pick Time",
                      style: TextStyle(color: Colors.deepPurpleAccent))),
            ],
          ),
          const SizedBox(height: 12),
          ToggleButtons(
            isSelected: _timeOfDay,
            onPressed: (index) {
              setState(() {
                for (int i = 0; i < _timeOfDay.length; i++) {
                  _timeOfDay[i] = i == index;
                }
              });
            },
            borderRadius: BorderRadius.circular(8),
            selectedColor: Colors.white,
            fillColor: Colors.deepPurpleAccent,
            children: const [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Morning")),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Afternoon")),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Evening")),
            ],
          ),
          const SizedBox(height: 12),
          const Text("Medicine Type:",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 10,
            children: List.generate(_types.length, (index) {
              return ChoiceChip(
                selected: _selectedTypeIndex == index,
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_icons[index], size: 18),
                    const SizedBox(width: 4),
                    Text(_types[index]),
                  ],
                ),
                selectedColor: Colors.deepPurpleAccent.withOpacity(0.2),
                onSelected: (selected) =>
                    setState(() => _selectedTypeIndex = index),
              );
            }),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text("Dose:",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (_doseCount > 1) setState(() => _doseCount--);
                  }),
              Text('$_doseCount'),
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => _doseCount++)),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              if (_nameController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("⚠️ Please enter a medicine name")),
                );
                return;
              }

              final timeStr = ['Morning', 'Afternoon', 'Evening'];

              final scheduledDate = DateTime(
                _selectedDate.year,
                _selectedDate.month,
                _selectedDate.day,
                _selectedTime.hour,
                _selectedTime.minute,
              );

              // ✅ Schedule a notification for medicine
              NotificationService.scheduleNotification(
                id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                title: "💊 Time to take ${_nameController.text.trim()}",
                body: "${_doseCount} dose(s) - ${_types[_selectedTypeIndex]}",
                scheduledDate: scheduledDate,
              );

              widget.onSave(
                Medicine(
                  name: _nameController.text.trim(),
                  date: _selectedDate,
                  time: _selectedTime,
                  timeOfDay: timeStr[_timeOfDay.indexOf(true)],
                  dose: _doseCount,
                  type: _types[_selectedTypeIndex],
                ),
              );

              Navigator.pop(context);
            },
            icon: const Icon(Icons.save),
            label: const Text("Save Medicine"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: Colors.deepPurpleAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
