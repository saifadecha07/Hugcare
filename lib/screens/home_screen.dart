import 'package:flutter/material.dart';
import 'select_patient_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.volunteer_activism, color: Colors.blue, size: 30),
            const SizedBox(width: 8),
            Text(
              'HUGCARE',
              style: TextStyle(
                color: Colors.blue[800],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Banner ส่วนบน
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00C853), Color(0xFF64DD17)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HUGCARE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'ดูแลคนที่คุณรัก ด้วยใจบริการในทุกๆ วัน',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(height: 12),
                    Chip(
                      label: Text('ติดต่อเรา', style: TextStyle(fontSize: 12)),
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'กรุณาเลือกบริการ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Grid View
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
                children: [
                  //  context
                  _buildServiceCard(
                    context,
                    'ดูแลที่บ้าน',
                    Icons.home_filled,
                    Colors.green,
                  ),
                  _buildServiceCard(
                    context,
                    'พาไปพบแพทย์',
                    Icons.local_hospital,
                    Colors.teal,
                  ),
                  _buildServiceCard(
                    context,
                    'ดูแลส่วนตัว',
                    Icons.person,
                    Colors.orange,
                  ),
                  _buildServiceCard(
                    context,
                    'พาเที่ยว',
                    Icons.directions_car,
                    Colors.blue,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // build method อยู่ในคลาส HomeScreen
  Widget _buildServiceCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        // คำสั่งเปลี่ยนหน้า
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectPatientScreen(serviceName: title),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
