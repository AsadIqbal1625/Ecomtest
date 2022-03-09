import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mypoll2/home_screen/home_screen_view.dart';

import 'login_screen/login_screen_view.dart';

class AuthenticationPhone extends StatelessWidget {
  AuthenticationPhone({Key? key}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      return const HomeScreenView();
    } else {
      return const LoginScreen();
    }
  }
}
