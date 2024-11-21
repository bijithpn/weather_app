import 'package:flutter/material.dart';
import 'package:weather_app/src/view/weather/widgets/widgets.dart';

class WeatherError extends StatelessWidget {
  const WeatherError({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('🙈', style: TextStyle(fontSize: 64)),
        Text(
          'Something went wrong!',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 10),
        const WeatherButton(
          text: "Try Again",
        ),
      ],
    );
  }
}
