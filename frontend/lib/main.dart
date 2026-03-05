import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'queue_screen.dart';
import 'appts_screen.dart'; 
import 'doctor_screen.dart';
import 'navigation_screen.dart';
import 'clinic_screen.dart';

void main() => runApp(const JustInTimeApp());

class JustInTimeApp extends StatelessWidget {
  const JustInTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // We define the list inside 'build' to pass the 'setState' logic to HomeScreen
    final List<Widget> _pages = [
      HomeScreen(onNavigate: (index) {
        setState(() => _currentIndex = index); // Updates the screen when a grid button is clicked
      }),
      const QueueScreen(),      // Index 1
      const ApptsScreen(),      // Index 2
      const DoctorScreen(),     // Index 3
      const NavigationScreen(), // Index 4
      const ClinicScreen(),     // Index 5
    ];

    return Scaffold(
      // Shows the page based on current index
      body: _pages[_currentIndex], 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex > 3 ? 0 : _currentIndex, // Highlights 'Home' if on sub-pages
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF06B6D4),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Queue"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Appts"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Doctor"),
        ],
      ),
    );
  }
}