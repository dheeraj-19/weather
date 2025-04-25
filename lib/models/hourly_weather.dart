// Function to store the hourly weather information
class HourlyWeather {
  final DateTime time;
  final double feelsLike;
  final double temp;
  final String condition;

  HourlyWeather({
    required this.time,
    required this.feelsLike,
    required this.temp,
    required this.condition,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      feelsLike: (json['feels_like'] as num).toDouble(),
      temp: (json['temp'] as num).toDouble(),
      condition: json['weather'][0]['main'],
    );
  }
}
