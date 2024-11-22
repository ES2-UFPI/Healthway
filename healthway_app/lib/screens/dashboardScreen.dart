import 'package:flutter/material.dart';
import '../widgets/infoCard.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hey Emily,'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Ação ao clicar no ícone de configurações
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Ação ao clicar no ícone de notificações
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filtros diários, semanais e mensais
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilterButton(text: 'Daily'),
                FilterButton(text: 'Weekly'),
                FilterButton(
                  text: 'Monthly',
                  isSelected: true, // Define o botão "Monthly" como selecionado
                ),
              ],
            ),
            SizedBox(height: 24),
            
            // Análise de sono
Text(
  'Sleep Analysis',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
SizedBox(height: 16),
SizedBox(
  height: 180, // Ajuste a altura conforme necessário
  child: InfoCard(
    text: '80.4% Quality\n7h 30m Sleep Duration',
    icon: Icons.nightlight_round,
    routeName: '/sleepAnalysis',
  ),
),
SizedBox(height: 24),


            // Outros cards de informações
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  InfoCard(
                    text: 'More Self love & Fulfilment',
                    icon: Icons.self_improvement,
                    routeName: '/selfLove',
                  ),
                  InfoCard(
                    text: '1698 kcal Consumed',
                    icon: Icons.local_dining,
                    routeName: '/caloriesConsumed',
                  ),
                  InfoCard(
                    text: '80 bpm Avg Heart Rate',
                    icon: Icons.favorite,
                    routeName: '/heartRate',
                  ),
                  InfoCard(
                    text: '350 kcal Burned',
                    icon: Icons.fitness_center,
                    routeName: '/caloriesBurned',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Botão de filtro customizado
class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;

  const FilterButton({required this.text, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.blue[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
