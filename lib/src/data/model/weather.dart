enum TemperatureUnits {
  fahrenheit,
  celsius,
}

enum WeatherCondition {
  clear,
  rainy,
  cloudy,
  snowy,
  thunderstorm,
  foggy,
  unknown,
}

class Weather {
  String time;
  double temperature;
  double windspeed;
  int winddirection;
  int isDay;
  int weathercode;
  String location;

  Weather({
    required this.time,
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.isDay,
    required this.weathercode,
    required this.location,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        time: json["time"],
        temperature: json["temperature"]?.toDouble(),
        windspeed: json["windspeed"]?.toDouble(),
        winddirection: json["winddirection"],
        isDay: json["is_day"],
        weathercode: json["weathercode"],
        location: 'unknown',
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "temperature": temperature,
        "windspeed": windspeed,
        "winddirection": winddirection,
        "is_day": isDay,
        "weathercode": weathercode,
      };

  Weather copyWith(
      {String? time,
      double? temperature,
      double? windspeed,
      int? winddirection,
      int? isDay,
      int? weathercode,
      String? location}) {
    return Weather(
      time: time ?? this.time,
      temperature: temperature ?? this.temperature,
      windspeed: windspeed ?? this.windspeed,
      winddirection: winddirection ?? this.winddirection,
      isDay: isDay ?? this.isDay,
      weathercode: weathercode ?? this.weathercode,
      location: location ?? this.location,
    );
  }

  static final unknown = Weather(
    time: '',
    temperature: 0,
    windspeed: 0,
    winddirection: 0,
    isDay: 0,
    weathercode: 0,
    location: '',
  );
}

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}