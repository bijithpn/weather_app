import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:weather_app/src/core/config/api_config.dart';
import '../../core/core.dart';
import '../model/model.dart';
import '../services/api_client.dart';

class WeatherRepository {
  final ApiClient _apiClient = ApiClient(Dio());

  Future<Weather> getWeather({
    required double latitude,
    required double longitude,
    String currentWeather = 'true',
    String daily =
        "weather_code,temperature_2m_max,sunrise,sunset,uv_index_max",
    String hourly = "temperature_2m,relative_humidity_2m,weather_code",
    int forecastDays = 8,
  }) async {
    try {
      final response = await _apiClient.request<dynamic>(
        RequestOptions(
            method: 'GET',
            path: ApiConfig.baseUrl,
            queryParameters: {
              'latitude': '$latitude',
              'longitude': '$longitude',
              "daily": daily,
              "hourly": hourly,
              "forecast_days": forecastDays,
              'current_weather': 'true'
            }),
      );
      if (!response.data.containsKey('current_weather')) {
        throw WeatherNotFoundFailure();
      }
      if (!response.data.containsKey('daily')) {
        throw ForecastNotFoundFailure();
      }
      final weatherJson =
          response.data['current_weather'] as Map<String, dynamic>;
      if (!response.data.containsKey('daily')) {
        throw ForecastNotFoundFailure();
      }
      List<String> timeList =
          response.data['daily']["time"].whereType<String>().toList();
      List<int> weatherCodeList =
          response.data['daily']["weather_code"].whereType<int>().toList();
      List<double> temperatureList = response.data['daily']
              ["temperature_2m_max"]
          .whereType<double>()
          .toList();
      List<String> todayTimeList =
          response.data['hourly']["time"].whereType<String>().toList();
      List<int> todayHumidityList = response.data['hourly']
              ["relative_humidity_2m"]
          .whereType<int>()
          .toList();
      List<int> todayWeatherCode =
          response.data['hourly']["weather_code"].whereType<int>().toList();
      List<double> todayTempList = response.data['hourly']["temperature_2m"]
          .whereType<double>()
          .toList();
      DateTime sunrise = DateTime.parse(response.data['daily']['sunrise'][0]);
      DateTime sunset = DateTime.parse(response.data['daily']['sunset'][0]);
      double uvIndex = response.data['daily']['uv_index_max'][0];
      final weather = Weather.fromJson(weatherJson).copyWith(
        forecastTemperatureList: temperatureList,
        forecastWeatheCodeList: weatherCodeList,
        forecastTimeList: timeList,
        todayTimeList: todayTimeList,
        todayHumidityList: todayHumidityList,
        todayTemperatureList: todayTempList,
        sunrise: sunrise,
        uvIndex: uvIndex,
        sunset: sunset,
        todayWeatherCode: todayWeatherCode,
      );
      return weather;
    } catch (e) {
      // final errorMessage = ErrorHandler.handle(e);
      // UserNotification.showErrorSnackBar(errorMessage);
      throw WeatherRequestFailure();
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
