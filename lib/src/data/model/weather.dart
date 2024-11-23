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
  DateTime? sunrise;
  DateTime? sunset;
  double uvIndex;
  List<String> forecastTimeList;
  List<int> forecastWeatheCodeList;
  List<double> forecastTemperatureList;
  List<String> todayTimeList;
  List<int> todayWeatherCode;
  List<int> todayHumidityList;
  List<double> todayTemperatureList;

  Weather({
    required this.time,
    required this.temperature,
    required this.windspeed,
    required this.winddirection,
    required this.isDay,
    required this.weathercode,
    required this.location,
    this.sunrise,
    this.sunset,
    required this.uvIndex,
    this.forecastTimeList = const [],
    this.forecastWeatheCodeList = const [],
    this.forecastTemperatureList = const [],
    this.todayTimeList = const [],
    this.todayHumidityList = const [],
    this.todayWeatherCode = const [],
    this.todayTemperatureList = const [],
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        time: json["time"],
        temperature: json["temperature"]?.toDouble(),
        windspeed: json["windspeed"]?.toDouble(),
        winddirection: json["winddirection"],
        isDay: json["is_day"],
        weathercode: json["weathercode"],
        location: 'unknown',
        sunrise: null,
        sunset: null,
        uvIndex: 0.0,
        forecastTimeList: [],
        forecastWeatheCodeList: [],
        forecastTemperatureList: [],
        todayTimeList: [],
        todayWeatherCode: [],
        todayHumidityList: [],
        todayTemperatureList: [],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "temperature": temperature,
        "windspeed": windspeed,
        "winddirection": winddirection,
        "is_day": isDay,
        "weathercode": weathercode,
        "location": location,
        "uvIndex": uvIndex,
        "sunrise": sunrise?.toIso8601String(),
        "sunset": sunset?.toIso8601String(),
        "forecastTimeList": forecastTimeList,
        "forecastWeatheCodeList": forecastWeatheCodeList,
        "forecastTemperatureList": forecastTemperatureList,
        "todayWeatherCode": todayWeatherCode,
        "todayTimeList": todayTimeList,
        "todayHumidityList": todayHumidityList,
        "todayTemperatureList": todayTemperatureList,
      };

  static final unknown = Weather(
    time: '',
    temperature: 0,
    windspeed: 0,
    winddirection: 0,
    isDay: 0,
    weathercode: 0,
    location: '',
    sunrise: null,
    sunset: null,
    uvIndex: 0.0,
    forecastTimeList: [],
    forecastWeatheCodeList: [],
    forecastTemperatureList: [],
    todayWeatherCode: [],
    todayTimeList: [],
    todayHumidityList: [],
    todayTemperatureList: [],
  );

  Weather copyWith({
    String? time,
    double? temperature,
    double? windspeed,
    int? winddirection,
    int? isDay,
    int? weathercode,
    String? location,
    DateTime? sunrise,
    DateTime? sunset,
    List<String>? forecastTimeList,
    List<int>? forecastWeatheCodeList,
    List<double>? forecastTemperatureList,
    List<String>? todayTimeList,
    List<int>? todayHumidityList,
    List<int>? todayWeatherCode,
    List<double>? todayTemperatureList,
    double? uvIndex,
  }) {
    return Weather(
      time: time ?? this.time,
      temperature: temperature ?? this.temperature,
      windspeed: windspeed ?? this.windspeed,
      winddirection: winddirection ?? this.winddirection,
      isDay: isDay ?? this.isDay,
      weathercode: weathercode ?? this.weathercode,
      location: location ?? this.location,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      uvIndex: uvIndex ?? this.uvIndex,
      todayWeatherCode: todayWeatherCode ?? this.todayWeatherCode,
      forecastTimeList: forecastTimeList ?? this.forecastTimeList,
      forecastWeatheCodeList:
          forecastWeatheCodeList ?? this.forecastWeatheCodeList,
      forecastTemperatureList:
          forecastTemperatureList ?? this.forecastTemperatureList,
      todayTimeList: todayTimeList ?? this.todayTimeList,
      todayHumidityList: todayHumidityList ?? this.todayHumidityList,
      todayTemperatureList: todayTemperatureList ?? this.todayTemperatureList,
    );
  }
}

extension TemperatureUnitsX on TemperatureUnits {
  bool get isFahrenheit => this == TemperatureUnits.fahrenheit;
  bool get isCelsius => this == TemperatureUnits.celsius;
}
