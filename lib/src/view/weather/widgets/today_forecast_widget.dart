import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:weather_app/src/core/utils/utils.dart';

class TodayForecastWidget extends StatelessWidget {
  final List<int> weatherCodes;
  final List<String> timeList;
  final List<double> temperatureList;
  final List<int> humidityList;

  const TodayForecastWidget({
    super.key,
    required this.weatherCodes,
    required this.timeList,
    required this.temperatureList,
    required this.humidityList,
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
            "HOURLY FORECAST",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 135,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(width: 5),
              scrollDirection: Axis.horizontal,
              itemCount: timeList.length > 24 ? 24 : timeList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var weatherCode =
                    Utils.getWeatherCondition(weatherCodes[index]);
                final cardColor = Utils.getBgColor(weatherCode);
                final textColor = cardColor.computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white;
                return SizedBox(
                  width: 150,
                  child: Card(
                    elevation: 5,
                    shape: const CircleBorder(),
                    color: Utils.getBgColor(weatherCode),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            Utils.getWeatherEmoji(weatherCode),
                            style: const TextStyle(fontSize: 25),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${temperatureList[index].toStringAsFixed(0)}°C",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            index == 0
                                ? "Now"
                                : DateFormat("hh:mm a")
                                    .format(DateTime.parse(timeList[index])),
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${humidityList[index]}%",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: textColor.withOpacity(.5),
                                    ),
                          ),
                        ],
                      ),
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
