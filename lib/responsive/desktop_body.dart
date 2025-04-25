// Manages the screen layout for web/desktop
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/dweather_forecast.dart';
import '../pages/current_weather.dart';
import '../providers/weather_provider.dart';

class DesktopBody extends StatefulWidget {
  const DesktopBody({super.key});

  @override
  State<DesktopBody> createState() => _DesktopBodyState();
}

class _DesktopBodyState extends State<DesktopBody> {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    final weather = weatherProvider.weather;
    final unit = weatherProvider.unit;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: weather == null
          ? const Center(
              child:
                  CircularProgressIndicator()) // Roller to wait while fetching the weather information
          : Row(
              children: [
                // Sidebar displaying the current weather information
                SizedBox(
                  width: screenWidth * 0.25,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 10,
                    margin: const EdgeInsets.all(12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CurrentWeather(
                        //Current weather screen
                        weather: weather,
                        unit: unit,
                        onToggleUnit: weatherProvider.toggleUnit,
                      ),
                    ),
                  ),
                ),

                // Weather Forecast Information
                Expanded(
                  child: Container(
                    color: Colors.blueGrey.shade900,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DWeatherForecast(
                      weather: weather,
                      unit: unit,
                      onToggleUnit: weatherProvider.toggleUnit,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
