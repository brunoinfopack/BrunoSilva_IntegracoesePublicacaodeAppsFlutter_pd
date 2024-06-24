import 'package:flutter/material.dart';
import 'package:auto_control_panel/models/weather_model.dart';
import 'package:auto_control_panel/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  bool _loading = false;

  Weather? get weather => _weather;
  bool get loading => _loading;

  final WeatherService _weatherService = WeatherService();

  Future<void> fetchWeather(String city) async {
    _loading = true;
    notifyListeners();

    try {
      final weatherData = await _weatherService.fetchWeather(city);
      _weather = Weather.fromJson(weatherData);
    } catch (e) {
      print(e);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
