import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  final String cityName;
  final String temperature;
  final String weatherCondition;

  WeatherPage(
      {required this.cityName,
      required this.temperature,
      required this.weatherCondition});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cityName,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              temperature,
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 16),
            Text(
              weatherCondition,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
