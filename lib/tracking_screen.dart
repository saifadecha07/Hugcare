import 'package:flutter/material.dart';
import 'chat_screen.dart';

class TrackingScreen extends StatelessWidget {
  final String caregiverName;

  const TrackingScreen({super.key, required this.caregiverName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'ติดตามงาน',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        // จุดที่ 1: ดักปุ่ม Back มุมซ้ายบน ให้ล้างหน้าจอทั้งหมดและกลับไปหน้าแรก (Home)
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
      body: Column(
        children: [
          // ส่วนบน: แผนที่จำลอง
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Colors.blueGrey.shade100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 80,
                    color: Colors.blueGrey.shade300,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'แผนที่จำลอง (รอเชื่อม Google Maps)',
                    style: TextStyle(color: Colors.blueGrey.shade600),
                  ),
                ],
              ),
            ),
          ),

          // ส่วนล่าง: ข้อมูล Caregiver และ Timeline สถานะ
          Expanded(
            flex:
                4, // ปรับ flex ให้พื้นที่ส่วนล่างกว้างขึ้นนิดหน่อยเพื่อรองรับปุ่มใหม่
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // ข้อมูล Caregiver และปุ่มติดต่อ
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.green.shade100,
                        child: const Icon(
                          Icons.person,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'คุณ $caregiverName',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Caregiver',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      // ปุ่มโทร
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.phone, color: Colors.green),
                          onPressed: () {
                            print('โทรหา $caregiverName');
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      // ปุ่มแชท
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.chat_bubble,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChatScreen(caregiverName: caregiverName),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Divider(thickness: 1),
                  ),

                  // Timeline สถานะงาน
                  Expanded(
                    child: ListView(
                      children: [
                        _buildTimelineItem('ออกเดินทาง', '08:30', isDone: true),
                        _buildTimelineItem(
                          'ถึงโรงพยาบาล',
                          '08:50',
                          isDone: true,
                        ),
                        _buildTimelineItem(
                          'พบแพทย์',
                          'NOT YET',
                          isDone: false,
                          isLast: true,
                        ),
                      ],
                    ),
                  ),

                  // จุดที่ 2: เพิ่มปุ่ม "กลับหน้าหลัก" ไว้ด้านล่างสุด
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // คำสั่งล้างหน้าจอและกลับหน้าแรกสุด
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green, width: 2),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'กลับหน้าหลัก',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget สำหรับสร้างเส้น Timeline
  Widget _buildTimelineItem(
    String title,
    String time, {
    required bool isDone,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            // จุดวงกลมสถานะ
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? Colors.green : Colors.grey.shade300,
                border: isDone
                    ? null
                    : Border.all(color: Colors.grey.shade400, width: 2),
              ),
              child: isDone
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            // เส้นเชื่อม (ถ้าไม่ใช่อันสุดท้าย)
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isDone ? Colors.green : Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
                  color: isDone ? Colors.black87 : Colors.grey,
                ),
              ),
              const SizedBox(height: 24), // เว้นระยะห่างให้แต่ละข้อ
            ],
          ),
        ),
        Text(
          time,
          style: TextStyle(
            color: isDone ? Colors.black87 : Colors.grey,
            fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
