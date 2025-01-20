import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthway_app/models/paciente.dart';
import 'package:healthway_app/services/services_facade.dart';
import 'package:intl/intl.dart';

class PatientProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  const PatientProfileScreen({super.key, required this.userData});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
  bool _isEditing = false;
  bool _edited = false;
  final _formKey = GlobalKey<FormState>();
  static final ServicesFacade _servicesFacade = ServicesFacade();

  late String nome;
  late String email;
  late int idade;
  late double altura;
  late double peso;
  late double circunferenciaAbdominal;
  late double massaMuscular;
  late double gorduraCorporal;
  late List<String> preferencias;
  late List<String> alergias;

  @override
  void initState() {
    super.initState();
    preferencias = List<String>.from(widget.userData['preferencias']);
    alergias = List<String>.from(widget.userData['alergias']);
    nome = widget.userData['nome'];
    email = widget.userData['email'];
    var birthDate = widget.userData['dt_nascimento'];
    var ageDuration =
        DateTime.now().difference(DateFormat('dd/MM/yyyy').parse(birthDate));
    idade = ageDuration.inDays ~/ 365;
    altura = widget.userData['altura'].toDouble();
    peso = widget.userData['peso'].toDouble();
    circunferenciaAbdominal =
        widget.userData['circunferencia_abdominal'].toDouble();
    massaMuscular = widget.userData['massa_muscular'].toDouble();
    gorduraCorporal = widget.userData['gordura_corporal'].toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
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
                _buildAlergiasSection(),
                SizedBox(height: 24),
                _buildPreferenciasSection(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _edited
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
                child: Text(
                  nome.isNotEmpty ? nome[0].toUpperCase() : '?',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
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
          Text(
            nome,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor),
          ),
          SizedBox(height: 8),
          Text(
            email,
            style: TextStyle(
                fontSize: 16, color: kTextColor.withValues(alpha: 0.7)),
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
            _buildInfoRow('Idade', '$idade anos', null),
            _buildInfoRow('Altura', altura.toStringAsFixed(1), (value) {
              if (value.isNotEmpty) {
                _edited = true;
                altura = double.parse(value);
              }
            }),
            _buildInfoRow('Peso', peso.toStringAsFixed(1), (value) {
              if (value.isNotEmpty) {
                _edited = true;
                peso = double.parse(value);
              }
            }),
            _buildInfoRow(
                'IMC',
                '${_calculateBMI().toStringAsFixed(1)} (${_getBMICategory()})',
                null),
            _buildInfoRow('Circunferência Abdominal',
                circunferenciaAbdominal.toStringAsFixed(1), (value) {
              if (value.isNotEmpty) {
                _edited = true;
                circunferenciaAbdominal = double.parse(value);
              }
            }),
            _buildInfoRow('Massa Muscular', massaMuscular.toStringAsFixed(1),
                (value) {
              if (value.isNotEmpty) {
                _edited = true;
                massaMuscular = double.parse(value);
              }
            }),
            _buildInfoRow(
                'Gordura Corporal', gorduraCorporal.toStringAsFixed(1),
                (value) {
              if (value.isNotEmpty) {
                _edited = true;
                gorduraCorporal = double.parse(value);
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      String label, String value, Function(String)? onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16, color: kPrimaryColor),
              overflow: TextOverflow.visible,
            ),
          ),
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
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                    ],
                    onChanged: onChanged,
                  ),
                )
              : Text(value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAlergiasSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Alergias',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...alergias.map((alergia) => ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.fiber_manual_record,
                          size: 8, color: kPrimaryColor),
                      SizedBox(width: 8),
                      Text(
                        alergia,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  trailing: _isEditing
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _edited = true;
                              alergias.remove(alergia);
                            });
                          },
                        )
                      : null,
                )),
            if (_isEditing)
              TextField(
                decoration: InputDecoration(labelText: 'Adicionar Alergia'),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _edited = true;
                      alergias.add(value);
                    });
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenciasSection() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Preferências',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...preferencias.map((preferencia) => ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.fiber_manual_record,
                          size: 8, color: kPrimaryColor),
                      SizedBox(width: 8),
                      Text(
                        preferencia,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  trailing: _isEditing
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _edited = true;
                              preferencias.remove(preferencia);
                            });
                          },
                        )
                      : null,
                )),
            if (_isEditing)
              TextField(
                decoration: InputDecoration(labelText: 'Adicionar Preferência'),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      _edited = true;
                      preferencias.add(value);
                    });
                  }
                },
              ),
          ],
        ),
      ),
    );
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      try {
        // Save the changes
        setState(() {
          _edited = false;
        });
        widget.userData['altura'] = altura.toDouble();
        widget.userData['peso'] = peso.toDouble();
        widget.userData['circunferencia_abdominal'] =
            circunferenciaAbdominal.toDouble();
        widget.userData['massa_muscular'] = massaMuscular.toDouble();
        widget.userData['gordura_corporal'] = gorduraCorporal.toDouble();
        widget.userData['preferencias'] = preferencias;
        widget.userData['alergias'] = alergias;
        _servicesFacade.atualizar(Paciente.fromJson(widget.userData));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Perfil atualizado com sucesso')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar perfil: $e')),
        );
      }
    }
  }

  double _calculateBMI() {
    var altura = this.altura / 100;
    return peso / (altura * altura);
  }

  String _getBMICategory() {
    double bmi = _calculateBMI();
    if (bmi < 18.5) return 'Abaixo do peso';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Sobrepeso';
    return 'Obeso';
  }
}
