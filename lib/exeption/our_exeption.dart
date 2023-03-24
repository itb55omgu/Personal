import 'dart:convert';

import 'package:http/http.dart';
class OurException {

  int code;
  String error;


  OurException(this.code,this. error);

  static String kNoInternet = "Проверьте ваше\nинтернет-соединение";
  static String kTimeoutError = "Таймаут";
  static String kTokenExpired = "Токен устарел";
  static String kJsonError = "Ошибка разбора JSON";
  static String kUnknownError = "Неизвестная ошибка";
  static String kServerError = "Ошибка интернета"; // "Ошибка сервера"; // 500
  static String kWrongAnswer = "Ошибка ответа сервера";
  static int kHttpTimeout = 40;

  static Map<int, String> httpCodeText = {
    401: 'Неверный логин/пароль',
    402: 'Данный сотрудник не найден',
    404: 'Страница не найдена',
    405: 'Метод не определен',
  };

  @override
  String toString() => "$code: $error";

  factory OurException.fromBody(int statusCode, String body) {

    final re = OurException(
      statusCode, body,

    );

    return re;

  }

  factory OurException.fromResponse(Response response) {
    try {
      return OurException.fromBody(
          response.statusCode, utf8.decode(response.bodyBytes));
    } catch (_) {
      print('OurException.fromResponse: ${response.statusCode}');
      return OurException(
          response.statusCode,
          httpCodeText.containsKey(response.statusCode)
              ? httpCodeText[response.statusCode]!
              : kUnknownError);
    }
  }
}
