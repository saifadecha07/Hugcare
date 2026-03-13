import 'package:flutter/material.dart';
import 'tracking_screen.dart';

// สร้างโครงสร้างข้อมูลจำลองสำหรับ Caregiver
class Caregiver {
  final String name;
  final int age;
  final double rating;
  final int price;
  final int reviews;

  Caregiver(this.name, this.age, this.rating, this.price, this.reviews);
}

class CaregiverSwipeScreen extends StatefulWidget {
  const CaregiverSwipeScreen({super.key});

  @override
  State<CaregiverSwipeScreen> createState() => _CaregiverSwipeScreenState();
}

class _CaregiverSwipeScreenState extends State<CaregiverSwipeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // ข้อมูลจำลองอ้างอิงจากในคลิป
  final List<Caregiver> _caregivers = [
    Caregiver('มายด์', 23, 4.8, 150, 21),
    Caregiver('ฝน', 25, 4.6, 180, 15),
    Caregiver('บอส', 28, 4.5, 140, 30),
    Caregiver('ต้น', 30, 4.4, 160, 42),
  ];

  void _nextProfile() {
    if (_currentIndex < _caregivers.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // โชว์ Pop-up ว่าแมตช์สำเร็จ!
      showDialog(
        context: context,
        barrierDismissible: false, // บังคับให้ต้องกดปุ่มในกรอบ
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text(
                'คัดเลือกสำเร็จ!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            'ระบบได้ยืนยันการนัดหมายกับ "คุณ ${_caregivers[_currentIndex].name}" เรียบร้อยแล้วครับ',
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                Navigator.pop(context); // ปิดหน้าต่าง Pop-up
                // ใช้ pushReplacement เพื่อไปหน้า Tracking แบบกดย้อนกลับมาหน้าปัดไม่ได้อีก
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrackingScreen(
                      caregiverName: _caregivers[_currentIndex].name,
                    ),
                  ),
                );
              },
              child: const Text(
                'ดูสถานะการเดินทาง',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'คัดเลือก Caregiver',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'ปัดขวาเพื่อเลือก ปัดซ้ายเพื่อข้าม',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics:
                  const NeverScrollableScrollPhysics(), // ปิดการใช้คิ้วปัด เพื่อบังคับให้กดปุ่ม (หรือเปิดไว้ถ้าอยากให้เอานิ้วปัดได้)
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _caregivers.length,
              itemBuilder: (context, index) {
                final caregiver = _caregivers[index];
                return _buildProfileCard(caregiver);
              },
            ),
          ),
          // ปุ่มกดด้านล่าง (Nope / Like)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32.0,
              horizontal: 40.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  icon: Icons.close,
                  color: Colors.red,
                  onTap: () {
                    print('ข้าม ${_caregivers[_currentIndex].name}');
                    _nextProfile();
                  },
                ),
                _buildActionButton(
                  icon: Icons.favorite,
                  color: Colors.green,
                  onTap: () {
                    print('ถูกใจ ${_caregivers[_currentIndex].name}');
                    _nextProfile();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // สร้างการ์ดโปรไฟล์
  Widget _buildProfileCard(Caregiver caregiver) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // พื้นที่สำหรับรูปภาพ
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade300,
            ),
            child: const Icon(
              Icons.person,
              size: 150,
              color: Colors.white,
            ), // แทนที่ด้วย Image.network ได้
          ),

          // ป้ายราคามุมขวาบน
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${caregiver.price} ฿/ชม.',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ),

          // ข้อมูลด้านล่างของการ์ด
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        caregiver.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      Text(
                        ' ${caregiver.rating}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'อายุ ${caregiver.age} ปี • ${caregiver.reviews} ยอดถูกใจ',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'นักศึกษาพยาบาล • ใจเย็น อารมณ์ดี ดูแลผู้สูงอายุได้ดี',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ปุ่มกลมๆ สำหรับกด Like / Nope
  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 40),
      ),
    );
  }
}
