import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({Key? key}) : super(key: key);

  @override
  _PatientProfileScreenState createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  // Mock data - replace with actual data fetching in a real app
  String name = 'João Silva';
  String email = 'joao.silva@email.com';
  int age = 35;
  double height = 1.75;
  double weight = 70.0;
  String objective = 'Manutenção de peso';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        backgroundColor: const Color(0xFF31BAC2),
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
                _buildActionButtons(),
                SizedBox(height: 24),
                _buildHealthMetrics(),
                SizedBox(height: 24),
                _buildProgressChart(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _isEditing
          ? FloatingActionButton(
        onPressed: _saveChanges,
        backgroundColor: Color(0xFF31BAC2),
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
                backgroundColor: Color(0xFF31BAC2),
                backgroundImage: NetworkImage('https://example.com/profile_image.jpg'),
                child: Text(
                  name.isNotEmpty ? name[0].toUpperCase() : '?',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              if (!_isEditing)
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF31BAC2),
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
            initialValue: name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
            ),
            onChanged: (value) => name = value,
          )
              : Text(
            name,
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
            _buildInfoRow('Idade', '$age anos', (value) => age = int.parse(value)),
            _buildInfoRow('Altura', '${height.toStringAsFixed(2)} m', (value) => height = double.parse(value)),
            _buildInfoRow('Peso', '${weight.toStringAsFixed(1)} kg', (value) => weight = double.parse(value)),
            _buildInfoRow('IMC', '${_calculateBMI().toStringAsFixed(1)} (${_getBMICategory()})', null),
            _buildInfoRow('Objetivo', objective, (value) => objective = value),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, Function(String)? onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          _isEditing && onChanged != null
              ? SizedBox(
            width: 120,
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
            backgroundColor: Color(0xFF31BAC2),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text('Editar Perfil Detalhado'),
        ),
        SizedBox(height: 12),
        OutlinedButton(
          onPressed: () {
            // Navigate to change password screen
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Color(0xFF31BAC2),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            side: BorderSide(color: Color(0xFF31BAC2)),
          ),
          child: Text('Alterar Senha'),
        ),
      ],
    );
  }

  Widget _buildHealthMetrics() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Métricas de Saúde',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildMetricItem('Pressão Arterial', '120/80 mmHg'),
            _buildMetricItem('Glicemia em Jejum', '90 mg/dL'),
            _buildMetricItem('Colesterol Total', '180 mg/dL'),
            _buildMetricItem('Triglicerídeos', '150 mg/dL'),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF31BAC2))),
        ],
      ),
    );
  }

  Widget _buildProgressChart() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Progresso de Peso',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              child: _buildWeightChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightChart() {
    // This is a placeholder for the chart
    // You should implement an actual chart using a charting library
    return Center(
      child: Text('Gráfico de Progresso de Peso'),
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

  double _calculateBMI() {
    return weight / (height * height);
  }

  String _getBMICategory() {
    double bmi = _calculateBMI();
    if (bmi < 18.5) return 'Abaixo do peso';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Sobrepeso';
    return 'Obeso';
  }
}

