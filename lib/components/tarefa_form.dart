import 'dart:io';
import 'package:auto_control_panel/providers/tarefa_provider.dart';
import 'package:auto_control_panel/providers/weather_provider.dart';
import 'package:auto_control_panel/routes.dart';
import 'package:flutter/material.dart';
import 'package:projeto_tarefa_pk/projeto_tarefa_pk.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:location/location.dart';

class TarefaForm extends StatelessWidget {
  TarefaForm({super.key});

  final nomeController = TextEditingController();
  final datahoraController = TextEditingController();
  final geoController = TextEditingController();
  final cidadeController = TextEditingController();
  final tempController = TextEditingController();
  final umidadeController = TextEditingController();

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
    final tarefaProvider = context.watch<TarefaProvider>();
    final insert = tarefaProvider.insert;
    final weatherProvider = Provider.of<WeatherProvider>(context);

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
          const Text(''),
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
                String name = nomeController.text;
                DateTime datehour = DateTime.parse(datahoraController.text);
                String geoloc = geoController.text;
                final tarefs = Tarefa(name, datehour, geoloc);

                insert(tarefs);
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Salvo com Sucesso')));
                Navigator.pushNamed(context, Routes.HOME);
              }
            },
            child: const Text('Salvar'),
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

                cidadeController.text = "Cidade:${weatherProvider.weather!.description}";
                tempController.text= "Temperatura: ${temperatura.toStringAsFixed(0)}ºC";
                umidadeController.text= "Umidade: ${weatherProvider.weather!.humidity}%";
              }
            },
            child: const Text('Consultar Localização'),
          ),
          TextField(
            controller: cidadeController,
            decoration: const InputDecoration(
              hintText: 'Cidade',
            ),
          ),
          TextField(
            controller: tempController,
            decoration: const InputDecoration(
              hintText: 'Temperatura(ºC)',
            ),
          ),
          TextField(
            controller: umidadeController,
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
