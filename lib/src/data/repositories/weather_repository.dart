import 'package:dio/dio.dart';
import '../../core/core.dart';
import '../model/model.dart';
import '../services/api_client.dart';

class WeatherRepository {
  final ApiClient _apiClient = ApiClient(Dio());
  static const _baseUrlWeather = 'https://api.open-meteo.com';
  static const _baseUrlGeocoding = 'https://geocoding-api.open-meteo.com';

  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _apiClient.request<dynamic>(
        RequestOptions(
            method: 'GET',
            path: '$_baseUrlWeather/v1/forecast',
            queryParameters: {
              'latitude': '$latitude',
              'longitude': '$longitude',
              'current_weather': 'true'
            }),
      );
      if (!response.data.containsKey('current_weather')) {
        throw WeatherNotFoundFailure();
      }
      final weatherJson =
          response.data['current_weather'] as Map<String, dynamic>;
      return Weather.fromJson(weatherJson);
    } catch (e) {
      // final errorMessage = ErrorHandler.handle(e);
      // UserNotification.showErrorSnackBar(errorMessage);
      throw WeatherRequestFailure();
    }
  }

  Future<Location> locationSearch(String query) async {
    try {
      final response = await _apiClient.request<dynamic>(
        RequestOptions(
          method: "GET",
          path: '$_baseUrlGeocoding/v1/search',
          queryParameters: {'name': query, 'count': '1'},
        ),
      );
      if (!response.data.containsKey('results')) {
        throw LocationNotFoundFailure();
      }
      final results = response.data['results'] as List;
      if (results.isEmpty) {
        throw LocationNotFoundFailure();
      }
      return Location.fromJson(results.first as Map<String, dynamic>);
    } catch (e) {
      // final errorMessage = ErrorHandler.handle(e);
      // UserNotification.showErrorSnackBar(errorMessage);
      throw LocationRequestFailure();
    }
  }
}
