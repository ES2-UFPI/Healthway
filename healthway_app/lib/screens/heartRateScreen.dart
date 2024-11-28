import 'package:flutter/material.dart';

class HeartRateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate'),
      ),
      body: Center(
        child: Text(
          'Detalhes sobre a Frequência Cardíaca',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
