import 'package:flutter/material.dart';

class ClinicScreen extends StatelessWidget {
  const ClinicScreen({super.key});

  // Colors based on your uploaded design
  static const primaryTeal = Color(0xFF53C8D8);
  static const backgroundGray = Color(0xFFF8F9FB);
  static const serviceBlue = Color(0xFFE0F7FA);

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        _header(context),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _clinicIntroCard(),
                const SizedBox(height: 16),
                _contactInfoCard(),
                const SizedBox(height: 16),
                _operatingHoursCard(),
                const SizedBox(height: 16),
                _servicesOfferedCard(),
                const SizedBox(height: 30), // Extra space for better scrolling
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- UI Sections ---

  Widget _header(BuildContext context) {
    // Handles the status bar/notch area height
    final double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: topPadding + 10, left: 20, right: 20, bottom: 25),
      color: primaryTeal,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Just-In-time', 
                style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
              Text('Clinic Info', style: TextStyle(color: Colors.white70)),
            ],
          ),
          Row(
            children: [
              Icon(Icons.notifications_none, color: Colors.white, size: 28),
              SizedBox(width: 15),
              Icon(Icons.menu, color: Colors.white, size: 28),
            ],
          )
        ],
      ),
    );
  }

  Widget _clinicIntroCard() {
    return _cardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: serviceBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.business, color: Color(0xFF03A9F4), size: 35),
              ),
              const SizedBox(width: 15),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Heart Care Clinic', 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Specialized Cardiology Center', 
                    style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.orange, size: 20)) +
              [const SizedBox(width: 8), const Text('4.9 (1,235 reviews)', style: TextStyle(color: Colors.grey))],
          ),
          const SizedBox(height: 12),
          const Text(
            'A state-of-the-art cardiology clinic providing comprehensive heart care services with advanced diagnostic and treatment facilities.',
            style: TextStyle(color: Colors.black87, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _contactInfoCard() {
    return _cardWrapper(
      title: 'Contact Information',
      child: Column(
        children: [
          _infoRow(Icons.phone_outlined, '011-2223550', 'Main line'),
          _infoRow(Icons.email_outlined, 'info@heartcareclinic.com', 'Email'),
          _infoRow(Icons.location_on_outlined, 'No. 110, 1st Lane, Moratuwa, Colombo.', 'Address'),
        ],
      ),
    );
  }

  Widget _operatingHoursCard() {
    return _cardWrapper(
      title: 'Operating Hours',
      child: Column(
        children: [
          _timeRow('Monday - Friday', '9:00 AM - 5:00 PM'),
          _timeRow('Saturday', '9:00 AM - 1:00 PM'),
          _timeRow('Sunday', 'Closed', isClosed: true),
        ],
      ),
    );
  }

  Widget _servicesOfferedCard() {
    return _cardWrapper(
      title: 'Services Offered',
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _serviceChip('ECG'),
          _serviceChip('Stress Test'),
          _serviceChip('Echo Test'),
          _serviceChip('Holter Monitor'),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _cardWrapper({String? title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 15),
          ],
          child,
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String main, String sub) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: Colors.grey, size: 22),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(main, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _timeRow(String day, String hours, {bool isClosed = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: const TextStyle(color: Colors.black54)),
          Text(hours, style: TextStyle(fontWeight: FontWeight.bold, color: isClosed ? Colors.red : Colors.black87)),
        ],
      ),
    );
  }

  Widget _serviceChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: serviceBlue, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFF00BCD4), size: 18),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }
}
