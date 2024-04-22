import 'package:app/service/weather_service.dart';
import 'package:app/views/setting.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherService()),
      ],
      child: MaterialApp(
        title: 'Fog Forcast',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true),
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    const CityPage(),
    const WeatherPage(),
    const SettingPage()
  ];

  void updateSelectedPosition(int selectedPosition) {
    setState(() {
      selectedIndex = selectedPosition;
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
              icon: Icon(Icons.map),
              selectedIcon: Icon(Icons.map),
              label: 'City'),
          NavigationDestination(
              icon: Icon(Icons.home),
              selectedIcon: Icon(Icons.home),
              label: 'Weather'),
          NavigationDestination(
              icon: Icon(Icons.home),
              selectedIcon: Icon(Icons.home),
              label: 'Settings'),
        ],
        selectedIndex: selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: updateSelectedPosition,
      ),
    );
  }
}
