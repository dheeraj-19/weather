// Manages the screen layout for mobile's
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/current_weather.dart';
import '../pages/mweather_forecast.dart';
import '../providers/weather_provider.dart';

class MobileBody extends StatefulWidget {
  const MobileBody({super.key});

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    final weather = weatherProvider.weather;
    final unit = weatherProvider.unit;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: weatherProvider.fetchWeather, // Page refresh feature
        child: weather == null
            ? ListView(
                children: const [
                  Center(child: CircularProgressIndicator())
                ], // Roller to wait while fetching the weather information
              )
            : SingleChildScrollView(
                // Scroll view layout
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  // Displaying the current weather screen
                  child: CurrentWeather(
                    weather: weather,
                    unit: unit,
                    onToggleUnit: weatherProvider.toggleUnit,
                  ),
                ),
              ),
      ),
      // Button to go to the more details (forecast) section
      floatingActionButton: weather == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  // Direct to the Forecast page on the click of the button
                  MaterialPageRoute(
                    builder: (_) => MWeatherForecast(
                      weather: weather,
                      unit: unit,
                      onToggleUnit: () {
                        weatherProvider.toggleUnit();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
              backgroundColor: Colors.blueGrey.shade600,
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              label: const Text("More Details",
                  style: TextStyle(color: Colors.white)),
            ),
    );
  }
}
