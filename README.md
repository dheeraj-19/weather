# Weather App

The Weather App is a Flutter-based application that delivers real-time weather updates with a clean and responsive user interface. It allows users to search for cities manually or automatically fetch weather details based on the device's location. The app also features hourly and 7-day forecasts, as well as customizable temperature units (°C/°F).

## Features

- **Live Weather Updates:** Fetches current weather data from an API with temperature, wind speed, humidity, and condition.
- **Location-Based Search:** Automatically determines the user's location to show relevant weather data.
- **Hourly Forecast:** Allows users to view a 24H forecast of the weather conditions.
- **7-Day Forecast:** Displays an extended weather forecast for the upcoming days.
- **Temperature Unit Toggle:** Users can switch between Celsius and Fahrenheit.
- **Responsive UI:** Optimized for both mobile and desktop layouts using adaptive widgets.

## Demo



https://github.com/user-attachments/assets/eab78a68-21a9-4198-af2f-82fe9e86565b



https://youtu.be/ULgPmueOcb4

## Usage

### Granting Location Permissions
When the app is launched, it requests permission to access the device's location. This enables the app to show local weather automatically.

### Viewing the current weather
On granting permissions, Users can view the current weather information clearly with feels like as the main temperature.

### Viewing Detailed Weather
After fetching data from the API, the app displays:
- Current temperature and condition
- 24H hourly weather condition 
- Extended 7-day forecast in a scrollable format
- Sunrise/Sunset times
- Wind speed
- Humidity
- Pressure

### Switching Units
A toggle is available at the top right corner to switch between Celsius and Fahrenheit.


## Project Structure

The project follows a modular and scalable Flutter architecture:

<pre>
weather/
│── assets/             # Weather icons and background images
│── lib/
│   ├── models/         # Data models for weather and forecast
│   ├── pages/          # Screens like Home, Search, and Weather Details
│   ├── provider/       # State management using Provider
│   ├── responsive/     # Manage different layouts (mobile/web)
│   ├── service/        # API integration and logic
│   └── main.dart       # Application entry point
│── test/               # Unit and widget tests
│── pubspec.yaml        # Dependency and asset definitions
│── README.md           # Project overview and instructions
</pre>

## Dependencies

The app uses the following key Flutter packages:

- [`http`](https://pub.dev/packages/http): For making REST API calls to the weather API.
- [`provider`](https://pub.dev/packages/provider): For efficient and reactive state management.
- [`geolocator`](https://pub.dev/packages/geolocator): To fetch the current location of the user.
- [`flutter_svg`](https://pub.dev/packages/flutter_svg): To render SVG-based weather icons.
- [`intl`](https://pub.dev/packages/intl): For date formatting in forecasts.
- [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv): To manage API keys securely.

## Getting Started

To run the project locally:

```bash
git clone https://github.com/dheeraj-19/weather.git
cd weather
flutter pub get
flutter run

Remember to add your own API key in the provider
