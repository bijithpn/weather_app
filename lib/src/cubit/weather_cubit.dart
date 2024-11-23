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
      final weather =
          await _weatherRepository.getWeather(latitude: lat, longitude: lng);
      _emitWeatherState(
        weather,
        location,
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
      final weather = await _weatherRepository.getWeather(
        latitude: location['latitude']!,
        longitude: location['longitude']!,
      );
      _emitWeatherState(
        weather,
        city,
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
      final weather = await _weatherRepository.getWeather(
        latitude: location['latitude']!,
        longitude: location['longitude']!,
      );
      _emitWeatherState(
        weather,
        state.weather.location,
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
  ) {
    final units = state.temperatureUnits;
    final temperature = units.isFahrenheit
        ? weather.temperature.toFahrenheit()
        : weather.temperature;
    emit(
      state.copyWith(
        status: WeatherStatus.success,
        temperatureUnits: units,
        weather: weather.copyWith(
          temperature: temperature,
          location: location,
        ),
      ),
    );
  }
}

extension on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
}
