import 'package:flutter/material.dart';

// Import all screens
import 'login_page.dart';
import 'signup_page.dart';
import 'otp_page.dart';
import 'home_screen.dart';
import 'queue_screen.dart';
import 'appts_screen.dart'; 
import 'doctor_screen.dart';
import 'navigation_screen.dart';
import 'clinic_screen.dart';
import 'book_appointment_page.dart';

void main() => runApp(const JustInTimeApp());

class JustInTimeApp extends StatelessWidget {
  const JustInTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Roboto'),
      // The app now starts with Login
      initialRoute: '/login', 
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/otp': (context) => const OtpPage(),
        '/main': (context) => const MainNavigation(),
        '/book_appt': (context) => const BookAppointmentPage(),
      },
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
    final List<Widget> _pages = [
      HomeScreen(onNavigate: (index) {
        setState(() => _currentIndex = index); 
      }),
      const QueueScreen(),      // Index 1
      const ApptsScreen(),      // Index 2
      const DoctorScreen(),     // Index 3
      const NavigationScreen(), // Index 4
      const ClinicScreen(),     // Index 5
    ];

    return Scaffold(
      body: _pages[_currentIndex], 
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex > 3 ? 0 : _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF06B6D4),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Queue"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: "Appts"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Doctor"),
        ],
      ),
    );
  }
}
