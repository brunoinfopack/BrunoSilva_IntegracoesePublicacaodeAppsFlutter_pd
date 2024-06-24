import 'dart:io';

import 'package:auto_control_panel/providers/auth_provider.dart';
import 'package:auto_control_panel/routes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({super.key});

  //final emailController = TextEditingController();
  //final passwordController = TextEditingController();
  final _formKeyIn = GlobalKey<FormState>();
  String? emailin;
  String? passwordin;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = context.watch<AuthProvider>();
    String? message = authProvider.message;

    return Scaffold(
      body: Center(
        child: Form(
          key: _formKeyIn,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  key: const Key('TextFormFieldSigninEmail'),
                  onChanged: (value) {
                    emailin = value;
                  },
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Informe o email para cadastro.',
                      labelText: 'Email'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return 'Informe um email válido!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: TextFormField(
                  key: const Key('TextFormFieldSigninSenha'),
                  obscureText: true,
                  onChanged: (value) {
                    passwordin = value;
                  },
                  decoration: const InputDecoration(
                      icon: Icon(Icons.key),
                      hintText: 'Informe uma senha para cadastro.',
                      labelText: 'Senha'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Informe uma senha válido!';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  //String email = emailController.text;
                  //String password = passwordController.text;
                  if (_formKeyIn.currentState!.validate()) {
                    authProvider.signIn(emailin!, passwordin!).then((sucesso) {
                      if (sucesso) {
                        Navigator.pushReplacementNamed(context, Routes.HOME);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Erro ao autenticar o Usuário!')));
                      }
                    });
                  }
                },
                child: const Text("Acessar"),
              ),
              if (message != null) Text(message),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.SIGNUP);
                },
                child: const Text("Ainda não tenho cadastro!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
