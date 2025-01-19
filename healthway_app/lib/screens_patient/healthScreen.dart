import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';

class DietManagementScreen extends StatelessWidget {
  const DietManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Gerenciamento de Dieta'),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDailySummary(),
              SizedBox(height: 24),
              _buildMealList(),
              SizedBox(height: 24),
              _buildWaterIntake(),
              SizedBox(height: 24),
              _buildNutritionGoals(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Adicionar refeição
        },
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildDailySummary() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumo Diário',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryItem('Calorias', '1500/2000'),
                _buildSummaryItem('Proteínas', '75g/100g'),
                _buildSummaryItem('Carboidratos', '180g/250g'),
                _buildSummaryItem('Gorduras', '50g/65g'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMealList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Refeições do Dia',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600]),
          ),
        ),
        SizedBox(height: 16),
        _buildMealItem('Café da Manhã', '07:30', '400 kcal'),
        _buildMealItem('Lanche da Manhã', '10:00', '150 kcal'),
        _buildMealItem('Almoço', '12:30', '600 kcal'),
        _buildMealItem('Lanche da Tarde', '15:30', '200 kcal'),
        _buildMealItem('Jantar', '19:00', '450 kcal'),
      ],
    );
  }

  Widget _buildMealItem(String mealName, String time, String calories) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: kPrimaryColor.withOpacity(0.1),
          child: Icon(Icons.restaurant, color: kPrimaryColor),
        ),
        title: Text(mealName, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(time),
        trailing: Text(
          calories,
          style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor),
        ),
        onTap: () {
          // Abrir detalhes da refeição
        },
      ),
    );
  }

  Widget _buildWaterIntake() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Consumo de Água',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  '1.5L / 2.5L',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionGoals() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Metas Nutricionais',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildNutritionGoalItem('Calorias', 1500, 2000),
            _buildNutritionGoalItem('Proteínas', 75, 100),
            _buildNutritionGoalItem('Carboidratos', 180, 250),
            _buildNutritionGoalItem('Gorduras', 50, 65),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionGoalItem(String label, int current, int goal) {
    double progress = current / goal;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            ),
            SizedBox(width: 16),
            Text(
              '$current / $goal g',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
