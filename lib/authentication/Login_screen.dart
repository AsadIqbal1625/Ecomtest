import 'package:flutter/material.dart';

import 'auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '', password = '';

  final formKey = GlobalKey<FormState>();

  checkFields() {
    final form = formKey.currentState;
    if (form!.validate()) {
      return false;
    } else {
      return true;
    }
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 250.0,
          width: 300.0,
          child: Column(
            children: <Widget>[
              Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 20.0, bottom: 5.0),
                          child: SizedBox(
                            height: 50.0,
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(hintText: 'Email'),
                              validator: (value) => value!.isEmpty
                                  ? "Email required"
                                  : validateEmail(value.trim()),
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 20.0, bottom: 5.0),
                          child: SizedBox(
                            height: 50.0,
                            child: TextFormField(
                              obscureText: true,
                              decoration:
                                  const InputDecoration(hintText: 'Password'),
                              validator: (value) =>
                                  value!.isEmpty ? "Password is required" : "",
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                          )),
                      InkWell(
                          onTap: () {
                            if (checkFields()) {
                              AuthService().signIn(email, password);
                            }
                          },
                          child: Container(
                              height: 40.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                              ),
                              child: const Center(child: Text('Sign in'))))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
