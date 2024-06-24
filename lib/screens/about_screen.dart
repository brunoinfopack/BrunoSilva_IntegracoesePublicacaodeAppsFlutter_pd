import 'package:auto_control_panel/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, "Vai Curintia");
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.blueAccent,
        title: const Text("Sobre Nós"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context, "Lista de Tarefas");
            },
            icon: const Icon(Icons.home),
          )
        ],
      ),
      body: const Center(
        child: Text(
          "Projeto da Disciplina: \n Desenvolvimento Mobile com Flutter [24E2_2] \n Aluno: \n Bruno Rodrigues dos Santos Silva",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
