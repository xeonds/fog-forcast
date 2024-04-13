import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CityPage extends StatefulWidget {
  const CityPage({super.key});

  @override
  CityPageState createState() => CityPageState();
}

class CityPageState extends State<CityPage> {
  List<String> cities = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cities'),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cities[index]),
            onTap: () {
              // String selectedCity = widget.cities[index];
              HomePage.of(context).updateSelectedPosition(0);
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
          ).then((pickedPosition) {
            if (pickedPosition != null) {
              setState(() {
                cities.add(pickedPosition.toString());
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
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
