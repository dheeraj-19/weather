// Function to store the daily weather information
class DailyWeather {
  final DateTime time;
  final double tempMax;
  final double tempMin;
  final String condition;

  DailyWeather({
    required this.time,
    required this.tempMax,
    required this.tempMin,
    required this.condition,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      time: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      tempMax: (json['temp']['max'] as num).toDouble(),
      tempMin: (json['temp']['min'] as num).toDouble(),
      condition: json['weather'][0]['main'],
    );
  }
}
