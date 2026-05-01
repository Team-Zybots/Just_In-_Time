import 'package:flutter/material.dart';

class ManageDoctorsScreen extends StatefulWidget {
  const ManageDoctorsScreen({super.key});

  @override
  State<ManageDoctorsScreen> createState() => _ManageDoctorsScreenState();
}

class _ManageDoctorsScreenState extends State<ManageDoctorsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- HEADER SECTION ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Manage Doctors',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Open "Add Doctor" Modal
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Doctor'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF06B6D4), // Signature Cyan
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // --- DATA TABLE SECTION ---
          Expanded(
            child: Card(
              color: const Color(0xFF1E293B), // Dark Navy Card
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: SizedBox(
                width: double.infinity,
                child: DataTable(
                  headingTextStyle: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold),
                  dataTextStyle: const TextStyle(color: Colors.white),
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Specialization')),
                    DataColumn(label: Text('Room')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: [
                    // Mock Data Row 1
                    _buildDoctorRow('Dr. Wijesekara', 'Cardiologist', 'Room 101', true),
                    // Mock Data Row 2
                    _buildDoctorRow('Dr. Perera', 'Neurologist', 'Room 204', false),
                    // Mock Data Row 3
                    _buildDoctorRow('Dr. Fernando', 'Pediatrician', 'Room 105', true),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // OOP Principle: Encapsulation & Reusability (Helper Method)
  DataRow _buildDoctorRow(String name, String spec, String room, bool isActive) {
    return DataRow(
      cells: [
        DataCell(Text(name, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(spec)),
        DataCell(Text(room)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isActive ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isActive ? 'Active' : 'Off-Duty',
              style: TextStyle(color: isActive ? Colors.greenAccent : Colors.redAccent, fontSize: 12),
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(icon: const Icon(Icons.edit, color: Colors.white70, size: 20), onPressed: () {}),
              IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20), onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }
}