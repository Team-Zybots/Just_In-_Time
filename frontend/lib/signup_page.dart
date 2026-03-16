import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create Account", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            _buildInput("Full Name", Icons.person_outline),
            const SizedBox(height: 20),
            _buildInput("Email Address", Icons.email_outlined),
            const SizedBox(height: 20),
            _buildInput("Phone Number", Icons.phone_outlined),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/otp'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF06B6D4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String hint, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: const Color(0xFF06B6D4)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}