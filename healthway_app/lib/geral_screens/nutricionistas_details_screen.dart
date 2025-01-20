import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';
import '../models/nutricionista.dart';
import '../widgets/rating_stars.dart';
import '../widgets/review_card.dart';

class NutricionistaDetailScreen extends StatelessWidget {
  final Nutricionista nutricionista;

  const NutricionistaDetailScreen({super.key, required this.nutricionista});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(),
                  SizedBox(height: 16),
                  _buildAboutSection(),
                  SizedBox(height: 16),
                  _buildReviewsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement appointment scheduling
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Funcionalidade de agendamento em desenvolvimento')),
          );
        },
        icon: Icon(Icons.calendar_today),
        label: Text('Agendar Consulta'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(nutricionista.nome, style: TextStyle(color: Colors.white)),
        background: Image.network(
          'https://www.w3schools.com/w3images/avatar2.png',
          fit: BoxFit.cover,
        ),
      ),
      backgroundColor: kPrimaryColor,
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nutricionista.nome,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              nutricionista.especialidade,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 4),
                Text(
                  '${nutricionista.avaliacao.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 16),
                Icon(Icons.person, color: kPrimaryColor),
                SizedBox(width: 4),
                Text(
                  '${nutricionista.numeroClientes} clientes',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildInfoRow(Icons.email, nutricionista.email),
            SizedBox(height: 8),
            _buildInfoRow(Icons.badge, 'CRN: ${nutricionista.crn}'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: kPrimaryColor, size: 20),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sobre',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              nutricionista.sobre ??
                  'Informações sobre o nutricionista não disponíveis.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Avaliações',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            RatingStars(rating: nutricionista.avaliacao),
            SizedBox(height: 16),
            // Aqui você pode adicionar uma lista de ReviewCard widgets
            // representando as avaliações reais dos clientes
            ReviewCard(
              authorName: 'Maria Silva',
              rating: 5,
              comment: 'Excelente profissional! Muito atencioso e competente.',
              date: '10/05/2023',
            ),
            ReviewCard(
              authorName: 'João Santos',
              rating: 4,
              comment: 'Ótimo atendimento e resultados satisfatórios.',
              date: '05/05/2023',
            ),
            // Adicione mais ReviewCards conforme necessário
          ],
        ),
      ),
    );
  }
}

extension on Nutricionista {
  get avaliacao => 5.0;
  get sobre => "Sou um nutricionista muito bom";

  get numeroClientes => 12;
}
