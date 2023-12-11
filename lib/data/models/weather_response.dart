// TODO: Session7 シリアル化する で freezed に書き直す
class WeatherResponse {
  const WeatherResponse({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      weatherCondition: _parseStringOrNull(json['weather_condition']),
      maxTemperature: _parseIntOrNull(json['max_temperature']),
      minTemperature: _parseIntOrNull(json['min_temperature']),
      date: _parseStringOrNull(json['date']),
    );
  }

  final String? weatherCondition;
  final int? maxTemperature;
  final int? minTemperature;
  final String? date;

  static String? _parseStringOrNull(dynamic value) {
    if (value is String) {
      return value;
    }
    return null;
  }

  static int? _parseIntOrNull(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      try {
        return int.parse(value);
      } on FormatException {
        return null;
      }
    }
    return null;
  }
}
