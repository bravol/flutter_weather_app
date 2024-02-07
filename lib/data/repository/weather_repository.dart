import 'dart:convert';

import 'package:flutter_weather_app/data/data_provider/weather_data_provider.dart';
import 'package:flutter_weather_app/models/weather_model.dart';

class WeatherRepository {
//generating a constructor for weather data

  final WeatherDataProvider weatherDataProvider;

  WeatherRepository(this.weatherDataProvider);

  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'London';

      final weatherData = await weatherDataProvider.getCurrentWeather(cityName);
      final data = jsonDecode(weatherData);
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return WeatherModel.fromMap(data);
      // return WeatherModel.fromJson(weatherData); or
    } catch (e) {
      throw e.toString();
    }
  }
}
