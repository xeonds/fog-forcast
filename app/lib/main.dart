import 'package:app/views/city.dart';
import 'package:app/views/weather.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fog Forcast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true),
      // darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();

  static HomePageState of(BuildContext context) {
    final state = context.findAncestorStateOfType<HomePageState>();
    if (state == null) {
      throw Exception('HomePageState not found');
    }
    return state;
  }
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final List<Widget> _pages = [
    WeatherPage(
      cityName: "",
      temperature: "",
      weatherCondition: "",
    ),
    CityPage(
      cities: [],
      selectedPosition: "",
    ),
  ];

  void updateSelectedPosition(int selectedPosition) {
    setState(() {
      selectedIndex = 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        indicatorColor: Theme.of(context).colorScheme.inversePrimary,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home),
              selectedIcon: Icon(Icons.home),
              label: 'Weather'),
          NavigationDestination(
              icon: Icon(Icons.map),
              selectedIcon: Icon(Icons.map),
              label: 'City'),
        ],
        selectedIndex: selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: _onItemTapped,
      ),
    );
  }
}
