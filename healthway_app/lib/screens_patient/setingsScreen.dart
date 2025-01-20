import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'Português';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionHeader('Preferências do Aplicativo'),
            _buildSettingItem(
              title: 'Notificações',
              subtitle: 'Ativar notificações push',
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
                activeColor: kPrimaryColor,
              ),
            ),
            _buildSettingItem(
              title: 'Modo Escuro',
              subtitle: 'Ativar tema escuro',
              trailing: Switch(
                value: _darkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _darkModeEnabled = value;
                  });
                },
                activeColor: kPrimaryColor,
              ),
            ),
            _buildSettingItem(
              title: 'Idioma',
              subtitle: _selectedLanguage,
              onTap: () {
                _showLanguageDialog();
              },
            ),
            const Divider(),
            _buildSectionHeader('Privacidade e Segurança'),
            _buildSettingItem(
              title: 'Alterar Senha',
              onTap: () {
                // Implementar lógica para alterar senha
              },
            ),
            _buildSettingItem(
              title: 'Política de Privacidade',
              onTap: () {
                // Navegar para a página de política de privacidade
              },
            ),
            const Divider(),
            _buildSectionHeader('Sobre o Aplicativo'),
            _buildSettingItem(
              title: 'Versão do Aplicativo',
              subtitle: '1.0.0',
            ),
            _buildSettingItem(
              title: 'Termos de Uso',
              onTap: () {
                // Navegar para a página de termos de uso
              },
            ),
            _buildSettingItem(
              title: 'Licenças de Código Aberto',
              onTap: () {
                // Mostrar licenças de código aberto
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Implementar lógica de logout
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Sair da Conta'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecione o Idioma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption('Português'),
              _buildLanguageOption('English'),
              _buildLanguageOption('Español'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language) {
    return ListTile(
      title: Text(language),
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
        Navigator.of(context).pop();
      },
      trailing: _selectedLanguage == language
          ? const Icon(Icons.check, color: kPrimaryColor)
          : null,
    );
  }
}
