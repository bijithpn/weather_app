import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weather_app/src/core/utils/utils.dart';

class ForecastWidget extends StatelessWidget {
  final List<int> weatherCodes;
  final List<String> timeList;
  final List<double> temperatureList;

  const ForecastWidget({
    super.key,
    required this.weatherCodes,
    required this.timeList,
    required this.temperatureList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "5-DAY FORECAST",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 110,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: timeList.length - 1,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var adjustedIndex = index + 1;
                var weatherCode =
                    Utils.getWeatherCondition(weatherCodes[adjustedIndex]);
                final cardColor = Utils.getBgColor(weatherCode);
                final textColor = cardColor.computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white;
                return Card(
                  elevation: 5,
                  color: Utils.getBgColor(weatherCode),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          Utils.getWeatherEmoji(weatherCode),
                          style: const TextStyle(fontSize: 30),
                        ),
                        Text(
                          "${temperatureList[adjustedIndex].toStringAsFixed(0)}°C",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                        ),
                        Text(
                          DateFormat("E")
                              .format(DateTime.parse(timeList[adjustedIndex])),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
