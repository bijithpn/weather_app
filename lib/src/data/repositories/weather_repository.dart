import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:weather_app/src/core/config/api_config.dart';
import '../../core/core.dart';
import '../model/model.dart';
import '../services/api_client.dart';

class WeatherRepository {
  final ApiClient _apiClient = ApiClient(Dio());
  // static const _baseUrlGeocoding = 'https://geocoding-api.open-meteo.com';

  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
    String currentWeather = 'true',
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

  // Future<Location> locationSearch(String query) async {
  //   try {
  //     final response = await _apiClient.request<dynamic>(
  //       RequestOptions(
  //         method: "GET",
  //         path: '$_baseUrlGeocoding/v1/search',
  //         queryParameters: {'name': query, 'count': '1'},
  //       ),
  //     );
  //     if (!response.data.containsKey('results')) {
  //       throw LocationNotFoundFailure();
  //     }
  //     final results = response.data['results'] as List;
  //     if (results.isEmpty) {
  //       throw LocationNotFoundFailure();
  //     }
  //     return Location.fromJson(results.first as Map<String, dynamic>);
  //   } catch (e) {
  //     // final errorMessage = ErrorHandler.handle(e);
  //     // UserNotification.showErrorSnackBar(errorMessage);
  //     throw LocationRequestFailure();
  //   }
  // }

  Future<
      (
        List<String> timeList,
        List<int> weatherCodeLIst,
        List<double> temperatureList
      )> fetchForecastData({
    required double latitude,
    required double longitude,
    String daily = "weather_code,temperature_2m_max",
    int forecastDays = 6,
  }) async {
    try {
      final response = await _apiClient.request<dynamic>(
        RequestOptions(
          method: "GET",
          path: ApiConfig.baseUrl,
          queryParameters: {
            'latitude': '$latitude',
            'longitude': '$longitude',
            "daily": daily,
            "forecast_days": forecastDays
          },
        ),
      );
      if (!response.data.containsKey('daily')) {
        throw ForecastNotFoundFailure();
      }
      List<String> timeList =
          response.data['daily']["time"].whereType<String>().toList();
      List<int> weatherCodeLIst =
          response.data['daily']["weather_code"].whereType<int>().toList();
      List<double> temperatureList = response.data['daily']
              ["temperature_2m_max"]
          .whereType<double>()
          .toList();

      return (timeList, weatherCodeLIst, temperatureList);
    } catch (e) {
      throw ForecastRequestFailure();
    }
  }

  Future<String> getPlaceName(double latitude, double longitude) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks.first;
        return "${place.locality}";
      } else {
        return "Place not found";
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<Map<String, double>> getCoordinatesFromPlace(String placeName) async {
    try {
      List<geocoding.Location> locations =
          await geocoding.locationFromAddress(placeName);
      if (locations.isNotEmpty) {
        geocoding.Location location = locations.first;
        return {
          "latitude": location.latitude,
          "longitude": location.longitude,
        };
      } else {
        throw Exception("No coordinates found for the given place.");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
