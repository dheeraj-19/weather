// Service to manage the API calls
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;

import '../models/current_weather.dart';
import '../models/daily_weather.dart';
import '../models/hourly_weather.dart';
import '../models/weather_forecast.dart';

class WeatherService {
  // API URL for current weather
  static const currentWeatherBaseURL =
      'http://api.openweathermap.org/data/2.5/weather';
  // API weather for forecast information
  static const openWeatherBaseURL =
      'https://api.openweathermap.org/data/3.0/onecall';
  final String apiKey;

  // Getting the API key from the provider
  WeatherService(this.apiKey);

  // Fuction to call the current weather api and store it into the model
  Future<Weather> getWeatherCurrent(double lat, double lon, String unit) async {
    final response = await http.get(Uri.parse(
        '$currentWeatherBaseURL?&lat=$lat&lon=$lon&appid=$apiKey&units=$unit'));

    if (response.statusCode == 200) {
      //print(response.body);
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  // Function to get the current location of the device
  Future<Position> getLocation() async {
    // Get permission from the user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  // Fuction to call the forecast weather api and store it into the model
  Future<WeatherForecast> getWeatherForecast(
      double lat, double lon, String unit) async {
    final url =
        '$openWeatherBaseURL?lat=$lat&lon=$lon&units=$unit&appid=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //debugPrint(response.body, wrapWidth: 1024);
      final data = jsonDecode(response.body);

      // hourly forecast
      final List hourlyJson = data['hourly'];

      // daily forecast
      final List dailyJson = data['daily'];

      final hourly =
          hourlyJson.map((json) => HourlyWeather.fromJson(json)).toList();
      final daily =
          dailyJson.map((json) => DailyWeather.fromJson(json)).toList();

      return WeatherForecast(hourly: hourly, daily: daily);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
