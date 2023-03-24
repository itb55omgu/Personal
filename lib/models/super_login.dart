import 'package:logintask/models/user.dart';

class SuperLogin {
  String guid;
  String firstName;
  String lastName;
  String patronymic;
  String position;

  SuperLogin(
      {
        required this.guid,
        required this.firstName,
        required this.lastName,
        required this.patronymic,
        required this.position
      });

  factory SuperLogin.fromJson(var json) {
    return SuperLogin(
      guid: json['guid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      patronymic: json['patronymic'],
      position: json['position'],
    );
  }
}



