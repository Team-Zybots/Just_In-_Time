import 'package:flutter/material.dart';

class ApptsScreen extends StatelessWidget {
  const ApptsScreen({super.key});

  // Signature Just-In-Time Colors
  static const primaryTeal = Color(0xFF06B6D4);
  static const highlightBlue = Color(0xFFE0F7FA);

  @override
  Widget build(BuildContext context) { 
    return Column(
      children: [
        _header(context), 
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(), // Essential for Chrome emulator
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Upcoming Appointments",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  
                  // Appointment List
                  const AppointmentCard(
                    name: "Dr.Wijesekara",
                    type: "Cardiology Checkup",
                    date: "Jan 28, 2026",
                    time: "10:30 AM",
                    status: "Today",
                    isHighlighted: true,
                  ),
                  const AppointmentCard(
                    name: "Dr.Rathnayake",
                    type: "General Consultation",
                    date: "Feb 5, 2026",
                    time: "2:00 PM",
                    status: "Upcoming",
                  ),
                  const AppointmentCard(
                    name: "Dr.Jayaweera",
                    type: "Eye Examination",
                    date: "Feb 12, 2026",
                    time: "11:00 AM",
                    status: "Upcoming",
                  ),

                const SizedBox(height: 25),

                  // Updated Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      // --- NAVIGATION LOGIC ADDED HERE ---
                      onPressed: () {
                        Navigator.pushNamed(context, '/book_appt');
                      },
                      // ------------------------------------
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryTeal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Book New Appointment",
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Header UI ---
  Widget _header(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.only(top: topPadding + 15, left: 25, right: 25, bottom: 25),
      decoration: const BoxDecoration(
        color: primaryTeal,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Just-In-time", 
                style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              Text("Appointments Hub", style: TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white, size: 30),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
        ],
      ),
    );
  }
}

// --- Reusable Appointment Card ---
class AppointmentCard extends StatelessWidget {
  final String name, type, date, time, status;
  final bool isHighlighted;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.type,
    required this.date,
    required this.time,
    required this.status,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isHighlighted ? ApptsScreen.highlightBlue : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlighted ? ApptsScreen.primaryTeal : Colors.grey.shade200,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _statusChip(status),
            ],
          ),
          const SizedBox(height: 5),
          Text(type, style: const TextStyle(color: Colors.black54, fontSize: 15)),
          const Divider(height: 25, thickness: 0.5),
          Row(
            children: [
              _infoRow(Icons.calendar_today_outlined, date),
              const SizedBox(width: 25),
              _infoRow(Icons.access_time, time),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    bool active = status == "Today";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: active ? ApptsScreen.primaryTeal : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status, style: TextStyle(
        color: active ? Colors.white : Colors.black54, 
        fontSize: 11, 
        fontWeight: FontWeight.bold
      )),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: ApptsScreen.primaryTeal),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
      ],
    );
  }
}