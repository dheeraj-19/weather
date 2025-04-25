// Forecast weather page for mobile layout
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather/models/current_weather.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/daily_weather.dart';
import '../models/hourly_weather.dart';
import '../providers/weather_provider.dart';

class MWeatherForecast extends StatelessWidget {
  const MWeatherForecast(
      {super.key,
      required Weather weather,
      required TempUnit unit,
      required Null Function() onToggleUnit});

  // Set the animation as per the condition
  String getWeatherAnimation(String? mainCondition) =>
      weatherAnimations[mainCondition?.toLowerCase()] ?? 'assets/clear.json';

  // Widget to display hourly weather information
  Widget hourlyForecastCard(List<HourlyWeather> hourly, TempUnit unit) {
    String unitSymbol = unit == TempUnit.celsius ? "°C" : "°F";

    return Card(
      color: Colors.blue.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  Icon(Icons.schedule, color: Colors.white, size: 20),
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
                  return Card(
                    // Card for each hour
                    color: Colors.blue.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Time
                          Text(
                            DateFormat.j().format(hour.time),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Weather condition and animation
                          Text(
                            hour.condition,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Lottie.asset(
                            getWeatherAnimation(hour.condition),
                            height: 40,
                            width: 40,
                          ),
                          const SizedBox(height: 8),
                          // Temperature
                          Text(
                            'FL: ${hour.feelsLike.round()}$unitSymbol',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            '${hour.temp.round()}$unitSymbol',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
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
  Widget dailyForecastCard(List<DailyWeather> daily, TempUnit unit) {
    String unitSymbol = unit == TempUnit.celsius ? "°C" : "°F";

    return Card(
      color: Colors.blue.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  Icon(Icons.calendar_today, color: Colors.white, size: 20),
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
            // Horizontal list
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: daily.length.clamp(0, 7),
                itemBuilder: (context, index) {
                  final day = daily[index];
                  return Card(
                    color: Colors.blue.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Day
                          Text(
                            DateFormat.E().format(day.time),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Weather condition and animation
                          Text(
                            day.condition,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Lottie.asset(
                            getWeatherAnimation(day.condition),
                            height: 40,
                            width: 40,
                          ),
                          const SizedBox(height: 8),
                          // Temperature
                          Text(
                            'L: ${day.tempMin.round()}$unitSymbol',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'H: ${day.tempMax.round()}$unitSymbol',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
  }) {
    return Card(
      color: Colors.blue.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(8),
      child: SizedBox(
        width: 165,
        height: 150,
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
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
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
    final weather = weatherProvider.weather;
    final hourlyWeather = weatherProvider.hourlyWeather;
    final dailyWeather = weatherProvider.dailyWeather;
    String windUnit =
        weatherProvider.unitSymbol == "°C" ? "meter/sec" : "miles/hour";

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blueGrey.shade900,
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<WeatherProvider>().fetchWeather();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              snap: false,
              backgroundColor: Colors.blueGrey.shade800,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  weather!.cityName,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              leading: const BackButton(color: Colors.white),
              actions: [
                TextButton.icon(
                  onPressed: weatherProvider.toggleUnit,
                  icon: const Icon(Icons.swap_horiz, color: Colors.white),
                  label: Text(
                    weatherProvider.unit == TempUnit.celsius ? "°C" : "°F",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      color: Colors.blue.withOpacity(0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  weather.mainCondition,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Lottie.asset(
                                    getWeatherAnimation(weather.mainCondition),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Feels Like',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text(
                                  '${weather.feelsLike.round()}${weatherProvider.unitSymbol}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '${weather.temperature.round()}${weatherProvider.unitSymbol}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 45),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'L: ${weather.tempMin.round()}${weatherProvider.unitSymbol}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text(
                                  'H: ${weather.tempMax.round()}${weatherProvider.unitSymbol}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  hourlyForecastCard(hourlyWeather, weatherProvider.unit),
                  dailyForecastCard(dailyWeather, weatherProvider.unit),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      weatherInfoCard(
                        icon: Icons.wb_twilight,
                        title: "Sunrise/Sunset",
                        value:
                            "${DateFormat.jm().format(weather.sunrise)} / ${DateFormat.jm().format(weather.sunset)}",
                      ),
                      weatherInfoCard(
                        icon: Icons.air,
                        title: "Wind",
                        value: "${weather.windSpeed} $windUnit",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      weatherInfoCard(
                        icon: Icons.compress,
                        title: "Pressure",
                        value: "${weather.pressure} hPa",
                      ),
                      weatherInfoCard(
                        icon: Icons.water_drop,
                        title: "Humidity",
                        value: "${weather.humidity}%",
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
