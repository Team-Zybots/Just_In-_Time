import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Just-In-time",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF06B6D4)),
            ),
            const SizedBox(height: 10),
            const Text("Login to manage your queue", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 50),
            TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Phone Number",
                prefixIcon: const Icon(Icons.phone_android, color: Color(0xFF06B6D4)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/otp'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF06B6D4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("Get OTP", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/signup'),
              child: const Text("Don't have an account? Sign Up", style: TextStyle(color: Color(0xFF06B6D4))),
            )
          ],
        ),
      ),
    );
  }
}