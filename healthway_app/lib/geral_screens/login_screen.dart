// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:healthway_app/constants.dart';
import 'package:healthway_app/services/services_facade.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String _userType = 'Paciente';
  final ServicesFacade _servicesFacade = ServicesFacade();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentColor,
      appBar: AppBar(
        title: Text('Login',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Icon(Icons.lock_open, size: 100, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildTextField(_emailController, 'E-mail', Icons.email,
                        keyboardType: TextInputType.emailAddress),
                    SizedBox(height: 20),
                    _buildPasswordField(),
                    SizedBox(height: 20),
                    _buildUserTypeDropdown(),
                    SizedBox(height: 30),
                    _buildLoginButton(),
                    SizedBox(height: 20),
                    _buildSignupAsPatientButton(),
                    SizedBox(height: 10),
                    _buildSignupAsNutricionistButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {TextInputType? keyboardType}) {
    return TextFormField(
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
          fontSize: 16, fontWeight: FontWeight.w600, color: kTextColor),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, preencha este campo';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _senhaController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Senha',
        prefixIcon: Icon(Icons.lock, color: kPrimaryColor),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: kPrimaryColor,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
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
          fontSize: 16, fontWeight: FontWeight.w600, color: kTextColor),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira sua senha';
        }
        return null;
      },
    );
  }

  Widget _buildUserTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _userType,
      decoration: InputDecoration(
        labelText: 'Tipo de Usuário',
        prefixIcon: Icon(Icons.person, color: kPrimaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.white,
        labelStyle: TextStyle(color: kPrimaryColor),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      dropdownColor: Colors.white,
      items: ['Paciente', 'Nutricionista']
          .map((value) => DropdownMenuItem(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _userType = value!;
        });
      },
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: kTextColor),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
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
          : Text('Entrar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSignupAsPatientButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/signup_patient');
      },
      child: Text(
        'Cadastrar como paciente',
        style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSignupAsNutricionistButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/signup_nutritionist');
      },
      child: Text(
        'Cadastrar como nutricionista',
        style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String email = _emailController.text;
      String senha = _senhaController.text;
      String userType = _userType;

      // Call the login service
      // _servicesFacade
      //     .login(email: email, senha: senha, userType: userType)
      //     .then((userData) {
      //   if (userData != null) {
      //     if (_userType == 'Paciente') {
      //       Navigator.pushReplacementNamed(context, '/home_patient',
      //           arguments: userData);
      //     } else if (_userType == 'Nutricionista') {
      //       Navigator.pushReplacementNamed(context, '/home_nutritionist',
      //           arguments: userData);
      //     }
      //   } else {
      //     setState(() {
      //       _isLoading = false;
      //     });
      //     // Show error message
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //           content: Text('Falha no login. Verifique suas credenciais.')),
      //     );
      //   }
      // }).catchError((error) {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Erro ao fazer login: ${error.toString()}')),
      //   );
      // });

      var mockData = {
        'nome': 'John Doe',
        'email': 'exemplo@email.com',
        'dt_nascimento': '01/01/2000',
        'altura': 180,
        'peso': 75,
        'circunferencia_abdominal': 88,
        'massa_muscular': 6.5,
        'gordura_corporal': 15.5,
        'alergias': ['Amendoim', 'Leite'],
        'preferencias': ['Vegano'],
      };
      if (_userType == 'Paciente') {
        Navigator.pushReplacementNamed(context, '/home_patient',
            arguments: mockData);
      } else if (_userType == 'Nutricionista') {
        Navigator.pushReplacementNamed(context, '/home_nutritionist',
            arguments: mockData);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }
}
