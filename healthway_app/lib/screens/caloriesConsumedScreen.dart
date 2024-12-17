import 'package:flutter/material.dart';

class CaloriesConsumedScreen extends StatelessWidget {
  const CaloriesConsumedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calories Consumed'),
      ),
      body: Center(
        child: Text(
          'Detalhes sobre as Calorias Consumidas',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
