import 'dart:convert';
import 'package:app/main.dart';
import 'package:app/service/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CityPage extends StatelessWidget {
  const CityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherService = Provider.of<WeatherService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cities'),
      ),
      body: ListView.builder(
        itemCount: weatherService.cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(weatherService.cities[index].name),
            onTap: () {
              weatherService.setSelectedCity(weatherService.cities[index]);
              HomePage.of(context).updateSelectedPosition(1);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MapPage(),
            ),
          ).then((pickedPosition) async {
            if (pickedPosition != null) {
              var weatherData = await fetchWeather(
                  pickedPosition.latitude, pickedPosition.longitude);
              var airQualityData = await fetchAirQuality(
                  pickedPosition.latitude, pickedPosition.longitude);
              weatherService.addCity(City(
                name: weatherData['name'],
                position: pickedPosition,
                weatherData: weatherData,
                airQualityData: airQualityData,
              ));
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> fetchWeather(double lat, double lon) async {
    final url = Uri.parse('http://localhost:8901/api/v1/weather/by_pos');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'lat': lat.toString(),
        'lon': lon.toString(),
      }),
    );
    if (response.statusCode == 200) return json.decode(response.body);
  }

  Future<dynamic> fetchAirQuality(double lat, double lon) async {
    final url = Uri.parse('http://localhost:8901/api/v1/aqi/by_pos');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'lat': lat.toString(),
        'lon': lon.toString(),
      }),
    );
    if (response.statusCode == 200) return json.decode(response.body);
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  LatLng selectedPosition = LatLng(34, 108);
  Marker selectedMarker = Marker(
    point: LatLng(34, 108),
    builder: (context) => const Icon(
      Icons.location_on,
      size: 50,
      color: Colors.red,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Position'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(34, 108), // Initial map center
          zoom: 5.0, // Initial zoom level
          onTap: _handleTap, // Handle tap event
        ),
        mapController: MapController(),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(
            markers: [selectedMarker],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, selectedPosition);
        },
        child: const Icon(Icons.check),
      ),
    );
  }

  // Handle tap event on the map
  void _handleTap(TapPosition pos, LatLng tappedPosition) {
    setState(() {
      selectedPosition = tappedPosition;
      selectedMarker = Marker(
        point: selectedPosition,
        builder: (context) => const Icon(
          Icons.location_on,
          size: 50,
          color: Colors.red,
        ),
      );
    });
  }
}

class City {
  final String name;
  final LatLng position;
  final Map<String, dynamic> weatherData;
  final Map<String, dynamic> airQualityData;

  City(
      {required this.name,
      required this.position,
      required this.weatherData,
      required this.airQualityData});
}
