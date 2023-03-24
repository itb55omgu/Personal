import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../http/provider_password_mask.dart';
import '../http/query.dart';
import '../models/password_verification_data.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<StatefulWidget> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  var answer;
  bool isPasswordVisible = true;
  bool isRepeatPasswordVisible = true;
  Future<PasswordVerificationData>? futurePasswordVerificationData;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();
  final TextEditingController _firstNameTextController =
      TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _patronymicTextController =
      TextEditingController();
  final TextEditingController _innTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  TextFormField _lastNameFormField() {
    return TextFormField(
        controller: _lastNameTextController,
        decoration: const InputDecoration(
            labelText: "Фамилия", border: OutlineInputBorder()));
  }

  TextFormField _firstNameFormField() {
    return TextFormField(
        controller: _firstNameTextController,
        decoration: const InputDecoration(
            labelText: "Имя", border: OutlineInputBorder()));
  }

  TextFormField _patronymicFormField() {
    return TextFormField(
      controller: _patronymicTextController,
      decoration: const InputDecoration(
          labelText: "Отчество", border: OutlineInputBorder()),
    );
  }

  TextFormField _innFormField() {
    return TextFormField(
      controller: _innTextController,
      decoration:
          const InputDecoration(labelText: "ИНН", border: OutlineInputBorder()),
    );
  }

  TextFormField _passwordFormField() {
    return TextFormField(
        controller: _passwordController,
        obscureText: isPasswordVisible,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.done,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(40),
        ],
        decoration: const InputDecoration(
            labelText: "Введите пароль", border: OutlineInputBorder()));
  }

  TextFormField _repeatPasswordFormField() {
    return TextFormField(
        controller: _repeatPasswordController,
        obscureText: isRepeatPasswordVisible,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.done,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(40),
        ],
        decoration: const InputDecoration(
            labelText: "Подтвердите пароль", border: OutlineInputBorder()));
  }

  Widget _wrapper(Widget widget) {
    return Container(
    width: 400,
     child: Padding(
      padding: const EdgeInsetsDirectional.all(5),
      child: widget,
    ));
  }
  void getData(){
    var firstName = _firstNameTextController.text;
    var lastName = _lastNameTextController.text;
    var patronymic = _patronymicTextController.text;
    var inn = _innTextController.text;
//    Query().checkUser("Орлова", "Елена", "Николаевна", "366212064388").then((value){
    Query().checkUser(lastName, firstName, patronymic, inn).then((value){
      setState(()=> answer = value);
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Регистрация"),
      ),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                child: Column(
                  children: [
                    const SizedBox(height: 6),
                    _wrapper(_lastNameFormField()),
                    const SizedBox(height: 6),
                    _wrapper(_firstNameFormField()),
                    const SizedBox(height: 6),
                    _wrapper(_patronymicFormField()),
                    const SizedBox(height: 6),
                    _wrapper(_innFormField()),
                    const SizedBox(height: 6),
                    _wrapper(_passwordFormField()),
                    const SizedBox(height: 6),
                    _wrapper(_repeatPasswordFormField()),
                  ],
                ),
              ),
              _wrapper(ElevatedButton(
                onPressed: () async {
                  if (_passwordController.text ==
                          _repeatPasswordController.text &&
                      await passwordVerification(_passwordController) &&
                      await passwordVerification(_repeatPasswordController)) {
                    Widget okButton = TextButton(
                      child: const Text("Ок"),
                      onPressed: () {},
                    );

                    AlertDialog alert = AlertDialog(
                      title: const Text("Оповещение"),
                      content: const Text("Все ОК!"),
                      actions: [
                        okButton,
                      ],
                    );

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  } else {
                    Widget okButton = TextButton(
                      child: const Text("ОК"),
                      onPressed: () {},
                    );

                    AlertDialog alert = AlertDialog(
                      title: const Text("Оповещение"),
                      content: const Text("Все не ок!"),
                      actions: [
                        okButton,
                      ],
                    );

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  }
                },
                child: const Text('Зарегистрироваться'),
              ),)
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> passwordVerification(TextEditingController password) async {
  Future<PasswordVerificationData> checkPass = MwProvider().getPasswordData();

  String maskPass = await checkPass.then((value) => value.passwordMask);
  int len = await checkPass.then((value) => value.lengthPassword);

  var array = maskPass.split('');
  for (var element in array) {
    if (!password.text.contains(element)) {
      return false;
    }
  }

  if (password.text.length >= len) {
    return true;
  }

  return false;
}
