import 'package:dio/dio.dart';
import 'package:weather_app/src/core/config/api_config.dart';
import '../../core/core.dart';
import '../model/model.dart';
import '../services/api_client.dart';

class WeatherRepository {
  final ApiClient _apiClient = ApiClient(Dio());
  static const _baseUrlGeocoding = 'https://geocoding-api.open-meteo.com';

  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _apiClient.request<dynamic>(
        RequestOptions(
            method: 'GET',
            path: ApiConfig.baseUrl,
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

  Future<(List<String> timeList, List<int> weatherCodeLIst)> fetchForcastData({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _apiClient.request<dynamic>(
        RequestOptions(
          method: "GET",
          path: ApiConfig.baseUrl,
          queryParameters: {
            'latitude': '$latitude',
            'longitude': '$longitude',
            "daily": "weather_code"
          },
        ),
      );
      if (!response.data.containsKey('daily')) {
        throw ForcastNotFoundFailure();
      }
      List<String> timeList =
          response.data['daily']["time"].whereType<String>().toList();
      List<int> weatherCodeLIst =
          response.data['daily']["weather_code"].whereType<int>().toList();

      return (timeList, weatherCodeLIst);
    } catch (e) {
      throw ForcastRequestFailure();
    }
  }
}
