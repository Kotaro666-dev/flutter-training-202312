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
      weatherCondition: json['weather_condition'] as String?,
      maxTemperature: json['max_temperature'] as int?,
      minTemperature: json['min_temperature'] as int?,
      date: json['date'] as String?,
    );
  }

  final String? weatherCondition;
  final int? maxTemperature;
  final int? minTemperature;
  final String? date;
}
