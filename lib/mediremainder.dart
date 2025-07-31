// main.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:device_preview/device_preview.dart';

class MediReminderApp extends StatelessWidget {
  const MediReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      title: 'Medi Reminder',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

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
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedDateIndex = 0;
  List<DateTime> dateList = List.generate(10, (i) => DateTime.now().add(Duration(days: i)));
  List<Medicine> medicines = [];

  void openAddMedicineSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => AddMedicineSheet(
        onSave: (medicine) {
          setState(() => medicines.add(medicine));
        },
      ),
    );
  }

  void openProfileScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = dateList[selectedDateIndex];
    final currentMonth = DateFormat.MMMM().format(selectedDate);
    final filteredMeds = medicines.where((m) =>
        m.date.year == selectedDate.year &&
        m.date.month == selectedDate.month &&
        m.date.day == selectedDate.day).toList();

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(currentMonth, style: const TextStyle(color: Colors.white, fontSize: 22)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF84A9FC), Color(0xFF4768FF)],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF84A9FC), Color(0xFF4768FF)],
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
                  ? const Center(child: Text("No medicines added yet", style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                      itemCount: filteredMeds.length,
                      itemBuilder: (context, index) {
                        final med = filteredMeds[index];
                        return ListTile(
                          leading: Checkbox(
                            value: med.isChecked,
                            onChanged: (val) => setState(() => med.isChecked = val!),
                          ),
                          title: Text(med.name, style: const TextStyle(color: Colors.white)),
                          subtitle: Text(
                            '${med.type} • ${med.time.format(context)} - ${med.timeOfDay} - Dose: ${med.dose}',
                            style: const TextStyle(color: Colors.white70),
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
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(Icons.home, color: Colors.blueAccent),
              const Icon(Icons.note_alt_outlined),
              const SizedBox(width: 40),
              GestureDetector(
                onTap: openProfileScreen,
                child: const Icon(Icons.person_outline),
              ),
              const Icon(Icons.menu),
            ],
          ),
        ),
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
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat.d().format(date),
                      style: TextStyle(
                          fontSize: 16,
                          color: isSelected ? Colors.blue : Colors.white,
                          fontWeight: FontWeight.bold)),
                  Text(DateFormat.E().format(date),
                      style: TextStyle(
                          color: isSelected ? Colors.blueAccent : Colors.white70, fontSize: 12)),
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

  final List<String> _types = ['Tablets', 'Capsules', 'Syrup', 'Drops', 'Injections'];
  final List<IconData> _icons = [Icons.medication, Icons.medical_services, Icons.local_drink, Icons.opacity, Icons.vaccines];

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
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 16,
        left: 16,
        right: 16,
      ),
      child: Wrap(
        children: [
          const Center(child: Text("Add Medicine", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Medicine Name", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text("Date:"), const SizedBox(width: 8),
              Text(DateFormat.yMMMMd().format(_selectedDate)),
              const Spacer(),
              TextButton(onPressed: _pickDate, child: const Text("Pick Date")),
            ],
          ),
          Row(
            children: [
              const Text("Time:"), const SizedBox(width: 8),
              Text(_selectedTime.format(context)),
              const Spacer(),
              TextButton(onPressed: _pickTime, child: const Text("Pick Time")),
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
            fillColor: Colors.blueAccent,
            children: const [
              Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Morning")),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Afternoon")),
              Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("Evening")),
            ],
          ),
          const SizedBox(height: 12),
          const Text("Medicine Type:"),
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
                onSelected: (selected) => setState(() => _selectedTypeIndex = index),
              );
            }),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text("Dose:"),
              IconButton(icon: const Icon(Icons.remove), onPressed: () {
                if (_doseCount > 1) setState(() => _doseCount--);
              }),
              Text('$_doseCount'),
              IconButton(icon: const Icon(Icons.add), onPressed: () => setState(() => _doseCount++)),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              if (_nameController.text.trim().isEmpty) return;
              final timeStr = ['Morning', 'Afternoon', 'Evening'];
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
              backgroundColor: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text("User Profile Page", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}