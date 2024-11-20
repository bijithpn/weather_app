abstract class AppException implements Exception {
  final String message;
  final String? details;

  AppException(this.message, [this.details]);

  @override
  String toString() => '$message${details != null ? ': $details' : ''}';
}

class NetworkException extends AppException {
  NetworkException([String? details])
      : super('No Internet Connection', details);
}

class ApiException extends AppException {
  final int statusCode;

  ApiException(this.statusCode, String message, [String? details])
      : super(message, details);
}

class UnknownException extends AppException {
  UnknownException([String? details])
      : super('An unknown error occurred', details);
}

/// Exception thrown when locationSearch fails.
class LocationRequestFailure implements Exception {
  final String message;

  LocationRequestFailure([this.message = 'Failed to search for the location.']);

  @override
  String toString() => 'LocationRequestFailure: $message';
}

/// Exception thrown when the provided location is not found.
class LocationNotFoundFailure implements Exception {
  final String message;

  LocationNotFoundFailure(
      [this.message = 'The specified location was not found.']);

  @override
  String toString() => 'LocationNotFoundFailure: $message';
}

/// Exception thrown when getWeather fails.
class WeatherRequestFailure implements Exception {
  final String message;

  WeatherRequestFailure([this.message = 'Failed to fetch weather data.']);

  @override
  String toString() => 'WeatherRequestFailure: $message';
}

/// Exception thrown when weather for provided location is not found.
class WeatherNotFoundFailure implements Exception {
  final String message;

  WeatherNotFoundFailure(
      [this.message =
          'Weather data for the specified location was not found.']);

  @override
  String toString() => 'WeatherNotFoundFailure: $message';
}
