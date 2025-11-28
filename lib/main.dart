import 'package:flutter/material.dart';
import 'doctor_citas.dart';
import 'splash_screen.dart'; // Asegúrate de importar el SplashScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Citas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: SplashScreen(), // Solo UN home, inicia con el SplashScreen
    );
  }
}
