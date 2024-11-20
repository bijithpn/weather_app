import 'package:flutter/material.dart';

class WeatherDetailsView extends StatefulWidget {
  const WeatherDetailsView({super.key});

  @override
  State<WeatherDetailsView> createState() => _WeatherDetailsViewState();
}

class _WeatherDetailsViewState extends State<WeatherDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: Text(
            "Details",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        body: const Center(
          child: Text("Details"),
        ));
  }
}
