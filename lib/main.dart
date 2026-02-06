import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const FisherAIApp());
}

class FisherAIApp extends StatelessWidget {
  const FisherAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fisher AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
