import 'package:flutter/material.dart';

class CityPage extends StatefulWidget {
  final List<String> cities;
  final String selectedPosition;

  CityPage({required this.cities, required this.selectedPosition});

  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a City'),
      ),
      body: ListView.builder(
        itemCount: widget.cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.cities[index]),
            onTap: () {
              // Handle city selection here
              String selectedCity = widget.cities[index];
              // Do something with the selected city
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapPage(
                cities: widget.cities,
              ),
            ),
          ).then((pickedPosition) {
            if (pickedPosition != null) {
              setState(() {
                widget.cities.add(pickedPosition);
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  final List<String> cities;

  MapPage({required this.cities});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Position'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Clickable Map'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String pickedPosition = 'Picked Position';
          Navigator.pop(context, pickedPosition);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
