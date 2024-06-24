class Weather {
  final String description;
  final double temperature;
  final int humidity;

  Weather({required this.description, required this.temperature, required this.humidity});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json['name'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
    );
  }
}