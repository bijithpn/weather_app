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
        return Colors.orange.shade200;
      case WeatherCondition.cloudy:
        return Colors.grey[300]!;
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

  static String getWeatherDescription(int code) {
    if (code == 0) {
      return "Clear sky";
    } else if (code == 1 || code == 2 || code == 3) {
      return "Mainly clear";
    } else if (code == 45 || code == 48) {
      return "Fog and depositing rime fog";
    } else if (code == 51 || code == 53 || code == 55) {
      return "Drizzle";
    } else if (code == 56 || code == 57) {
      return "Freezing Drizzle";
    } else if (code == 61 || code == 63 || code == 65) {
      return "Rain";
    } else if (code == 66 || code == 67) {
      return "Freezing Rain";
    } else if (code == 71 || code == 73 || code == 75) {
      return "Snow fall";
    } else if (code == 77) {
      return "Snow grains";
    } else if (code == 80 || code == 81 || code == 82) {
      return "Rain showers";
    } else if (code == 85 || code == 86) {
      return "Snow showers";
    } else if (code == 95) {
      return "Thunderstorm";
    } else if (code == 96 || code == 99) {
      return "Thunderstorm with slight and heavy hail";
    } else {
      return "Unknown weather code";
    }
  }
}
