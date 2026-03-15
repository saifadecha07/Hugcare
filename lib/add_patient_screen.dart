import 'package:flutter/material.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  // ตัวแปรเก็บค่าจากฟอร์ม
  double _healthScore = 80.0; // ค่าเริ่มต้นของแถบเลื่อนสุขภาพ
  String _gender = 'ชาย'; // ค่าเริ่มต้นของเพศ

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'เพิ่มผู้รับบริการ',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        // ใช้ SingleChildScrollView ป้องกันคีย์บอร์ดบังหน้าจอ
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // อัปโหลดรูปโปรไฟล์
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.green.shade100,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ช่องกรอกข้อมูล
            _buildTextField(Icons.person_outline, 'ชื่อ-นามสกุล'),
            const SizedBox(height: 16),
            _buildTextField(Icons.cake_outlined, 'อายุ', isNumber: true),
            const SizedBox(height: 16),
            _buildTextField(Icons.phone_android, 'เบอร์ติดต่อ', isNumber: true),
            const SizedBox(height: 16),

            // เลือกเพศ
            Row(
              children: [
                const Icon(Icons.wc, color: Colors.grey),
                const SizedBox(width: 16),
                const Text('เพศ:', style: TextStyle(fontSize: 16)),
                Radio<String>(
                  value: 'ชาย',
                  groupValue: _gender,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() => _gender = value!);
                  },
                ),
                const Text('ชาย'),
                Radio<String>(
                  value: 'หญิง',
                  groupValue: _gender,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() => _gender = value!);
                  },
                ),
                const Text('หญิง'),
              ],
            ),
            const SizedBox(height: 16),

            // แถบเลื่อนประเมินสุขภาพ
            const Row(
              children: [
                Icon(Icons.monitor_heart_outlined, color: Colors.grey),
                SizedBox(width: 16),
                Text('สุขภาพโดยรวม:', style: TextStyle(fontSize: 16)),
              ],
            ),
            Slider(
              value: _healthScore,
              min: 0,
              max: 100,
              divisions: 10,
              activeColor: Colors.green,
              label: '${_healthScore.round()}%',
              onChanged: (double value) {
                setState(() {
                  _healthScore = value;
                });
              },
            ),
            Center(
              child: Text(
                'สุขภาพ ${_healthScore.round()}%',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),

            _buildTextField(
              Icons.home_outlined,
              'ที่อยู่ / รายละเอียดเพิ่มเติม',
              maxLines: 3,
            ),
            const SizedBox(height: 32),

            // ปุ่มบันทึก
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // บันทึกข้อมูลแล้วกลับไปหน้าก่อนหน้า
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C853),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'บันทึก',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันสร้างช่องกรอกข้อความ
  Widget _buildTextField(
    IconData icon,
    String label, {
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.grey),
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}
