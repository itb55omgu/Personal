import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../http/super_login_service.dart';
import '../models/super_login.dart';
import '../models/user.dart';
import '../service/snack_bar.dart';
import 'entering_number_verification.dart';

class Authorization extends StatefulWidget {
  final String phone;

  const Authorization({Key? key, required this.phone}) : super(key: key);

  @override
  State<Authorization> createState() => AuthorizationState();
}

class AuthorizationState extends State<Authorization> {
  SuperLogin? _user;

  //final _messangerKey = GlobalKey<ScaffoldMessengerState>();
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  void getData() {
    UserService().getSuperLogin(_usernameTextController.text, _passwordTextController.text).then((value) {
      setState(() => _user = value);
    }, onError: (e) {
      _user=null;
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar(context, e.toString()));
    }).whenComplete(() => startVerify());
  }

  Future<void> startVerify()async {
    if(_user!=null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
              SecondScreenForm(phone: widget.phone)));
    }
  }
  @override
  void initState() {
    super.initState();
    _usernameTextController.text = widget.phone;
  }

  Widget _wrapper(Widget widget) {
    return Container(
        width: 400,
        child: Padding(
          padding: const EdgeInsetsDirectional.all(5),
          child: widget,
        ));
  }

  TextFormField _loginFormField() {
    return TextFormField(
      controller: _usernameTextController,
      decoration: const InputDecoration(
          labelText: "Номер телефона", border: OutlineInputBorder()),
    );
  }

  TextFormField _passwordFormField() {
    return TextFormField(
      controller: _passwordTextController,
      decoration: const InputDecoration(
          labelText: "Пароль", border: OutlineInputBorder()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Вход"),),
      body:Center(
        child: Form(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _wrapper(_loginFormField()),
        _wrapper(_passwordFormField()),
        _wrapper(
          ElevatedButton(
            child: Text("войти"),
            onPressed: () {
              getData();
              //если проверка на устройство и сотрудника прошла

            },
          ),
        )
      ],)
    )));
  }
}

// void showSnackBar(BuildContext context, String text,{Function()? onVisible, double? width}) {
//   _messangerKey.currentState?.showSnackBar(SnackBar(
//     backgroundColor: Colors.black54,
//     content:
//     Text(text, style: TextStyle(color: Colors.white, fontSize: 15)),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//     elevation: 0,
//     width: width,
//     behavior: SnackBarBehavior.floating,
//     onVisible: onVisible,
//
//   ));
// }
