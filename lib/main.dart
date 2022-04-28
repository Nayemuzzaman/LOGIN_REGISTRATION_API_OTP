import 'package:flutter/material.dart';
import 'package:login_registration_api_otp/screens/otp.dart';
import 'package:login_registration_api_otp/screens/signin.dart';
import 'package:login_registration_api_otp/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      home: SignIn(),
    );
  }
}
