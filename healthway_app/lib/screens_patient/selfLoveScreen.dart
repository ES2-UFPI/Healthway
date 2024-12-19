import 'package:flutter/material.dart';

class SelfLoveScreen extends StatelessWidget {
  const SelfLoveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Self Love & Fulfilment')),
      body: Center(
        child: Text(
          'Detalhes de Self Love & Fulfilment',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
