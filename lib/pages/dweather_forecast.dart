// Forecast weather page for desktop layout
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/current_weather.dart';
import '../models/daily_weather.dart';
import '../models/hourly_weather.dart';
import '../providers/weather_provider.dart';

class DWeatherForecast extends StatelessWidget {
  const DWeatherForecast({
    super.key,
    required this.weather,
    required this.unit,
    required this.onToggleUnit,
  });

  final Weather weather;
  final TempUnit unit;
  final VoidCallback onToggleUnit;

  // Set the animation as per the condition
  String getWeatherAnimation(String? mainCondition) =>
      weatherAnimations[mainCondition?.toLowerCase()] ?? 'assets/clear.json';

  // Widget to display hourly weather information
  Widget hourlyForecastCard(List<HourlyWeather> hourly, double width) {
    final unitSymbol = unit == TempUnit.celsius ? "°C" : "°F";

    return Card(
      color: Colors.blue.withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 240,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading with icon
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(Icons.schedule, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Hourly Forecast",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Horizontal list layout
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: hourly.length.clamp(0, 24),
                itemBuilder: (context, index) {
                  final hour = hourly[index];
                  return Container(
                    width: width * 0.06,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Card(
                      // Card for each hour
                      color: Colors.blue.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Time
                            Text(
                              DateFormat.j().format(hour.time),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Weather condition and animation
                            Text(
                              hour.condition,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Lottie.asset(
                              getWeatherAnimation(hour.condition),
                              height: 40,
                              width: 40,
                            ),
                            // Temperature
                            Text(
                              'FL: ${hour.feelsLike.round()}$unitSymbol',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${hour.temp.round()}$unitSymbol',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display daily weather information
  Widget dailyForecastCard(List<DailyWeather> daily, double width) {
    final unitSymbol = unit == TempUnit.celsius ? "°C" : "°F";

    return Card(
      color: Colors.blue.withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        width: width * 0.40,
        height: 540,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading with icon
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "7-Day Forecast",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Vertical list
            Expanded(
              child: ListView.builder(
                itemCount: daily.length.clamp(0, 7),
                itemBuilder: (context, index) {
                  final day = daily[index];
                  return Card(
                    color: Colors.blue.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: 55,
                        child: Row(
                          children: [
                            // Day
                            Expanded(
                              child: Center(
                                child: Text(
                                  DateFormat.E().format(day.time),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // Weather condition and animation
                            Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      day.condition,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                    Lottie.asset(
                                      getWeatherAnimation(day.condition),
                                      height: 30,
                                      width: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Temperature
                            Expanded(
                              child: Center(
                                child: Text(
                                  'L: ${day.tempMin.round()}$unitSymbol / H: ${day.tempMax.round()}$unitSymbol',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to display other weather information
  Widget weatherInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required double width,
  }) {
    return Card(
      color: Colors.blue.withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: width * 0.12,
        height: width * 0.12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Card(
              color: Colors.blue.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    final hourlyWeather = weatherProvider.hourlyWeather;
    final dailyWeather = weatherProvider.dailyWeather;
    final width = MediaQuery.of(context).size.width;
    String windUnit =
        weatherProvider.unitSymbol == "°C" ? "meter/sec" : "miles/hour";

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          hourlyForecastCard(hourlyWeather, width),
          Row(
            children: [
              dailyForecastCard(dailyWeather, width),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        weatherInfoCard(
                          icon: Icons.wb_twilight,
                          title: "Sunrise/Sunset",
                          value:
                              "${DateFormat.jm().format(weather.sunrise)} / ${DateFormat.jm().format(weather.sunset)}",
                          width: width,
                        ),
                        weatherInfoCard(
                          icon: Icons.air,
                          title: "Wind",
                          value: "${weather.windSpeed} $windUnit",
                          width: width,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        weatherInfoCard(
                          icon: Icons.compress,
                          title: "Pressure",
                          value: "${weather.pressure} hPa",
                          width: width,
                        ),
                        weatherInfoCard(
                          icon: Icons.water_drop,
                          title: "Humidity",
                          value: "${weather.humidity}%",
                          width: width,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
