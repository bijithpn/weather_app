import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/model.dart';
import '../data/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(WeatherState());

  final WeatherRepository _weatherRepository;

  Future<void> fetchWeatherWithLatLng(
      double? lat, double? lng, String? location) async {
    if (lat == null || lng == null) return;
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      location ??= await _weatherRepository.getPlaceName(lat, lng);
      final weather = await _weatherRepository.getWeather(
        latitude: lat,
        longitude: lng,
      );
      final (
        List<String> timeList,
        List<int> weatherCodeLIst,
        List<double> temperatureList
      ) = await _weatherRepository.fetchForecastData(
          latitude: lat, longitude: lng);
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.toFahrenheit()
          : weather.temperature;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(
            temperature: value,
            location: location,
            forecastTimeList: timeList,
            forecastTemperatureList: temperatureList,
            forecastWeatheCodeList: weatherCodeLIst,
          ),
        ),
      );
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final poistion = await _weatherRepository.getCoordinatesFromPlace(city);
      final (
        List<String> timeList,
        List<int> weatherCodeLIst,
        List<double> temperatureList
      ) = await _weatherRepository.fetchForecastData(
          latitude: poistion['latitude']!, longitude: poistion['longitude']!);
      final weather = await _weatherRepository.getWeather(
        latitude: poistion['latitude']!,
        longitude: poistion['longitude']!,
      );
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.toFahrenheit()
          : weather.temperature;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(
            temperature: value,
            location: city,
            forecastTimeList: timeList,
            forecastWeatheCodeList: weatherCodeLIst,
            forecastTemperatureList: temperatureList,
          ),
        ),
      );
    } on Exception {
      emit(state.copyWith(status: WeatherStatus.failure));
    }
  }

  Future<void> refreshWeather() async {
    if (!state.status.isSuccess) return;
    if (state.weather == Weather.unknown) return;
    try {
      final position = await _weatherRepository
          .getCoordinatesFromPlace(state.weather.location);
      final (
        List<String> timeList,
        List<int> weatherCodeLIst,
        List<double> temperatureList
      ) = await _weatherRepository.fetchForecastData(
          latitude: position['latitude']!, longitude: position['longitude']!);
      final weather = await _weatherRepository.getWeather(
        latitude: position['latitude']!,
        longitude: position['longitude']!,
      );
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.toFahrenheit()
          : weather.temperature;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(
            temperature: value,
            location: state.weather.location,
            forecastTimeList: timeList,
            forecastTemperatureList: temperatureList,
            forecastWeatheCodeList: weatherCodeLIst,
          ),
        ),
      );
    } on Exception {
      emit(state);
    }
  }
}

extension on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
}
