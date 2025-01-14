import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;
  int _timerSeconds = 0; // Timer value in seconds
  Timer? _timer; // Timer instance

  void _startTimer() {
    _timerSeconds = 0; // Reset timer
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timerSeconds++;
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _timer?.cancel();
      _timerSeconds = 0;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _startTimer(); // Start timer on button press
  }

  void _clearCounter() {
    setState(() {
      _counter = 0;
    });
    _stopTimer(); // Stop timer on button press
  }

  String formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60; // Divides and gets the integer result
    int seconds = totalSeconds % 60; // Gets the remainder
    // Formats the minutes and seconds, ensuring they are always two digits
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          TextButton(
            onPressed: _clearCounter,
            child: const Text(
              'Очистить',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            onPressed: _incrementCounter,
            child: const Text(
              'Добавить подход',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Подходов: $_counter',
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20), // Add space between texts
            Text(
              formatTime(_timerSeconds),
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Always cancel the timer to avoid memory leaks
    super.dispose();
  }
}
