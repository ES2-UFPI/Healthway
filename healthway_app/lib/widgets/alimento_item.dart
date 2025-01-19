import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';
import '../models/alimento.dart';

class AlimentoItem extends StatelessWidget {
  final Alimento alimento;

  const AlimentoItem({super.key, required this.alimento});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.1), // Sombra suave
        color: Colors.white, // Cor de fundo do card
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título com nome e categoria do alimento
              Row(
                children: [
                  Icon(Icons.fastfood, color: kPrimaryColor), // Ícone de comida
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      alimento.descricao,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Categoria: ${alimento.categoria}',
                style: TextStyle(
                    color: Colors.grey[700]), // Cor mais suave para a categoria
              ),
              const Divider(), // Linha separadora

              // Informações nutricionais
              _buildNutritionalInfo(),
            ],
          ),
        ),
      ),
    );
  }

  // Função que constrói a listagem das informações nutricionais
  Widget _buildNutritionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informações Nutricionais:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        _buildNutritionalItem('Calorias', alimento.energiaKcal, 'Kcal'),
        _buildNutritionalItem('Carboidrato', alimento.carboidrato, 'g'),
        _buildNutritionalItem('Proteína', alimento.proteina, 'g'),
        _buildNutritionalItem('Lipídeos', alimento.lipideos, 'g'),
        _buildNutritionalItem('Fibra Alimentar', alimento.fibraAlimentar, 'g'),
        _buildNutritionalItem('Colesterol', alimento.colesterol, 'mg'),
        _buildNutritionalItem('Cálcio', alimento.calcio, 'mg'),
        _buildNutritionalItem('Ferro', alimento.ferro, 'mg'),
        _buildNutritionalItem('Potássio', alimento.potassio, 'mg'),
        _buildNutritionalItem('Magnésio', alimento.magnesio, 'mg'),
        _buildNutritionalItem('Zinco', alimento.zinco, 'mg'),
        const Divider(),
        _buildNutritionalItem('Umidade', alimento.umidade, '%'),
        _buildNutritionalItem('Cinzas', alimento.cinzas, 'g'),
      ],
    );
  }

  // Função auxiliar para exibir cada item nutricional de forma compacta
  Widget _buildNutritionalItem(String label, double? value, String unit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[800], fontSize: 14)),
          Text(
            value != null ? '$value $unit' : 'N/A',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
