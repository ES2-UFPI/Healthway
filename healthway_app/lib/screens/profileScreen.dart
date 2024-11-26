import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF31BAC2),
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
                  const Expanded(
                    child: Text(
                      'Perfil',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      // TODO: Implement edit functionality
                    },
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
                    children: [
                      // Profile Picture
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/profile_picture.jpg'),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'João Silva',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'joao.silva@email.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Profile Information
                      _buildInfoSection('Informações Pessoais', [
                        _buildInfoRow(Icons.calendar_today, 'Data de Nascimento', '15/05/1990'),
                        _buildInfoRow(Icons.height, 'Altura', '1.75m'),
                        _buildInfoRow(Icons.monitor_weight, 'Peso', '70kg'),
                      ]),
                      const SizedBox(height: 24),
                      _buildInfoSection('Endereço', [
                        _buildInfoRow(Icons.location_on, 'Rua', 'Av. Paulista, 1000'),
                        _buildInfoRow(Icons.location_city, 'Cidade', 'São Paulo'),
                        _buildInfoRow(Icons.map, 'Estado', 'SP'),
                        _buildInfoRow(Icons.flag, 'País', 'Brasil'),
                      ]),
                      const SizedBox(height: 24),
                      _buildInfoSection('Configurações', [
                        _buildSettingsRow(Icons.notifications, 'Notificações', true),
                        _buildSettingsRow(Icons.dark_mode, 'Modo Escuro', false),
                      ]),
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

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF31BAC2), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsRow(IconData icon, String label, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF31BAC2), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: (newValue) {
              // TODO: Implement settings change functionality
            },
            activeColor: const Color(0xFF31BAC2),
          ),
        ],
      ),
    );
  }
}

