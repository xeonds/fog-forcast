import 'package:app/service/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                ListTile(
                  title: Text(
                    cityData.data['name'],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Current Weather: ${cityData.data['weather'][0]['description']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                ListTile(
                  title: const Text('Temperature'),
                  subtitle: Text('${cityData.data['main']['temp']}°C'),
                ),
                ListTile(
                  title: const Text('Feels Like'),
                  subtitle: Text('${cityData.data['main']['feels_like']}°C'),
                ),
                ListTile(
                  title: const Text('Humidity'),
                  subtitle: Text('${cityData.data['main']['humidity']}%'),
                ),
                ListTile(
                  title: const Text('Wind Speed'),
                  subtitle: Text('${cityData.data['wind']['speed']} m/s'),
                ),
              ],
            ),
    );
  }
}
