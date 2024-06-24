import 'package:auto_control_panel/providers/tarefa_provider.dart';
import 'package:auto_control_panel/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:auto_control_panel/routes.dart';
import 'package:intl/intl.dart';
import 'package:projeto_tarefa_pk/projeto_tarefa_pk.dart';
import 'package:provider/provider.dart';

class TarefaListTile extends StatelessWidget {
  const TarefaListTile(
    this.tarfs, {
    super.key,
    required this.index,
  });

  final Tarefa tarfs;
  final int index;

  @override
  Widget build(BuildContext context) {
    final tarfsProvider = context.watch<TarefaProvider>();

    String name = tarfs.nome;
    DateTime dtHora = tarfs.dataHora;
    String geoloc = tarfs.geolocalizacao;

    return ListTile(
      leading: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () {
          tarfsProvider.delete(tarfs);
        },
      ),
      title: Text('Descrição: $name'),
      subtitle: Text('Data: $dtHora'),
      trailing: Column(
        children: [
          Text('${tarfs.id}'),
          Text('Latitude e Longitude $geoloc'),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.DETAILS,
          arguments: {'tarefa': tarfs, 'index': index},
        );
        // Navigator.push(context,
        //   MaterialPageRoute(builder: (context) {
        //     return DetailsScreen();
        //   })
        // );
      },
    );
  }
}
