// Model to store the current weather information

class Weather {
  final String cityName;
  final double feelsLike;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String mainCondition;
  final DateTime sunrise;
  final DateTime sunset;
  final double windSpeed;
  final double pressure;
  final double humidity;

  Weather({
    required this.cityName,
    required this.feelsLike,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.mainCondition,
    required this.sunrise,
    required this.sunset,
    required this.windSpeed,
    required this.pressure,
    required this.humidity,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        feelsLike: json['main']['feels_like'].toDouble(),
        temperature: json['main']['temp'].toDouble(),
        tempMin: json['main']['temp_min'].toDouble(),
        tempMax: json['main']['temp_max'].toDouble(),
        mainCondition: json['weather'][0]['main'],
        sunrise:
            DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
        sunset:
            DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
        windSpeed: (json['wind']['speed'] as num).toDouble(),
        pressure: (json['main']['pressure'] as num).toDouble(),
        humidity: (json['main']['humidity'] as num).toDouble());
  }
}
