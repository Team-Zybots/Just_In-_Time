import 'package:flutter/material.dart';

// --- OOP DATA MODEL ---
// This demonstrates encapsulating real-world transaction data into an object.
class Invoice {
  final String id;
  final String patientName;
  final String doctorName;
  final double amount;
  bool isPaid; // Mutable state

  Invoice({required this.id, required this.patientName, required this.doctorName, required this.amount, this.isPaid = false});
}

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  // Mock Database of Invoices
  List<Invoice> invoices = [
    Invoice(id: 'INV-001', patientName: 'Kamal Perera', doctorName: 'Dr. Wijesekara', amount: 2500.00, isPaid: true),
    Invoice(id: 'INV-002', patientName: 'Nimali Silva', doctorName: 'Dr. Perera', amount: 3000.00, isPaid: false),
    Invoice(id: 'INV-003', patientName: 'Sunil Shantha', doctorName: 'Dr. Wijesekara', amount: 2500.00, isPaid: false),
    Invoice(id: 'INV-004', patientName: 'Amara Fernando', doctorName: 'Dr. Fernando', amount: 2000.00, isPaid: true),
  ];

  // Logic to calculate dashboard stats
  double get totalRevenue => invoices.where((i) => i.isPaid).fold(0, (sum, item) => sum + item.amount);
  int get pendingCount => invoices.where((i) => !i.isPaid).length;

  void _togglePaymentStatus(int index) {
    setState(() {
      invoices[index].isPaid = !invoices[index].isPaid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payments & Billing',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 24),

          // --- SUMMARY CARDS ---
          Row(
            children: [
              _buildStatCard('Total Revenue (Collected)', 'Rs. ${totalRevenue.toStringAsFixed(2)}', const Color(0xFF10B981), Icons.account_balance_wallet),
              const SizedBox(width: 24),
              _buildStatCard('Pending Invoices', '$pendingCount', const Color(0xFFF59E0B), Icons.pending_actions),
            ],
          ),
          const SizedBox(height: 32),

          // --- LEDGER TABLE ---
          Expanded(
            child: Card(
              color: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: SizedBox(
                width: double.infinity,
                child: DataTable(
                  headingTextStyle: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold),
                  dataTextStyle: const TextStyle(color: Colors.white),
                  columns: const [
                    DataColumn(label: Text('Invoice ID')),
                    DataColumn(label: Text('Patient Name')),
                    DataColumn(label: Text('Consulting Doctor')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Action')),
                  ],
                  rows: List.generate(invoices.length, (index) {
                    final invoice = invoices[index];
                    return DataRow(
                      cells: [
                        DataCell(Text(invoice.id, style: const TextStyle(fontWeight: FontWeight.bold))),
                        DataCell(Text(invoice.patientName)),
                        DataCell(Text(invoice.doctorName)),
                        DataCell(Text('Rs. ${invoice.amount.toStringAsFixed(2)}')),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: invoice.isPaid ? Colors.green.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              invoice.isPaid ? 'PAID' : 'PENDING',
                              style: TextStyle(color: invoice.isPaid ? Colors.greenAccent : Colors.orangeAccent, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        DataCell(
                          ElevatedButton(
                            onPressed: () => _togglePaymentStatus(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: invoice.isPaid ? const Color(0xFF334155) : const Color(0xFF06B6D4),
                              foregroundColor: Colors.white,
                            ),
                            child: Text(invoice.isPaid ? 'Undo' : 'Mark as Paid'),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // OOP Helper Widget
  Widget _buildStatCard(String title, String value, Color iconColor, IconData icon) {
    return Expanded(
      child: Card(
        color: const Color(0xFF1E293B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: iconColor.withOpacity(0.2), radius: 30, child: Icon(icon, color: iconColor, size: 30)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14)),
                  const SizedBox(height: 8),
                  Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}