import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/data/services/location_service.dart';

import '../../../cubit/weather_cubit.dart';

class WeatherEmpty extends StatelessWidget {
  const WeatherEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('☀️', style: TextStyle(fontSize: 64)),
        Text(
          "What's the weather like here?",
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            backgroundColor: theme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            final position =
                await LocationService().requestAndGetLocation(context);
            if (position != null) {
              if (context.mounted) {
                context.read<WeatherCubit>().fetchWeatherWithLatLng(
                    position.latitude, position.longitude, null);
              }
            }
          },
          child: Text(
            'Get weather',
            style: theme.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor.computeLuminance() > 0.5
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
