import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/core/core.dart';
import 'package:weather_app/src/cubit/network_cubit.dart';
import 'package:weather_app/src/cubit/weather_cubit.dart';
import 'package:weather_app/src/data/model/model.dart';
import 'package:weather_app/src/data/services/location_service.dart';

class WeatherButton extends StatelessWidget {
  final String? text;
  const WeatherButton({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final networkStatus =
        context.watch<NetworkCubit>().state == NetworkStatus.connected;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        backgroundColor: theme.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () async {
        if (networkStatus) {
          final weather = context.read<WeatherCubit>();
          if (weather.state.weather == Weather.unknown) {
            final position =
                await LocationService().requestAndGetLocation(context);
            if (position != null) {
              if (context.mounted) {
                context.read<WeatherCubit>().fetchWeatherWithLatLng(
                    position.latitude, position.longitude, null);
              }
            }
          } else {
            if (context.mounted) {
              context
                  .read<WeatherCubit>()
                  .fetchWeather(weather.state.weather.location);
            }
          }
        } else {
          UserNotification.showSnackBar(
              "Please check you internet connection.");
        }
      },
      child: Text(
        text ?? (networkStatus ? 'Get weather' : "Retry"),
        style: theme.textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.primaryColor.computeLuminance() > 0.5
              ? Colors.black
              : Colors.white,
        ),
      ),
    );
  }
}
