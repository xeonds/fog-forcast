import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/service/weather_service.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cityData =
        Provider.of<WeatherService>(context, listen: true).selectedCity;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: cityData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      cityData.weatherData['name'].toString(),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Temperature: ${cityData.weatherData['main']['temp']}°C'),
                        Text(
                            'Description: ${cityData.weatherData['weather'][0]['description']}'),
                        Text(
                            'Humidity: ${cityData.weatherData['main']['humidity']}%'),
                        Text(
                            'Pressure: ${cityData.weatherData['main']['pressure']} hPa'),
                        // Add more weather data fields as needed
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Air Quality',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'AQI: ${cityData.airQualityData['list'][0]['main']['aqi']}'),
                        Text(
                            'CO: ${cityData.airQualityData['list'][0]['components']['co']}'),
                        Text(
                            'NO2: ${cityData.airQualityData['list'][0]['components']['no2']}'),
                        Text(
                            'O3: ${cityData.airQualityData['list'][0]['components']['o3']}'),
                        // Add more air quality data fields as needed
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<WeatherService>(context, listen: false).updateData();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
