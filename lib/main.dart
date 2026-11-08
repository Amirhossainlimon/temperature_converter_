
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'temperature_controller.dart';
import 'splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TemperatureController(),
      child: const TemperatureConverterApp(),
    ),
  );
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thermos',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5F7FC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF536DFE),
        ),
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}
