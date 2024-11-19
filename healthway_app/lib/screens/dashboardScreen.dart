import 'package:flutter/material.dart';
import '../widgets/selectionButton.dart';
import '../widgets/sleepAnalysisCard.dart';
import '../widgets/infoCard.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.settings, color: Colors.black),
        actions: [
          Icon(Icons.notifications, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey Emily,',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectionButton(text: 'Daily', isSelected: false),
                SelectionButton(text: 'Weekly', isSelected: false),
                SelectionButton(text: 'Monthly', isSelected: true),
              ],
            ),
            SizedBox(height: 16),
            SleepAnalysisCard(),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  InfoCard(
                      text: 'More Self love & Fulfilment',
                      icon: Icons.self_improvement),
                  InfoCard(
                      text: '1698 kcal Consumed', icon: Icons.local_dining),
                  InfoCard(text: '80 bpm Avg Heart Rate', icon: Icons.favorite),
                  InfoCard(text: '350 kcal Burned', icon: Icons.fitness_center),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
