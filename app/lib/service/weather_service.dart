import 'package:app/views/city.dart';
import 'package:flutter/foundation.dart';

class WeatherService extends ChangeNotifier {
  List<City> cities = [];
  City? selectedCity;

  static final WeatherService _instance = WeatherService._internal();
  factory WeatherService() => _instance;

  WeatherService._internal();
}
