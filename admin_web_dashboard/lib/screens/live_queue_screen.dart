import 'package:flutter/material.dart';

class LiveQueueScreen extends StatefulWidget {
  const LiveQueueScreen({super.key});

  @override
  State<LiveQueueScreen> createState() => _LiveQueueScreenState();
}

class _LiveQueueScreenState extends State<LiveQueueScreen> {
  // Mock State for the UI demonstration
  int currentToken = 25;
  List<int> waitingQueue = [26, 27, 28, 29, 30];

  void _advanceQueue() {
    setState(() {
      if (waitingQueue.isNotEmpty) {
        currentToken = waitingQueue.removeAt(0);
      }
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
            'Live Queue Control',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 32),
          
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- LEFT COLUMN: CURRENT PATIENT CONTROL ---
                Expanded(
                  flex: 1,
                  child: Card(
                    color: const Color(0xFF1E293B), // Dark Navy
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('NOW SERVING', style: TextStyle(color: Color(0xFF94A3B8), letterSpacing: 2)),
                          const SizedBox(height: 16),
                          Text(
                            '#$currentToken',
                            style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Color(0xFF06B6D4)),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton.icon(
                              onPressed: _advanceQueue,
                              icon: const Icon(Icons.skip_next),
                              label: const Text('Call Next Patient', style: TextStyle(fontSize: 18)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF10B981), // Emerald Green (Success)
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: OutlinedButton.icon(
                              onPressed: () {}, // TODO: Handle No-Show
                              icon: const Icon(Icons.person_off),
                              label: const Text('Mark as No-Show'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFFF43F5E), // Rose Red (Alert)
                                side: const BorderSide(color: Color(0xFFF43F5E)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 24),
                
                // --- RIGHT COLUMN: UPCOMING QUEUE LIST ---
                Expanded(
                  flex: 2,
                  child: Card(
                    color: const Color(0xFF1E293B),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Up Next (${waitingQueue.length} Waiting)', 
                               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.separated(
                              itemCount: waitingQueue.length,
                              separatorBuilder: (context, index) => const Divider(color: Colors.white10),
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: const Color(0xFF0F172A),
                                    child: Text('${waitingQueue[index]}', style: const TextStyle(color: Color(0xFF06B6D4))),
                                  ),
                                  title: Text('Patient Token #${waitingQueue[index]}', style: const TextStyle(color: Colors.white)),
                                  subtitle: Text('Est. Wait: ${(index + 1) * 8} mins', style: const TextStyle(color: Color(0xFF94A3B8))),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.more_vert, color: Colors.white54),
                                    onPressed: () {},
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}