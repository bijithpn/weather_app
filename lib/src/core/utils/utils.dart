import 'package:flutter/material.dart';
import 'package:weather_app/src/data/model/model.dart';

class Utils {
  static WeatherCondition getWeatherCondition(int code) {
    if (code == 0) {
      return WeatherCondition.clear;
    } else if ([1, 2, 3].contains(code)) {
      return WeatherCondition.cloudy;
    } else if ([45, 48].contains(code)) {
      return WeatherCondition.foggy;
    } else if ([51, 53, 55, 61, 63, 65, 80, 81, 82].contains(code)) {
      return WeatherCondition.rainy;
    } else if ([56, 57, 66, 67].contains(code)) {
      return WeatherCondition.rainy;
    } else if ([71, 73, 75, 77, 85, 86].contains(code)) {
      return WeatherCondition.snowy;
    } else if ([95, 96, 99].contains(code)) {
      return WeatherCondition.thunderstorm;
    } else {
      return WeatherCondition.unknown;
    }
  }

  static Color getBgColor(WeatherCondition weather) {
    switch (weather) {
      case WeatherCondition.clear:
        return Colors.orangeAccent;
      case WeatherCondition.cloudy:
        return Colors.grey;
      case WeatherCondition.rainy:
        return Colors.blueGrey.shade600;
      case WeatherCondition.snowy:
        return Colors.lightBlue.shade50;
      case WeatherCondition.thunderstorm:
        return Colors.deepPurple;
      case WeatherCondition.foggy:
        return Colors.grey.shade400;
      case WeatherCondition.unknown:
      default:
        return Colors.white;
    }
  }

  static String getWeatherEmoji(WeatherCondition weather) {
    switch (weather) {
      case WeatherCondition.clear:
        return '☀️';
      case WeatherCondition.cloudy:
        return '⛅';
      case WeatherCondition.foggy:
        return '🌫️';
      case WeatherCondition.rainy:
        return '🌧️';
      case WeatherCondition.snowy:
        return '❄️';
      case WeatherCondition.thunderstorm:
        return '⛈️';
      case WeatherCondition.unknown:
      default:
        return '❓';
    }
  }
}
