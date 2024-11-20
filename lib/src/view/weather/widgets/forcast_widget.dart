import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/src/core/utils/utils.dart';

class ForcastWidget extends StatelessWidget {
  final List<int> weatherCode;
  final List<String> timeList;
  const ForcastWidget({
    super.key,
    required this.weatherCode,
    required this.timeList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        separatorBuilder: (_, i) => const SizedBox(
          width: 10,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: timeList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            color: Colors.white70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    Utils.getWeatherEmoji(
                      Utils.getWeatherCondition(
                        weatherCode[index],
                      ),
                    ),
                    style: const TextStyle(fontSize: 30),
                  ),
                  Text(
                    DateFormat("dd MMM")
                        .format(DateTime.parse(timeList[index])),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
