import 'dart:io';

import 'package:auto_control_panel/providers/tarefa_provider.dart';
import 'package:auto_control_panel/providers/weather_provider.dart';
import 'package:auto_control_panel/routes.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tarefa_pk/projeto_tarefa_pk.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:location/location.dart';

class TarefaEditForm extends StatelessWidget {
  TarefaEditForm({super.key, required this.index, required this.tarfs});

  final int index;
  final Tarefa tarfs;

  final cidadeedController = TextEditingController();
  final tempedController = TextEditingController();
  final umidadeedController = TextEditingController();

  Future<LocationData?> getLocation() async {
    Location location = Location();
    bool serviceEnabledLocation;
    PermissionStatus permissionStatus;

    serviceEnabledLocation = await location.serviceEnabled();
    if (!serviceEnabledLocation) {
      serviceEnabledLocation = await location.requestService();
      if (!serviceEnabledLocation) return null;
    }

    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) return null;
    }

    return location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final tarefaProvider = context.read<TarefaProvider>();
    final update = tarefaProvider.update;
    final weatherProvider = Provider.of<WeatherProvider>(context);

    final nomeController = TextEditingController(text: tarfs.nome.toString());
    final datahoraController =
        TextEditingController(text: tarfs.dataHora.toString());
    final geoController =
        TextEditingController(text: tarfs.geolocalizacao.toString());
    return SizedBox(
      //width: largura,
      child: Column(
        children: [
          TextField(
            controller: nomeController,
            decoration: const InputDecoration(
              hintText: 'Descrição da Tarefa',
            ),
          ),
          TextField(
            controller: datahoraController,
            decoration: const InputDecoration(
              hintText: 'YYYY-MM-DD HH:MM',
            ),
            inputFormatters: [
              MaskTextInputFormatter(
                mask: '####-##-## ##:##',
                filter: {"#": RegExp(r'[0-9]')},
              ),
            ],
          ),
          TextField(
            controller: geoController,
            decoration: const InputDecoration(
              hintText: 'Geolocalização',
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              if (nomeController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Informe a Descrição da Tarefa')));
              } else if (datahoraController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Informe a Data e Hora')));
              } else if (geoController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Informe a Geolocalização')));
              } else {
                tarfs.nome = nomeController.text;
                tarfs.dataHora = DateTime.parse(datahoraController.text);
                tarfs.geolocalizacao = geoController.text;
                update(tarfs);
                Navigator.pushNamed(context, Routes.HOME);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Editado com Sucesso')));
              }
            },
            child: const Text('Editar'),
          ),
          const Text(''),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              foregroundColor: Colors.black,
            ),
            onPressed: () {
              if (0 == 0) {
                weatherProvider.fetchWeather(geoController.text);

                double temperatura =
                    (weatherProvider.weather!.temperature - 273.15);

                cidadeedController.text =
                    "Cidade:${weatherProvider.weather!.description}";
                tempedController.text =
                    "Temperatura: ${temperatura.toStringAsFixed(0)}ºC";
                umidadeedController.text =
                    "Umidade: ${weatherProvider.weather!.humidity}%";
              }
            },
            child: const Text('Consultar Localização'),
          ),
          TextField(
            controller: cidadeedController,
            decoration: const InputDecoration(
              hintText: 'Cidade',
            ),
          ),
          TextField(
            controller: tempedController,
            decoration: const InputDecoration(
              hintText: 'Temperatura(ºC)',
            ),
          ),
          TextField(
            controller: umidadeedController,
            decoration: const InputDecoration(
              hintText: 'Umidade(%)',
            ),
          ),
          FutureBuilder<LocationData?>(
            future: getLocation(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              } else if (snapshot.hasData) {
                double? latitude = snapshot.data?.latitude;
                double? longitude = snapshot.data?.longitude;

                if (latitude != null && longitude != null) {
                  geoController.text = 'lat=$latitude&lon=$longitude';
                }
                return const Text("");
              } else {
                return const Text('Serviço Indisponível');
              }
            },
          ),
        ],
      ),
    );
  }
}
