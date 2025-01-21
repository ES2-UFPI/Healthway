import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthway_app/models/paciente.dart';
import 'package:intl/intl.dart';
import '../services/services_facade.dart';

class CadastroPacienteScreen extends StatefulWidget {
  const CadastroPacienteScreen({super.key});

  @override
  State<CadastroPacienteScreen> createState() => _CadastroPacienteScreenState();
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
  final List<TextEditingController> _alergiasController = [];
  final List<TextEditingController> _preferenciasController = [];
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  String? _sexo;

  // final PacienteService _pacienteService = PacienteService();
  final ServicesFacade _servicesFacade = ServicesFacade();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentColor,
      appBar: AppBar(
        title: Text('Cadastro de Paciente',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: kPrimaryColor,
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
                    _buildTextField(
                        _nomeController, 'Nome completo', Icons.person),
                    _buildTextField(_emailController, 'E-mail', Icons.email,
                        keyboardType: TextInputType.emailAddress),
                    _buildTextField(_cpfController, 'CPF', Icons.badge,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        maxLength: 11),
                    _buildDateField(),
                    _buildDropdownField(),
                    _buildMeasurementFields(),
                    _buildListField(
                        _alergiasController, 'Alergias', Icons.warning),
                    _buildListField(_preferenciasController, 'Preferências',
                        Icons.restaurant),
                    _buildPasswordFields(),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: kPrimaryColor,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Cadastrar',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
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

  Widget _buildListField(
      List<TextEditingController> controllerList, String label, IconData icon) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controllerList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controllerList[index],
                      decoration: InputDecoration(
                        labelText: '$label ${index + 1}',
                        prefixIcon: Icon(icon, color: kPrimaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: kPrimaryColor),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      style: TextStyle(fontSize: 16),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha este campo';
                        }
                        return null;
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        controllerList.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              controllerList.add(TextEditingController());
            });
          },
          icon: Icon(Icons.add, color: kPrimaryColor),
          label:
              Text('Adicionar $label', style: TextStyle(color: kPrimaryColor)),
        ),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      int? maxLength}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: kPrimaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        style: TextStyle(
            fontSize: 16, color: kTextColor, fontWeight: FontWeight.w500),
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        buildCounter: (context,
                {required currentLength, required isFocused, maxLength}) =>
            null,
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
          prefixIcon: Icon(Icons.calendar_today, color: kPrimaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        style: TextStyle(
            fontSize: 16, color: kTextColor, fontWeight: FontWeight.w500),
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
                  primaryColor: kPrimaryColor,
                  hintColor: kPrimaryColor,
                  colorScheme: ColorScheme.light(primary: kPrimaryColor),
                  buttonTheme:
                      ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );
          if (pickedDate != null) {
            setState(() {
              _dataNascimentoController.text =
                  DateFormat('dd/MM/yyyy').format(pickedDate);
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
          prefixIcon: Icon(Icons.wc, color: kPrimaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: kPrimaryColor),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        style: TextStyle(
            fontSize: 16, color: kTextColor, fontWeight: FontWeight.w500),
        items: ['Masculino', 'Feminino', 'Outro']
            .map((label) => DropdownMenuItem(
                  value: label,
                  child: Text(label),
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
    return Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Card(
          elevation: 4,
          color: Color(0xFFF0FAFB),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Medidas Corporais',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildMeasurementField(
                            _alturaController, 'Altura (cm)', Icons.height)),
                    SizedBox(width: 16),
                    Expanded(
                        child: _buildMeasurementField(_pesoController,
                            'Peso (kg)', Icons.fitness_center)),
                  ],
                ),
                SizedBox(height: 16),
                _buildMeasurementField(_circunferenciaAbdominalController,
                    'Circunferência Abdominal (cm)', Icons.straighten),
                SizedBox(height: 16),
                _buildMeasurementField(_gorduraCorporalController,
                    'Gordura Corporal (%)', Icons.percent),
                SizedBox(height: 16),
                _buildMeasurementField(_massaMuscularController,
                    'Massa Muscular (kg)', Icons.fitness_center),
              ],
            ),
          ),
        ));
  }

  Widget _buildMeasurementField(
      TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: kPrimaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: kPrimaryColor, width: 2),
        ),
        labelStyle: TextStyle(color: kPrimaryColor),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*(\,|\.)?\d*')),
      ],
      style: TextStyle(
          fontSize: 16, color: kTextColor, fontWeight: FontWeight.w500),
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
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor),
            ),
            SizedBox(height: 16),
            _buildPasswordField(_senhaController, 'Senha', _obscurePassword,
                () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            }),
            SizedBox(height: 16),
            _buildPasswordField(_confirmarSenhaController, 'Confirmar Senha',
                _obscureConfirmPassword, () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label,
      bool obscureText, Function() onTap) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.lock, color: kPrimaryColor),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: kPrimaryColor,
          ),
          onPressed: onTap,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: kPrimaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      style: TextStyle(
          fontSize: 16, color: kTextColor, fontWeight: FontWeight.w500),
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
        final dataNascimento =
            DateFormat('dd/MM/yyyy').parse(_dataNascimentoController.text);
        await _servicesFacade.cadastrar(Paciente(
          nome: _nomeController.text,
          email: _emailController.text,
          cpf: _cpfController.text,
          dataNascimento: DateFormat('dd/MM/yyyy').format(dataNascimento),
          sexo: _sexo!,
          altura: double.parse(_alturaController.text.replaceFirst(',', '.')),
          peso: double.parse(_pesoController.text.replaceFirst(',', '.')),
          circunferenciaAbdominal: double.parse(
              _circunferenciaAbdominalController.text.replaceFirst(',', '.')),
          gorduraCorporal: double.parse(
              _gorduraCorporalController.text.replaceFirst(',', '.')),
          massaMuscular: double.parse(
              _massaMuscularController.text.replaceFirst(',', '.')),
          alergias: _alergiasController.map((e) => e.text).toList(),
          preferencias: _preferenciasController.map((e) => e.text).toList(),
          senha: _senhaController.text,
        ));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Paciente cadastrado com sucesso!')),
        );

        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erro ao cadastrar paciente: ${e.toString()}')),
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
    for (var controller in _alergiasController) {
      controller.dispose();
    }
    for (var controller in _preferenciasController) {
      controller.dispose();
    }
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }
}
