import 'package:flutter/material.dart';
import 'package:weather_app/src/data/model/model.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final WeatherCondition weatherCondition;
  const IconTextWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.weatherCondition,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(height: 7),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: 15, color: color),
        ),
      ],
    );
  }
}
