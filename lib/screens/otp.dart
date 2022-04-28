import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_registration_api_otp/provider/AuthProvider.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  // 4 text editing controllers that associate with the 4 input fields
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();

  final TextEditingController _fieldOne1 = TextEditingController();
  final TextEditingController _fieldTwo2 = TextEditingController();
  final TextEditingController _fieldThree3 = TextEditingController();
  final TextEditingController _fieldFour4 = TextEditingController();
  final TextEditingController _fieldFive5 = TextEditingController();
  // This is the entered code
  // It will be displayed in a Text widget
  var _otp;
  var _otp1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Email verification'),
          const SizedBox(
            height: 30,
          ),
          // Implement 4 input fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OtpInput(_fieldOne, true),
              OtpInput(_fieldTwo, true),
              OtpInput(_fieldThree, true),
              OtpInput(_fieldFour, true),
              OtpInput(_fieldFive, true)
            ],
          ),
          const SizedBox(
            height: 30,
          ),

          const Text('Phone verification'),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OtpInput(_fieldOne1, true),
              OtpInput(_fieldTwo2, true),
              OtpInput(_fieldThree3, true),
              OtpInput(_fieldFour4, true),
              OtpInput(_fieldFive5, true)
            ],
          ),
          const SizedBox(
            height: 30,
          ),

          ElevatedButton(
              onPressed: () {
                setState(() {
                  _otp = _fieldOne.text +
                      _fieldTwo.text +
                      _fieldThree.text +
                      _fieldFour.text +
                      _fieldFive.text;
                  _otp1 = _fieldOne1.text +
                      _fieldTwo2.text +
                      _fieldThree3.text +
                      _fieldFour4.text +
                      _fieldFive5.text;
                });
                AuthProvider().registerOtp(_otp, _otp1,context);
                print("otp" + _otp + "otp2" + _otp1);
              },
              child: const Text('Submit')),

          const SizedBox(
            height: 30,
          ),
          // Display the entered OTP code
          Column(
            children: [
              Text(
                _otp ?? 'Please enter OTP',
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                _otp1 ?? 'Please enter OTP',
                style: const TextStyle(fontSize: 30),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// Create an input widget that takes only one digit
class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
