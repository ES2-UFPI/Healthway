import 'package:flutter/material.dart';

class SleepCalculatorScreen extends StatefulWidget {
  const SleepCalculatorScreen({super.key});

  @override
  _SleepCalculatorScreenState createState() => _SleepCalculatorScreenState();
}

class _SleepCalculatorScreenState extends State<SleepCalculatorScreen> {
  TimeOfDay? sleepTime;
  TimeOfDay? wakeUpTime;
  String sleepDuration = "";

  Future<void> _selectTime(BuildContext context, bool isSleepTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isSleepTime) {
          sleepTime = picked;
        } else {
          wakeUpTime = picked;
        }
      });
    }
  }

  void _calculateSleepDuration() {
    if (sleepTime != null && wakeUpTime != null) {
      final sleepDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        sleepTime!.hour,
        sleepTime!.minute,
      );
      final wakeUpDateTime = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        wakeUpTime!.hour,
        wakeUpTime!.minute,
      );

      // Ajusta para o caso de acordar no dia seguinte
      final adjustedWakeUpDateTime = wakeUpDateTime.isBefore(sleepDateTime)
          ? wakeUpDateTime.add(const Duration(days: 1))
          : wakeUpDateTime;

      final duration = adjustedWakeUpDateTime.difference(sleepDateTime);
      setState(() {
        sleepDuration = "${duration.inHours}h ${duration.inMinutes.remainder(60)}m";
      });
    } else {
      setState(() {
        sleepDuration = "Please select both times!";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sleep Calculator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Track Your Sleep',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Sleep time picker
            _buildTimePicker(
              context,
              label: "Sleep Time",
              selectedTime: sleepTime,
              onTap: () => _selectTime(context, true),
            ),
            const SizedBox(height: 16),
            // Wake up time picker
            _buildTimePicker(
              context,
              label: "Wake Up Time",
              selectedTime: wakeUpTime,
              onTap: () => _selectTime(context, false),
            ),
            const SizedBox(height: 24),
            // Calculate button
            Center(
              child: ElevatedButton(
                onPressed: _calculateSleepDuration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Calculate Duration',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Sleep duration display
            Center(
              child: Text(
                sleepDuration,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker(BuildContext context,
      {required String label, TimeOfDay? selectedTime, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedTime != null
                  ? selectedTime.format(context)
                  : "Select $label",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Icon(Icons.access_time, color: Color(0xFF4CAF50)),
          ],
        ),
      ),
    );
  }
}
