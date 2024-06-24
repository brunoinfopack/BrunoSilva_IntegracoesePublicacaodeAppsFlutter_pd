import 'package:auto_control_panel/components/tarefa_form.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var appBar = AppBar(
      title: const Text('Nova Tarefa'),
      backgroundColor: Colors.blueAccent,
    );
    final alturaDisp = mediaQuery.size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return SizedBox(
      height: alturaDisp,
      child: Scaffold(
        body: TarefaForm(),
      ),
    );
  }
}
