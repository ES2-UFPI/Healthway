import 'package:flutter/material.dart';

import '../main.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF31BAC2),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Antropometria',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Acompanhe os seus resultados',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Body Silhouette with Percentages
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'lib/assets/corpo.png',
                              height: 200,
                              color: Colors.black12,
                            ),
                            Column(
                              children: [
                                _buildPercentageIndicator(
                                  "MASSA MAGRA: 46%",
                                  const Color(0xFFFF9E9E),
                                ),
                                const SizedBox(height: 8),
                                _buildPercentageIndicator(
                                  "MASSA GORDA: 44%",
                                  const Color(0xFF7ED957),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Measurements List
                      const Text(
                        'Detalhamento',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildMeasurementRow('IMC', '2,05', 'Ideal'),
                      _buildMeasurementRow('Peso', '43,90', 'Bom'),
                      _buildMeasurementRow('Altura', '56,10', 'Melhorar'),
                      _buildMeasurementRow('% Massa Gorda', '25,90 Kg', 'Bom'),
                      _buildMeasurementRow('% Massa Magra', '33,10 Kg', 'Melhorar'),
                      _buildMeasurementRow('Massa Magra', '1,00', 'Busca ideal'),
                      _buildMeasurementRow('Razão cintura/quadril', '1,00', 'Busca baixa'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPercentageIndicator(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMeasurementRow(String label, String value, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(status),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'ideal':
      case 'bom':
        return const Color(0xFF7ED957);
      case 'melhorar':
        return const Color(0xFFFF9E9E);
      case 'busca ideal':
      case 'busca baixa':
        return const Color(0xFFFFB74D);
      default:
        return Colors.grey;
    }
  }
}
