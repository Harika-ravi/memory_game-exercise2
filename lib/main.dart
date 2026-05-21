import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MemoryMatchApp());

class MemoryMatchApp extends StatelessWidget {
  const MemoryMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Match',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF6C5CE7)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}