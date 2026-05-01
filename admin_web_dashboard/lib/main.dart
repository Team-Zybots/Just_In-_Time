import 'package:flutter/material.dart';
import 'package:admin_web_dashboard/screens/live_queue_screen.dart';
import 'package:admin_web_dashboard/screens/payments_screen.dart';
import 'package:admin_web_dashboard/screens/manage_doctors_screen.dart';
void main() {
  runApp(const AdminDashboardApp());
}

class AdminDashboardApp extends StatelessWidget {
  const AdminDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Just-In-Time Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Applying Team Zybots Brand Colors
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Slate Navy
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF06B6D4), // Signature Cyan
          surface: Color(0xFF1E293B), // Slightly lighter navy for cards
        ),
        fontFamily: 'Inter', // Or whatever font you chose
      ),
      home: const AdminShell(), // Boots the navigation layout
    );
  }
}

// --- THE APPLICATION SHELL (NAVIGATION) ---
class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int _selectedIndex = 0;

  // These are the screens the admin can switch between
  final List<Widget> _screens = [
  const LiveQueueScreen(), 
  const ManageDoctorsScreen(),
  const PaymentsScreen(), // <-- THE FINAL SCREEN IS CONNECTED
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 1. The Side Navigation Bar
          NavigationRail(
            backgroundColor: const Color(0xFF1E293B),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedIconTheme: const IconThemeData(color: Color(0xFF06B6D4)),
            selectedLabelTextStyle: const TextStyle(color: Color(0xFF06B6D4), fontWeight: FontWeight.bold),
            unselectedIconTheme: const IconThemeData(color: Colors.white70),
            unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.people_outline),
                selectedIcon: Icon(Icons.people),
                label: Text('Live Queue'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.medical_services_outlined),
                selectedIcon: Icon(Icons.medical_services),
                label: Text('Doctors'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.payments_outlined),
                selectedIcon: Icon(Icons.payments),
                label: Text('Payments'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1, color: Colors.black26),
          
          // 2. The Main Content Area (Changes based on selection)
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}