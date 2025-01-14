import 'package:flutter/material.dart';

class MealPlanScreen extends StatelessWidget {
  final String patientName;

  const MealPlanScreen({super.key, required this.patientName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Plano Alimentar - $patientName'),
        backgroundColor: const Color(0xFF31BAC2),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildMealCard('Café da Manhã', ['2 fatias de pão integral', '1 ovo cozido', '1 maçã']),
            _buildMealCard('Lanche da Manhã', ['1 iogurte natural', '1 punhado de castanhas']),
            _buildMealCard('Almoço', ['150g de frango grelhado', '1 xícara de arroz integral', 'Salada verde']),
            _buildMealCard('Lanche da Tarde', ['1 banana', '1 colher de sopa de pasta de amendoim']),
            _buildMealCard('Jantar', ['150g de peixe assado', '1 batata doce média', 'Legumes no vapor']),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Editar plano alimentar
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF31BAC2),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Editar Plano Alimentar',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(String mealName, List<String> foods) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mealName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF31BAC2)),
            ),
            SizedBox(height: 8),
            ...foods.map((food) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Icon(Icons.fiber_manual_record, size: 8, color: Color(0xFF31BAC2)),
                  SizedBox(width: 8),
                  Text(food, style: TextStyle(fontSize: 16)),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}

