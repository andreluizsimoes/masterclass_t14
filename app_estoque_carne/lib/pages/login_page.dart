import 'package:app_estoque_carne/models/funcionario.dart';
import 'package:app_estoque_carne/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nomeController = TextEditingController();

  void _entrar() {
    final nome = _nomeController.text.trim();
    if (nome.isNotEmpty) {
      final funcionario = Funcionario(id: Uuid().v4(), nome: nome);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(funcionario: funcionario),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // _removerDados(); // Limpa os dados ao iniciar o aplicativo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 250,
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome do Funcionário'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _entrar,
              child: Text('Entrar'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _removerDados() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('Freezers_sabor_morte');
    await prefs.remove('carnes_sabor_morte');
  }
}
