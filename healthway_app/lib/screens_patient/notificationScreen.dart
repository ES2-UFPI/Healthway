import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Notificações'),
        backgroundColor: const Color(0xFF31BAC2),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildNotificationItem(
              'Nova mensagem do seu nutricionista',
              'Dr. Silva enviou uma mensagem sobre seu plano alimentar.',
              '2 min atrás',
              Icons.message,
            ),
            _buildNotificationItem(
              'Lembrete de consulta',
              'Sua próxima consulta é amanhã às 14:00.',
              '1 hora atrás',
              Icons.calendar_today,
            ),
            _buildNotificationItem(
              'Meta de peso atingida!',
              'Parabéns! Você atingiu sua meta de peso semanal.',
              '1 dia atrás',
              Icons.emoji_events,
            ),
            _buildNotificationItem(
              'Novo artigo disponível',
              'Leia sobre os benefícios da dieta mediterrânea.',
              '2 dias atrás',
              Icons.article,
            ),
            _buildNotificationItem(
              'Atualização do plano alimentar',
              'Seu nutricionista fez alterações no seu plano.',
              '3 dias atrás',
              Icons.restaurant_menu,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String description, String time, IconData icon) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Color(0xFF31BAC2).withOpacity(0.1),
          child: Icon(icon, color: Color(0xFF31BAC2)),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(description),
            SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        onTap: () {
          // Ação ao tocar na notificação
        },
      ),
    );
  }
}

