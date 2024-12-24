import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../services/paciente_services.dart';

class CadastroPacienteScreen extends StatefulWidget {
  const CadastroPacienteScreen({super.key});

  @override
  _CadastroPacienteScreenState createState() => _CadastroPacienteScreenState();
}

class _CadastroPacienteScreenState extends State<CadastroPacienteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _pesoController = TextEditingController();
  final _circunferenciaAbdominalController = TextEditingController();
  final _gorduraCorporalController = TextEditingController();
  final _massaMuscularController = TextEditingController();
  final _alergiasController = TextEditingController();
  final _preferenciasController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  String? _sexo;
  DateTime? _dataNascimento;

  final PacienteService _pacienteService = PacienteService();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F7F8),
      appBar: AppBar(
        title: Text('Cadastro de Paciente', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF31BAC2),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xFF31BAC2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Icon(Icons.person_add, size: 80, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField(_nomeController, 'Nome completo', Icons.person),
                    _buildTextField(_emailController, 'E-mail', Icons.email, keyboardType: TextInputType.emailAddress),
                    _buildTextField(_cpfController, 'CPF', Icons.badge, inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
                    _buildDateField(),
                    _buildDropdownField(),
                    _buildMeasurementFields(),
                    _buildTextField(_alergiasController, 'Alergias', Icons.warning),
                    _buildTextField(_preferenciasController, 'Preferências Alimentares', Icons.restaurant),
                    _buildPasswordFields(),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Color(0xFF31BAC2),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Cadastrar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {TextInputType? keyboardType, List<TextInputFormatter>? inputFormatters}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF31BAC2)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Color(0xFF31BAC2)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        style: TextStyle(fontSize: 16),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, preencha este campo';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: _dataNascimentoController,
        decoration: InputDecoration(
          labelText: 'Data de Nascimento',
          prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF31BAC2)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Color(0xFF31BAC2)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        style: TextStyle(fontSize: 16),
        readOnly: true,
        onTap: () async {
          final pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: Color(0xFF31BAC2),
                  hintColor: Color(0xFF31BAC2),
                  colorScheme: ColorScheme.light(primary: Color(0xFF31BAC2)),
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );
          if (pickedDate != null) {
            setState(() {
              _dataNascimento = pickedDate;
              _dataNascimentoController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, selecione a data de nascimento';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        value: _sexo,
        decoration: InputDecoration(
          labelText: 'Sexo',
          prefixIcon: Icon(Icons.wc, color: Color(0xFF31BAC2)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Color(0xFF31BAC2)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        style: TextStyle(fontSize: 16, color: Colors.black),
        items: ['Masculino', 'Feminino', 'Outro']
            .map((label) => DropdownMenuItem(
          child: Text(label),
          value: label,
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _sexo = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, selecione o sexo';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildMeasurementFields() {
    return Card(
      elevation: 4,
      color: Color(0xFFF0FAFB),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medidas Corporais',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF31BAC2)),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildMeasurementField(_alturaController, 'Altura (cm)', Icons.height)),
                SizedBox(width: 16),
                Expanded(child: _buildMeasurementField(_pesoController, 'Peso (kg)', Icons.fitness_center)),
              ],
            ),
            SizedBox(height: 16),
            _buildMeasurementField(_circunferenciaAbdominalController, 'Circunferência Abdominal (cm)', Icons.straighten),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildMeasurementField(_gorduraCorporalController, 'Gordura Corporal (%)', Icons.percent)),
                SizedBox(width: 16),
                Expanded(child: _buildMeasurementField(_massaMuscularController, 'Massa Muscular (kg)', Icons.fitness_center)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF31BAC2)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0xFF31BAC2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Color(0xFF31BAC2), width: 2),
        ),
        labelStyle: TextStyle(color: Color(0xFF31BAC2)),
      ),
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 16),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Preencha este campo';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordFields() {
    return Card(
      elevation: 4,
      color: Color(0xFFF0FAFB),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Segurança',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF31BAC2)),
            ),
            SizedBox(height: 16),
            _buildPasswordField(_senhaController, 'Senha', _obscurePassword, () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            }),
            SizedBox(height: 16),
            _buildPasswordField(_confirmarSenhaController, 'Confirmar Senha', _obscureConfirmPassword, () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label, bool obscureText, Function() onTap) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.lock, color: Color(0xFF31BAC2)),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Color(0xFF31BAC2),
          ),
          onPressed: onTap,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: Color(0xFF31BAC2)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      style: TextStyle(fontSize: 16),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira uma senha';
        }
        return null;
      },
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_senhaController.text != _confirmarSenhaController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('As senhas não coincidem')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        await _pacienteService.cadastrarPaciente(
          nome: _nomeController.text,
          email: _emailController.text,
          cpf: _cpfController.text,
          dataNascimento: _dataNascimentoController.text,
          sexo: _sexo!,
          altura: double.parse(_alturaController.text),
          peso: double.parse(_pesoController.text),
          circunferenciaAbdominal: double.parse(_circunferenciaAbdominalController.text),
          gorduraCorporal: double.parse(_gorduraCorporalController.text),
          massaMuscular: double.parse(_massaMuscularController.text),
          alergias: _alergiasController.text,
          preferencias: _preferenciasController.text,
          senha: _senhaController.text,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Paciente cadastrado com sucesso!')),
        );

        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar paciente: ${e.toString()}')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _dataNascimentoController.dispose();
    _alturaController.dispose();
    _pesoController.dispose();
    _circunferenciaAbdominalController.dispose();
    _gorduraCorporalController.dispose();
    _massaMuscularController.dispose();
    _alergiasController.dispose();
    _preferenciasController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }
}

