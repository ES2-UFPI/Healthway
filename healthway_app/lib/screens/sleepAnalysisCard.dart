import 'package:flutter/material.dart';

class SleepAnalysisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sleep Analysis')),
      body: Center(
        child: Text(
          'Detalhes da Análise do Sono',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
