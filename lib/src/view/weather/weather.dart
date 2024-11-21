import 'package:flutter/material.dart';
import 'package:weather_app/src/cubit/weather_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/src/data/services/location_service.dart';
import '../search/search.dart';
import 'widgets/widgets.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    fetchUserLocationData();
    super.initState();
  }

  void fetchUserLocationData() async {
    final position = await LocationService().requestAndGetLocation(context);
    if (position != null) {
      if (mounted) {
        context.read<WeatherCubit>().fetchWeatherWithLatLng(
            position.latitude, position.longitude, null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 10,
        title: Text(
          'Weather',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () async {
              final city =
                  await Navigator.of(context).push(SearchPage.route()) ?? "";
              if (!context.mounted) return;
              if (city.isNotEmpty) {
                await context.read<WeatherCubit>().fetchWeather(city);
              }
            },
          )
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return switch (state.status) {
              WeatherStatus.initial => const WeatherEmpty(),
              WeatherStatus.loading => const WeatherLoading(),
              WeatherStatus.failure => const WeatherError(),
              WeatherStatus.success => WeatherDataWidget(
                  weather: state.weather,
                  units: state.temperatureUnits,
                  onRefresh: () {
                    return context.read<WeatherCubit>().refreshWeather();
                  },
                ),
            };
          },
        ),
      ),
    );
  }
}
