import 'package:flutter/material.dart';

class AddDoctorScreen extends StatelessWidget {
  const AddDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Doctor')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: 'Doctor Name')),
            const TextField(decoration: InputDecoration(labelText: 'Specialization')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // This is where you will eventually call your backend API
                Navigator.pop(context); 
              },
              child: const Text('Save Doctor'),
            ),
          ],
        ),
      ),
    );
  }
}