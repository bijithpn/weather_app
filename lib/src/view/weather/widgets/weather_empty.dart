import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/cubit/network_cubit.dart';
import 'package:weather_app/src/view/weather/widgets/weather_button.dart';

class WeatherEmpty extends StatelessWidget {
  const WeatherEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final networkStatus =
        context.watch<NetworkCubit>().state == NetworkStatus.connected;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(!networkStatus ? "🛜" : '☀️',
              style: const TextStyle(fontSize: 64)),
          Text(
            !networkStatus
                ? 'No internet connection. Please check your connection.'
                : "What's the weather like here?",
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          const WeatherButton(),
        ],
      ),
    );
  }
}
