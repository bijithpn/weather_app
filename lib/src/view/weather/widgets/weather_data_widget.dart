import 'package:flutter/material.dart';

import 'package:weather_app/src/core/utils/utils.dart';

import '../../../data/model/model.dart';

class WeatherDataWidget extends StatelessWidget {
  const WeatherDataWidget({
    required this.weather,
    required this.units,
    required this.onRefresh,
    super.key,
  });

  final ValueGetter<Future<void>> onRefresh;
  final TemperatureUnits units;
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weatherCode = Utils.getWeatherCondition(weather.weathercode);
    return Stack(
      alignment: Alignment.center,
      children: [
        _WeatherBackground(
          weather: weatherCode,
        ),
        RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            clipBehavior: Clip.none,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _WeatherIcon(
                  weather: weatherCode,
                ),
                Text(
                  weather.location,
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  weather.formattedTemperature(units),
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconTextWidget(
                  icon: Icons.wind_power,
                  text: 'Wind Speed: ${weather.windspeed} km/h',
                ),
                IconTextWidget(
                  icon: Icons.air,
                  text: 'Direction: ${weather.winddirection}°',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconTextWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.black,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18),
        ),
      ],
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({required this.weather});

  final WeatherCondition weather;

  static const _iconSize = 75.0;
  String getWeatherEmoji() {
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

  @override
  Widget build(BuildContext context) {
    return Text(
      getWeatherEmoji(),
      style: const TextStyle(fontSize: _iconSize),
    );
  }
}

class _WeatherBackground extends StatelessWidget {
  const _WeatherBackground({
    required this.weather,
  });

  final WeatherCondition weather;

  @override
  Widget build(BuildContext context) {
    final color = Utils.getBgColor(weather);
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.25, 0.75, 0.90, 1.0],
            colors: [
              color,
              color.brighten(),
              color.brighten(33),
              color.brighten(40),
            ],
          ),
        ),
      ),
    );
  }
}

extension on Color {
  Color brighten([int percent = 10]) {
    assert(
      1 <= percent && percent <= 100,
      'percentage must be between 1 and 100',
    );
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }
}

extension on Weather {
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}