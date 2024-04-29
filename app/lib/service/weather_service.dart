import 'package:app/views/city.dart';
import 'package:flutter/foundation.dart';

class WeatherService extends ChangeNotifier {
  List<City> cities = [];
  City? selectedCity;

  static final WeatherService _instance = WeatherService._internal();
  factory WeatherService() => _instance;

  WeatherService._internal();

  void addCity(City city) {
    cities.add(city);
    notifyListeners();
  }

  void removeCity(City city) {
    cities.remove(city);
    notifyListeners();
  }

  void setSelectedCity(City city) {
    selectedCity = city;
    notifyListeners();
  }

  void updateData() async {
    selectedCity?.weatherData = await fetchWeather(
        selectedCity!.position.latitude, selectedCity!.position.longitude);
    selectedCity?.airQualityData = await fetchAirQuality(
        selectedCity!.position.latitude, selectedCity!.position.longitude);
  }
}
