import 'dart:convert';

import 'package:auto_control_panel/components/tarefa_form.dart';
import 'package:auto_control_panel/providers/tarefa_provider.dart';
import 'package:auto_control_panel/routes.dart';
import 'package:auto_control_panel/screens/about_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../components/tarefa_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text("Lista de Tarefas"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.ABOUT).then((value) {});
                },
                icon: const Icon(Icons.info))
          ]),
      body: const TarefaList(),
      drawer: Drawer(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.add_task),
              title: const Text("Nova Tarefa"),
              trailing: const Icon(Icons.arrow_right),
              onTap: () => {
                Navigator.pushNamed(context, Routes.FORM),
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("Sobre Nós"),
              trailing: const Icon(Icons.arrow_right),
              onTap: () => {
                Navigator.pushNamed(context, Routes.ABOUT),
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              trailing: const Icon(Icons.arrow_right),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, Routes.SIGNIN)
                    .then((value) {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
