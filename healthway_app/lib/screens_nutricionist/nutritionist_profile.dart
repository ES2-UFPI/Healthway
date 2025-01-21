import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';

class NutritionistProfileScreen extends StatefulWidget {
  final Object userData;

  const NutritionistProfileScreen({super.key, required this.userData});

  @override
  State<NutritionistProfileScreen> createState() =>
      _NutritionistProfileScreenState();
}

class _NutritionistProfileScreenState extends State<NutritionistProfileScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  // Mock data - replace with actual data fetching in a real app
  String nome = 'Dr. Silva';
  String email = 'dr.silva@email.com';
  String cpf = '123.456.789-00';
  String crn = 'CRN-1 12345';
  String especialidade = 'Nutrição Esportiva';
  String fotoPerfil = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  // Discard changes
                  _isEditing = false;
                } else {
                  _isEditing = true;
                }
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(),
                SizedBox(height: 24),
                _buildInfoSection(),
                SizedBox(height: 24),
                _buildActionButtons()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _isEditing
          ? FloatingActionButton(
              onPressed: _saveChanges,
              backgroundColor: kPrimaryColor,
              child: Icon(Icons.save),
            )
          : null,
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: kPrimaryColor,
                backgroundImage:
                    fotoPerfil.isNotEmpty ? NetworkImage(fotoPerfil) : null,
                child: fotoPerfil.isEmpty
                    ? Text(
                        nome.isNotEmpty ? nome[0].toUpperCase() : '?',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    : null,
              ),
              if (!_isEditing)
                Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.white),
                    onPressed: () {
                      // Implement image picking functionality
                    },
                  ),
                ),
            ],
          ),
          SizedBox(height: 16),
          _isEditing
              ? TextFormField(
                  initialValue: nome,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => nome = value,
                )
              : Text(
                  nome,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
          SizedBox(height: 8),
          _isEditing
              ? TextFormField(
                  initialValue: email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  onChanged: (value) => email = value,
                )
              : Text(
                  email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInfoRow('CPF', cpf, (value) => cpf = value),
            _buildInfoRow('CRN', crn, (value) => crn = value),
            _buildInfoRow('Especialidade', especialidade,
                (value) => especialidade = value),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          _isEditing
              ? SizedBox(
                  width: 200,
                  child: TextFormField(
                    initialValue: value,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                    ),
                    onChanged: onChanged,
                  ),
                )
              : Text(value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Navigate to detailed edit profile screen
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text('Editar Perfil Detalhado'),
        ),
        SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {
            // Navigate to change password screen
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: kPrimaryColor,
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            side: BorderSide(color: kPrimaryColor),
          ),
          child: Text('Alterar Senha'),
        ),
      ],
    );
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Save the changes
      setState(() {
        _isEditing = false;
      });
      // Show a snackbar to confirm changes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Perfil atualizado com sucesso!')),
      );
    }
  }
}
