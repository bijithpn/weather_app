import 'package:flutter/material.dart';
import 'package:weather_app/src/core/utils/utils.dart';
import 'package:weather_app/src/data/model/model.dart';

class ApiIconWidget extends StatelessWidget {
  final WeatherCondition weatherCondition;
  const ApiIconWidget({super.key, required this.weatherCondition});

  @override
  Widget build(BuildContext context) {
    final bgColor = Utils.getBgColor(weatherCondition);
    final color =
        (bgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white)
            .withOpacity(.5);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          Icons.thermostat,
          color: color,
        ),
        const SizedBox(width: 1),
        Text(
          "Open Meteo",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: color, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
