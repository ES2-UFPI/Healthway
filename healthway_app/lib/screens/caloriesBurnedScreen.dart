import 'package:flutter/material.dart';

class CaloriesBurnedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calories Burned'),
      ),
      body: Center(
        child: Text(
          'Detalhes sobre as Calorias Queimadas',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
