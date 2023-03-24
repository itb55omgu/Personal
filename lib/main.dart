
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'forms/phone_screen_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: PhoneScreen()

    );
  }
}



