import 'package:auto_control_panel/components/tarefa_list_tile.dart';
import 'package:auto_control_panel/providers/tarefa_provider.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tarefa_pk/projeto_tarefa_pk.dart';
import 'package:provider/provider.dart';
import 'tarefa_list_tile.dart';

class TarefaList extends StatelessWidget {
  const TarefaList({super.key});

  @override
  Widget build(BuildContext context) {
    final tarefProvider = context.watch<TarefaProvider>();
    final List<Tarefa> listaTarefa = tarefProvider.tarefass;

    if (listaTarefa.isEmpty) {
      tarefProvider.list();
    }

    return ListView.builder(
      itemCount: listaTarefa.length,
      itemBuilder: (context, index) {
        Tarefa tarefas = listaTarefa[index];
        return TarefaListTile(tarefas, index: index);
      },
    );
  }
}
