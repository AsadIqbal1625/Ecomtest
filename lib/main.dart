import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

// import 'package:mypoll2/home_screen/home_screen_view.dart';

import 'authentication/auth_services.dart';

void main() async {
  if (kIsWeb) {
    {
      const firebaseConfig = {
        "apiKey": "AIzaSyBWX1SLcRgtavtU49OpGXJA9IfSqXDEkNg",
        "authDomain": "biggyfirebase.firebaseapp.com",
        "projectId": "biggyfirebase",
        "storageBucket": "biggyfirebase.appspot.com",
        "messagingSenderId": "25041389728",
        "appId": "1:25041389728:web:010b13627d8a2e51c261c5",
        "measurementId": "G-FP0CK5QZS0"
      };

      // Initialize Firebase
      await Firebase.initializeApp(
          options: FirebaseOptions.fromMap(firebaseConfig));

      runApp(const MyApp());
    }
  } else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthService().handleAuth(),
    );
  }
}
