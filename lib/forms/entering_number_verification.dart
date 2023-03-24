import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../http/provider.dart';

class SecondScreenForm extends StatefulWidget {
  final String phone;

  const SecondScreenForm({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  SecondScreenFormState createState() {
    return SecondScreenFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
final _formKey = GlobalKey<FormState>();

class SecondScreenFormState extends State<SecondScreenForm> {
//В somecode храним код из 4 цифр, который возвращает 1с.
  String? somecode;

  void initState() {
    print("initState!${widget.phone}");
    postPhone(widget.phone);

    super.initState();
  }

  void postPhone(String phone) async {
    print("postPhone1");
    print(phone);
    MwProviderOktell().loadPhone(phone: phone).then((value) {
      print("postPhone");
      somecode = value.somecode;
      // setState(() {});
    }, onError: (o) {
      SnackBar(content: Text(o.toString()));
    });
  }

  Widget _wrapper(Widget widget) {
    return Container(
        width: 400,
        child: Padding(
          padding: const EdgeInsetsDirectional.all(5),
          child: widget,
        ));
  }

  final TextEditingController _controller = TextEditingController();

  TextFormField _somecodeFormField() {
    return TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Код подтверждения';
          }
          return null;
        },
        controller: _controller,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: "Код",
          border: OutlineInputBorder()
        ));
  }

  @override
  Widget build(BuildContext context) {
    print("secondscreen");
    return Scaffold(
        appBar: AppBar(
          title: Text("Подтверждение номера"),
        ),
        body: Center(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _wrapper(_somecodeFormField()),
              _wrapper(
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.toString() == somecode.toString()) {
                      print("Success!");
                    } else {
                      print("Wrong");
                    }
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        )));
  }
}
