import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:login_registration_api_otp/model/RegistrationApiResponse.dart';
import 'package:login_registration_api_otp/screens/otp.dart';
import 'package:login_registration_api_otp/screens/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _name;
  static var nm;
  static var _email;
  static var _phoneNumber;
  static var _password;
  SharedPreferences? prefs;

  register(
      String name, email, phoneNumber, password, countryCode, context) async {
    prefs = await SharedPreferences.getInstance();
    Map data1 = {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'countryCode': 'BD'
    };
    print(data1);
    _name = name;
    print(" User name(1) ");
    print(_name);

    String body = json.encode(data1);
    var url = Uri.parse(
        'http://user-api-dev.london-design-studios.com/api/v1/otps/register/send');
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );
    prefs!.setString('name', name);
    prefs!.setString('email', email);
    prefs!.setString('phoneNumber', phoneNumber);
    prefs!.setString('password', password);

    nm = prefs!.getString('name');
    _email = prefs!.getString('email');
    _phoneNumber = prefs!.getString('phoneNumber');
    _password = prefs!.getString('password');

    print("nm" + nm + _email + _phoneNumber + _password);

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //Or put here your next screen using Navigator.push() method
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OtpPage()));

      print('success');
    } else {
      print('error');
    }
  }

  registerOtp(String otpNumberForEmail, otpNumberForPhone, context) async {
    print(" User name (otp) " + nm);

    Map data = {
      'name': nm,
      'email': _email,
      'phoneNumber': _phoneNumber,
      'password': _password,
      'countryCode': 'BD',
      'otpNumberForEmail': otpNumberForEmail,
      'otpNumberForPhone': otpNumberForPhone,
    };
    print(data);
    print(" User name ${data["_name"]}");
    // print(" User name2 ${data["name"]}");

    String body = json.encode(data);

    var url = Uri.parse(
        'http://user-api-dev.london-design-studios.com/api/v1/users/register');
    var response = await http.post(
      url,
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //Or put here your next screen using Navigator.push() method
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignIn()));
      print('success');
    } else {
      print('error');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
        'email': email,
        'password': password
    };

    notifyListeners();
    var url = Uri.parse(
        'http://user-api-dev.london-design-studios.com/api/v1/users/login');

    Response response = await post(
      url,
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData['data'];

      
          
      notifyListeners();
      print('success');
      result = {'status': true, 'message': 'Successful'};
    } else {
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
      print('Error');
    }
    return result;
  }

}
