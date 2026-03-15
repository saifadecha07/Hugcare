import 'package:flutter/material.dart';
import 'package:hugecare/add_patient_screen.dart';
import 'package:hugecare/appointment_detail_screen.dart';

class SelectPatientScreen extends StatelessWidget {
  final String serviceName;

  // รับชื่อบริการที่กดมาจากหน้า Home เพื่อมาแสดงบน AppBar
  const SelectPatientScreen({super.key, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          serviceName,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'กรุณาเลือกผู้รับบริการ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // ปุ่มเพิ่มผู้รับบริการใหม่
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // สร้างฟอร์มกรอกข้อมูล (ชื่อ, อายุ, อาการ)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPatientScreen(),
                    ),
                  );
                  print('ไปหน้าฟอร์มเพิ่มข้อมูลใหม่');
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'เพิ่มผู้รับบริการใหม่',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C853), // สีเขียวหลัก
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // รายชื่อผู้รับบริการที่เคยบันทึกไว้
            Card(
              elevation: 0,
              color: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.purple.shade200,
                  radius: 24,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                title: const Text(
                  'คุณ สมภพ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: const Text('เพศ: ชาย   อายุ: 67'),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
                onTap: () {
                  // ไปหน้ากำหนดวัน เวลา และสถานที่นัดหมาย
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AppointmentDetailScreen(
                        patientName: 'คุณ สมภพ',
                      ),
                    ),
                  );
                  print('เลือก คุณ สมภพ');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
