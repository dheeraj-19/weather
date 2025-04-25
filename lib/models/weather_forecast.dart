// Combines both the hourly and daily weather models into a single model
import 'package:weather/models/daily_weather.dart';

import 'hourly_weather.dart';

class WeatherForecast {
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;

  WeatherForecast({required this.hourly, required this.daily});
}
