import 'package:dio/dio.dart';
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
      final results = await Future.wait([
        _weatherRepository.getWeather(latitude: lat, longitude: lng),
        _weatherRepository.fetchForecastData(latitude: lat, longitude: lng),
      ]);
      final weather = results[0] as Weather;
      final forecast = results[1] as (
        List<String> timeList,
        List<int> weatherCodeList,
        List<double> temperatureList
      );
      _emitWeatherState(
        weather,
        location,
        forecast,
      );
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.connectionError) {
        emit(state.copyWith(status: WeatherStatus.initial));
      } else if (e is Exception) {
        emit(state.copyWith(status: WeatherStatus.failure));
      }
    }
  }

  Future<void> fetchWeather(String? city) async {
    if (city == null || city.isEmpty) return;
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final location = await _weatherRepository.getCoordinatesFromPlace(city);
      final results = await Future.wait([
        _weatherRepository.getWeather(
          latitude: location['latitude']!,
          longitude: location['longitude']!,
        ),
        _weatherRepository.fetchForecastData(
          latitude: location['latitude']!,
          longitude: location['longitude']!,
        ),
      ]);
      final weather = results[0] as Weather;
      final forecast = results[1] as (
        List<String> timeList,
        List<int> weatherCodeList,
        List<double> temperatureList
      );
      _emitWeatherState(
        weather,
        city,
        forecast,
      );
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.connectionError) {
        emit(state.copyWith(status: WeatherStatus.initial));
      } else if (e is Exception) {
        emit(state.copyWith(status: WeatherStatus.failure));
      }
    }
  }

  Future<void> refreshWeather() async {
    if (!state.status.isSuccess || state.weather == Weather.unknown) return;
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final location = await _weatherRepository
          .getCoordinatesFromPlace(state.weather.location);
      final results = await Future.wait([
        _weatherRepository.getWeather(
          latitude: location['latitude']!,
          longitude: location['longitude']!,
        ),
        _weatherRepository.fetchForecastData(
          latitude: location['latitude']!,
          longitude: location['longitude']!,
        ),
      ]);
      final weather = results[0] as Weather;
      final forecast = results[1] as (
        List<String> timeList,
        List<int> weatherCodeList,
        List<double> temperatureList
      );
      _emitWeatherState(
        weather,
        state.weather.location,
        forecast,
      );
    } catch (e) {
      if (e is DioException && e.type == DioExceptionType.connectionError) {
        emit(state.copyWith(status: WeatherStatus.initial));
      } else if (e is Exception) {
        emit(state);
      }
    }
  }

  void emitEmptyState() {
    emit(state.copyWith(status: WeatherStatus.initial));
  }

  void _emitWeatherState(
      Weather weather,
      String location,
      (
        List<String> timeList,
        List<int> weatherCodeList,
        List<double> temperatureList
      ) forecast) {
    final units = state.temperatureUnits;
    final temperature = units.isFahrenheit
        ? weather.temperature.toFahrenheit()
        : weather.temperature;
    final (timeList, weatherCodeList, temperatureList) = forecast;
    emit(
      state.copyWith(
        status: WeatherStatus.success,
        temperatureUnits: units,
        weather: weather.copyWith(
          temperature: temperature,
          location: location,
          forecastTimeList: timeList,
          forecastTemperatureList: temperatureList,
          forecastWeatheCodeList: weatherCodeList,
        ),
      ),
    );
  }
}

extension on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
}
