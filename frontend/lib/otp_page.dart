import 'package:flutter/material.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.mark_email_read_outlined, size: 80, color: Color(0xFF06B6D4)),
            const SizedBox(height: 30),
            const Text("Verify Phone", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Enter the code sent to your mobile", textAlign: TextAlign.center),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) => _otpField(context)),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/main'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF06B6D4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text("Verify & Login", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _otpField(BuildContext context) {
    return SizedBox(
      width: 60,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(counterText: "", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      ),
    );
  }
}