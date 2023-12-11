// TODO: Session7 シリアル化する で freezed に書き直す
class WeatherRequest {
  WeatherRequest({
    required this.area,
    required this.date,
  });

  final String area;
  final DateTime date;

  Map<String, dynamic> toJson() {
    return {
      'area': area,
      'date': date.toIso8601String(),
    };
  }
}
