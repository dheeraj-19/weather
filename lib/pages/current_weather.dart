// Current weather page layout
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/current_weather.dart';

import '../constants.dart';
import '../providers/weather_provider.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather(
      {super.key,
      required Weather weather,
      required TempUnit unit,
      required void Function() onToggleUnit});

  // Set the animation as per the condition
  String getWeatherAnimation(String? mainCondition) =>
      weatherAnimations[mainCondition?.toLowerCase()] ?? 'assets/clear.json';

  // Set the background image as per the condition
  String getBackgroundImage(String? mainCondition) =>
      weatherBackground[mainCondition?.toLowerCase()] ?? 'assets/clear.json';

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final weather = weatherProvider.weather;
    final unit = weatherProvider.unit;
    final unitSymbol = unit == TempUnit.celsius ? '°C' : '°F';

    if (weather == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          // Background image based on weather
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(getBackgroundImage(weather.mainCondition)),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient overlay for readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Toggle Unit Button
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: weatherProvider.toggleUnit,
                      icon: const Icon(Icons.swap_horiz, color: Colors.white),
                      label: Text(
                        unit == TempUnit.celsius
                            ? "Celsius (°C)"
                            : "Fahrenheit (°F)",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Weather Condition
                  Text(
                    weather.mainCondition,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // City Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.location_on,
                          color: Colors.white70, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        weather.cityName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Weather Animation
                  SizedBox(
                    height: 150,
                    child: Lottie.asset(
                      getWeatherAnimation(weather.mainCondition),
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Main feels like temperature
                  const Text(
                    'Feels Like',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  Text(
                    '${weather.feelsLike.round()}$unitSymbol',
                    style: const TextStyle(
                      fontSize: 90,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Temperature
                  Text(
                    '${weather.temperature.round()}$unitSymbol',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // High / Low temperatures
                  Text(
                    'L: ${weather.tempMin.round()}$unitSymbol  H: ${weather.tempMax.round()}$unitSymbol',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
