import 'package:agrogenicprl/authentication/startup_screen.dart';
import 'package:agrogenicprl/screens/PirDataPage.dart';
import 'package:agrogenicprl/screens/dashboard.dart';
import 'package:agrogenicprl/screens/dataPage.dart';
import 'package:agrogenicprl/utils/bottomnavi.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agrogenicprl',
      theme: ThemeData(),
      //home:  splashScreen()
      // home:  Dashboard()
      // home: const DataPage(),
      home: const PIRDataPage(),
    );
  }
}
