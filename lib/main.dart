import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const HugCareApp());
}

class HugCareApp extends StatelessWidget {
  const HugCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HUGCARE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF00C853), // สีเขียวหลักอ้างอิงจากแอป
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00C853)),
        fontFamily:
            'Prompt', // แนะนำให้ใช้ฟอนต์ Prompt เพื่อให้ดูทันสมัยเหมือนในคลิป
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // TODO: เตรียมแยกไฟล์หน้าจอสำหรับแต่ละเมนู
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Center(
      child: Text('หน้าหลัก (เลือกบริการ)', style: TextStyle(fontSize: 20)),
    ),
    Center(child: Text('นัดหมาย', style: TextStyle(fontSize: 20))),
    Center(child: Text('ข้อความ', style: TextStyle(fontSize: 20))),
    Center(child: Text('ประวัติ', style: TextStyle(fontSize: 20))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'นัดหมาย',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'ข้อความ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'ประวัติ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // ป้องกันไอคอนขยับเมื่อมีหลายเมนู
      ),
    );
  }
}
// ----------------- โค้ดสำหรับแท็บทั้ง 3 -----------------

// 1. หน้าต่างการนัดหมาย (Appointment Tab)
class AppointmentTab extends StatelessWidget {
  const AppointmentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'การนัดหมายของคุณ',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.local_hospital, color: Colors.teal),
              ),
              title: const Text(
                'พาไปพบแพทย์',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                '15 ก.พ. 2026 • 08:30 น.\nโรงพยาบาลธรรมศาสตร์เฉลิมพระเกียรติ',
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              isThreeLine: true,
            ),
          ),
        ],
      ),
    );
  }
}

// 2. หน้าต่างข้อความ (Chat Tab)
class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อความ', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green.shade100,
              child: const Icon(Icons.person, color: Colors.green),
            ),
            title: const Text(
              'คุณ ตั้น (Caregiver)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('พรุ่งนี้พบกัน 8 โมงเช้านะครับ'),
            trailing: const Text(
              '10:11 น.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

// 3. หน้าต่างประวัติการใช้งาน (History Tab)
class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ประวัติการใช้งาน',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.grey.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.grey),
              title: const Text(
                'ดูแลที่บ้าน (เสร็จสิ้น)',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text('10 ม.ค. 2026 • Caregiver: มายด์'),
            ),
          ),
        ],
      ),
    );
  }
}
