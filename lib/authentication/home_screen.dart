import 'package:flutter/material.dart';

import 'auth_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You are logged in'),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              AuthService().signOut();
            },
            child: const Center(
              child: Text('Sign out'),
            ),
          )
        ],
      ),
    );
  }
}
