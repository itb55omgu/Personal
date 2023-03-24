import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logintask/forms/registration_form_password.dart';

import '../http/phone_number_verification.dart';
import '../service/snack_bar.dart';
import 'auth_form.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneAuth();
}

class _PhoneAuth extends State<PhoneScreen> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _controller = TextEditingController();
  bool phoneNumberAccess = false;
  bool dataAccess = false;

  Widget _wrapper(Widget widget) {
    return Container(
        width: 400,
        child: Padding(
          padding: const EdgeInsetsDirectional.all(5),
          child: widget,
        ));
  }

  TextFormField _phoneNumberFormField() {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Введите номер телефона';
          }
          return null;
        },
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
            labelText: "Номер телефона", border: OutlineInputBorder()));
  }

  final _formKey = GlobalKey<FormState>();

  void getData() async {
    PhoneNumberVerification().verify(_controller.text).then((value) {
      setState(() {
        phoneNumberAccess = value;
        dataAccess = true;
      });
    }, onError: (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(showSnackBar(context, e.toString()));
    }).whenComplete(() => shift());
  }

  Future<void> shift() async {
    if (dataAccess == true) {
      if (phoneNumberAccess == true) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Authorization(phone: _controller.text)));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const RegistrationForm()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Номер телефона")),
        body: Center(
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _wrapper(_phoneNumberFormField()),
                  _wrapper(
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Processing Data')),
                          // );
                          getData();
                          print(_controller.text.toString());
                        }
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => SecondScreenForm(phone: _controller.text)));
                      },
                      child: const Text('OK'),
                    ),
                  ),
                ],
              )),
        ));
  }
}
