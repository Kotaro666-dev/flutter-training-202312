import 'package:flutter_training/core/exceptions/weather_exceptions.dart';

String getErrorMessage({required Exception e}) {
  if (e is WeatherException) {
    switch (e) {
      case InvalidParameterException():
        return 'パラメータが不正です。入力情報を確認してください。';
      case UnknownWeatherException():
        return '天気情報の取得に失敗しました。時間をおいて再度お試しください。';
      case NetworkException():
        return '通信エラーが発生しました。通信環境を確認してください。';
      case UnexpectedException():
        return 'サーバーエラーが発生しました。時間をおいて再度お試しください。';
      case UndefinedWeatherException():
        return '天気情報が不明です。適切な情報を取得できませんでした。';
    }
  } else {
    return '予期せぬエラーが発生しました。時間をおいて再度お試しください。';
  }
}
