import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthway_app/models/nutricionista.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:healthway_app/services/services_facade.dart';

class CadastroNutricionistaScreen extends StatefulWidget {
  const CadastroNutricionistaScreen({super.key});

  @override
  State<CadastroNutricionistaScreen> createState() =>
      _CadastroNutricionistaScreenState();
}

class _CadastroNutricionistaScreenState
    extends State<CadastroNutricionistaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _crnController = TextEditingController();
  final _especialidadeController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();

  File? _fotoPerfil;
  File? _fotoDocumento;

  final ServicesFacade _servicesFacade = ServicesFacade();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6F7F8),
      appBar: AppBar(
        title: Text('Cadastro de Nutricionista',
            style: TextStyle(fontWeight: FontWeight.bold)),
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
                    _buildTextField(
                        _nomeController, 'Nome completo', Icons.person),
                    _buildTextField(_emailController, 'E-mail', Icons.email,
                        keyboardType: TextInputType.emailAddress),
                    _buildTextField(_cpfController, 'CPF', Icons.badge,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ]),
                    _buildTextField(
                        _crnController, 'CRN', Icons.card_membership),
                    _buildTextField(
                        _especialidadeController, 'Especialidade', Icons.star),
                    SizedBox(height: 20),
                    _buildImageUploadField(
                        'Foto de Perfil', _fotoPerfil, _pickProfileImage),
                    SizedBox(height: 20),
                    _buildImageUploadField('Foto do Documento', _fotoDocumento,
                        _pickDocumentImage),
                    SizedBox(height: 20),
                    _buildPasswordFields(),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF31BAC2),
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

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters}) {
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

  Widget _buildImageUploadField(String label, File? image, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xFF31BAC2), width: 2),
        ),
        child: image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 50, color: Color(0xFF31BAC2)),
                  SizedBox(height: 10),
                  Text(label,
                      style: TextStyle(
                          color: Color(0xFF31BAC2),
                          fontWeight: FontWeight.bold)),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Image.file(image, fit: BoxFit.cover),
              ),
      ),
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
                  color: Color(0xFF31BAC2)),
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

  Future<void> _pickProfileImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _fotoPerfil = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDocumentImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _fotoDocumento = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_fotoPerfil == null || _fotoDocumento == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Por favor, selecione as fotos de perfil e documento')),
        );
        return;
      }

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
        await _servicesFacade.cadastrar(Nutricionista(
          nome: _nomeController.text,
          email: _emailController.text,
          cpf: _cpfController.text,
          crn: _crnController.text,
          especialidade: _especialidadeController.text,
          senha: _senhaController.text,
        ));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nutricionista cadastrado com sucesso!')),
        );

        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Erro ao cadastrar nutricionista: ${e.toString()}')),
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
    _crnController.dispose();
    _especialidadeController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }
}
