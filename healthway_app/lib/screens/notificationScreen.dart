import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        backgroundColor: const Color(0xFF31BAC2),
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildNotificationItem(
              title: 'Nova mensagem do seu nutricionista',
              description:
                  'Dr. Silva enviou uma atualização sobre seu plano alimentar.',
              time: '2 min atrás',
              icon: Icons.message_outlined,
            ),
            _buildNotificationItem(
              title: 'Lembrete de consulta',
              description:
                  'Sua consulta com Dr. Oliveira está marcada para amanhã às 14:00.',
              time: '1 hora atrás',
              icon: Icons.calendar_today_outlined,
            ),
            _buildNotificationItem(
              title: 'Meta diária alcançada!',
              description:
                  'Parabéns! Você atingiu sua meta de passos para hoje.',
              time: '3 horas atrás',
              icon: Icons.emoji_events_outlined,
            ),
            _buildNotificationItem(
              title: 'Novo artigo disponível',
              description:
                  'Leia sobre os benefícios da meditação para sua saúde mental.',
              time: '5 horas atrás',
              icon: Icons.article_outlined,
            ),
            _buildNotificationItem(
              title: 'Atualização do aplicativo',
              description:
                  'Uma nova versão do aplicativo está disponível. Atualize agora!',
              time: '1 dia atrás',
              icon: Icons.system_update_outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String description,
    required String time,
    required IconData icon,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF31BAC2).withOpacity(0.1),
          child: Icon(icon, color: const Color(0xFF31BAC2)),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        onTap: () {
          // Implementar ação ao tocar na notificação
        },
      ),
    );
  }
}
