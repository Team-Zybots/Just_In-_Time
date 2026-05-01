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
                style: TextStyle(
                  fontSize: 28, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _showAddDoctorModal, // Opens the Input Modal
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
                child: SingleChildScrollView(
                  child: DataTable(
                    headingTextStyle: const TextStyle(
                      color: Color(0xFF94A3B8), 
                      fontWeight: FontWeight.bold,
                    ),
                    dataTextStyle: const TextStyle(color: Colors.white),
                    columns: const [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Specialization')),
                      DataColumn(label: Text('Room')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: [
                      _buildDoctorRow('Dr. Wijesekara', 'Cardiologist', 'Room 101', true),
                      _buildDoctorRow('Dr. Perera', 'Neurologist', 'Room 204', false),
                      _buildDoctorRow('Dr. Fernando', 'Pediatrician', 'Room 105', true),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- MODAL DIALOG FOR ADDING DOCTORS ---
  void _showAddDoctorModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Register New Doctor', style: TextStyle(color: Colors.white)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildModalTextField('Full Name', Icons.person),
              const SizedBox(height: 16),
              _buildModalTextField('Specialization', Icons.medical_services),
              const SizedBox(height: 16),
              _buildModalTextField('Room Number', Icons.door_front_door),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          ElevatedButton(
            onPressed: () {
              // Logic to send data to your Spring Boot backend goes here
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF06B6D4)),
            child: const Text('Add to System'),
          ),
        ],
      ),
    );
  }

  // Helper for Modal TextFields
  Widget _buildModalTextField(String label, IconData icon) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
        prefixIcon: Icon(icon, color: const Color(0xFF06B6D4)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white10),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF06B6D4)),
        ),
      ),
    );
  }

  // Helper for Table Rows
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
              style: TextStyle(
                color: isActive ? Colors.greenAccent : Colors.redAccent, 
                fontSize: 12,
              ),
            ),
          ),
        ),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.white70, size: 20), 
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent, size: 20), 
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}