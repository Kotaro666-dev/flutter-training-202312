enum WeatherCondition {
  sunny,
  cloudy,
  rainy;

  factory WeatherCondition.from(String condition) {
    for (final value in WeatherCondition.values) {
      if (value.name == condition) {
        return value;
      }
    }
    throw FormatException('Undefined weather: $condition');
  }
}
