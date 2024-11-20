import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../data/model/model.dart';
import '../data/repositories/weather_repository.dart' show WeatherRepository;

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(WeatherState());

  final WeatherRepository _weatherRepository;

  Future<void> fetchWeatherWithLatLng(
      double? lat, double? lng, String? location) async {
    if (lat == null || lng == null) return;
    emit(state.copyWith(status: WeatherStatus.loading));

    try {
      final weather = await _weatherRepository.getWeather(
        latitude: lat,
        longitude: lng,
      );
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.toFahrenheit()
          : weather.temperature;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather: weather.copyWith(temperature: value, location: location),
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
      final location = await _weatherRepository.locationSearch(city);
      final weather = await _weatherRepository.getWeather(
        latitude: location.latitude,
        longitude: location.longitude,
      );
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.toFahrenheit()
          : weather.temperature;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather:
              weather.copyWith(temperature: value, location: location.name),
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
      final location =
          await _weatherRepository.locationSearch(state.weather.location);
      final weather = await _weatherRepository.getWeather(
        latitude: location.latitude,
        longitude: location.longitude,
      );
      final units = state.temperatureUnits;
      final value = units.isFahrenheit
          ? weather.temperature.toFahrenheit()
          : weather.temperature;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          temperatureUnits: units,
          weather:
              weather.copyWith(temperature: value, location: location.name),
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
