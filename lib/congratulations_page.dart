import 'package:flutter/material.dart';

class CongratulationsPage extends StatelessWidget {
  const CongratulationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 176, 244),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 229, 245, 3), // Cor do ícone de voltar
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 3, 176, 244), // Cor de fundo
      body: Center(
        child: Text(
          'Parabéns!',
          style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 229, 245, 3), // Cor da fonte),
        ),
      ),
    ),
    );
  }
}