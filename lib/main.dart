import 'package:flutter/material.dart';
import 'package:kindora/screens/edit_profile_screen.dart';
import 'package:kindora/screens/home_screen.dart';
import 'package:kindora/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KindOra',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: SplashScreen(),
      home: EditProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
