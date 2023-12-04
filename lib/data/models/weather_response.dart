// TODO: Session7 #8 シリアル化する 対応時に json 型レスポンスから freezed で作成した WeatherResponse に変換する
class WeatherResponse {
  const WeatherResponse({
    required this.condition,
  });

  factory WeatherResponse.from({
    required String response,
  }) {
    return WeatherResponse(condition: response);
  }

  final String condition;
}
