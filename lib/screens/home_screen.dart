import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // จำลองข้อมูลบริการจากในวิดีโอ
  final List<Map<String, dynamic>> services = const [
    {
      'title': 'ดูแลอยู่บ้าน',
      'icon': Icons.home_filled,
      'color': Color(0xFFE8F5E9), // สีเขียวอ่อน
      'iconColor': Color(0xFF4CAF50),
    },
    {
      'title': 'พาไปพบแพทย์',
      'icon': Icons.local_hospital,
      'color': Color(0xFFE3F2FD), // สีฟ้าอ่อน
      'iconColor': Color(0xFF2196F3),
    },
    {
      'title': 'ดูแลหลังคลอด',
      'icon': Icons.child_friendly,
      'color': Color(0xFFFFF3E0), // สีส้มอ่อน
      'iconColor': Color(0xFFFF9800),
    },
    {
      'title': 'พาไปเที่ยว',
      'icon': Icons.directions_car,
      'color': Color(0xFFF3E5F5), // สีม่วงอ่อน
      'iconColor': Color(0xFF9C27B0),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'กรุณาเลือกบริการ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner ด้านบน
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
                    'ดูแลคนที่คุณรัก ด้วยใจและมาตรฐาน',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'หมวดหมู่บริการ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Grid แสดงบริการ
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return _buildServiceCard(context, services[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, Map<String, dynamic> service) {
    return GestureDetector(
      onTap: () {
        // TODO: นำทางไปยังหน้ากรอกรายละเอียดผู้รับบริการ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เลือกบริการ: ${service['title']}')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: service['color'],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(service['icon'], size: 48, color: service['iconColor']),
            const SizedBox(height: 12),
            Text(
              service['title'],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
