import 'package:flutter/material.dart';

class DietScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plano de Dieta'),
      ),
      body: Center(
        child: Text('Aqui está o seu plano de dieta!'),
      ),
    );
  }
}
