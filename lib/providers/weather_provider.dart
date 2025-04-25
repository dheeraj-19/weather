// Provider to manage the state throughout the application
import 'package:flutter/material.dart';
import '../models/current_weather.dart';
import '../models/daily_weather.dart';
import '../models/hourly_weather.dart';
import '../models/weather_forecast.dart';
import '../service/weather_service.dart';

enum TempUnit { celsius, fahrenheit }

class WeatherProvider extends ChangeNotifier {
  // API Key
  final _weatherService = WeatherService('');

  Weather? _weather;
  TempUnit _unit = TempUnit.celsius;

  WeatherForecast? _forecast;

  WeatherForecast? get forecast => _forecast;
  List<HourlyWeather> get hourlyWeather => _forecast?.hourly ?? [];
  List<DailyWeather> get dailyWeather => _forecast?.daily ?? [];

  Weather? get weather => _weather;
  TempUnit get unit => _unit;
  String get unitSymbol => _unit == TempUnit.celsius ? '°C' : '°F';

  WeatherProvider() {
    fetchWeather();
  }

  // Function to call the service layer and fetch the weather information
  Future<void> fetchWeather() async {
    final position = await _weatherService.getLocation();
    final lat = position.latitude;
    final lon = position.longitude;
    final unitString = _unit == TempUnit.celsius ? "metric" : "imperial";

    try {
      final weatherData =
          await _weatherService.getWeatherCurrent(lat, lon, unitString);
      final forecastData =
          await _weatherService.getWeatherForecast(lat, lon, unitString);

      _weather = weatherData;
      _forecast = forecastData;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }

  // Function used to toggle the units between C and F
  void toggleUnit() {
    _unit = _unit == TempUnit.celsius ? TempUnit.fahrenheit : TempUnit.celsius;
    fetchWeather(); // Refresh the data with new unit
  }
}
