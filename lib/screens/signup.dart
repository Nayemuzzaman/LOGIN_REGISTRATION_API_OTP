import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter/widgets.dart';
import 'package:login_registration_api_otp/provider/AuthProvider.dart';
import 'package:login_registration_api_otp/screens/otp.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController phoneNumber = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController countryCode = new TextEditingController();
  var updatedPhone;


  Widget _entryNameField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          //name textfield
          Container(
            child: TextField(
              controller: name,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryEmailField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          //name textfield
          Container(
            child: TextField(
              controller: email,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryPhoneField(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              child: IntlPhoneField(
            controller: phoneNumber,
            decoration: InputDecoration(
              //decoration for Input Field
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            initialCountryCode: 'BD', //default contry code, BD for Bangladesh
            onChanged: (phone) {
              updatedPhone = phone.completeNumber.replaceAll('+', '');
              //when phone number country code is changed
              print(phone.completeNumber); //get complete number
              print(phone.countryCode); // get country code only
              print(phone.number); // only phone number
            },
          )),
        ],
      ),
    );
  }

  Widget _entryPasswordField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          //name textfield
          Container(
            child: TextField(
              controller: password,
              obscureText: isPassword,
              decoration: InputDecoration(
                  hintText: "8 contains with 1 char and 1 digit",
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 55, 7, 151),
                Color.fromARGB(255, 52, 10, 168)
              ])),
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              //  Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage()));
              AuthProvider().register(name.text, email.text, updatedPhone,
                  password.text, 'BD', context);
            },
            child: Text(
              'Next',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'Create Your Account\n',
          style: TextStyle(
              color: Color.fromARGB(255, 245, 245, 244), fontSize: 30),
        ),
        TextSpan(
          text: 'Register to access your account',
          style: TextStyle(
              color: Color.fromARGB(255, 141, 140, 139), fontSize: 15),
        ),
      ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          _entryNameField("Name"),
          _entryEmailField("Email"),
          _entryPhoneField("Phone"),
          _entryPasswordField("Password", isPassword: true),
          _entryPasswordField("Confirmed Password", isPassword: true),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              // Colors.purple,
              Color.fromARGB(255, 17, 28, 226),
              Color.fromARGB(255, 78, 29, 210),
            ])),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            _title(),
            Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  margin: const EdgeInsets.only(top: 100),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _emailPasswordWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        _submitButton(),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
