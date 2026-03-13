import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'tracking_screen.dart';
import 'chat_screen.dart';

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
        primaryColor: const Color(0xFF00C853),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00C853)),
        fontFamily: 'Prompt',
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

  // รายการหน้าจอของแต่ละแท็บ
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AppointmentTab(),
    ChatTab(),
    HistoryTab(), // หน้าประวัติที่เติมข้อมูลแล้ว
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
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
        type: BottomNavigationBarType.fixed,
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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'การนัดหมายของคุณ',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'นัดหมายที่กำลังจะมาถึง',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.local_hospital,
                  color: Colors.teal,
                  size: 28,
                ),
              ),
              title: const Text(
                'พาไปพบแพทย์',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  '15 มี.ค. 2026 • 08:30 น.\nโรงพยาบาลธรรมศาสตร์เฉลิมพระเกียรติ',
                  style: TextStyle(height: 1.5),
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
              isThreeLine: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const TrackingScreen(caregiverName: 'ตั้น'),
                  ),
                );
              },
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'ข้อความ',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.green.shade100,
                  child: const Icon(
                    Icons.person,
                    color: Colors.green,
                    size: 30,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            title: const Text(
              'คุณ ตั้น (Caregiver)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: const Text(
              'พรุ่งนี้พบกัน 8 โมงเช้านะครับ',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '10:11 น.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(height: 4),
                Icon(
                  Icons.circle,
                  color: Colors.redAccent,
                  size: 12,
                ), // สัญลักษณ์ว่ายังไม่ได้อ่าน
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatScreen(caregiverName: 'ตั้น'),
                ),
              );
            },
          ),
          const Divider(height: 1, indent: 80),
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
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'ประวัติการใช้งาน',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // รายการประวัติที่ 1
          _buildHistoryCard(
            serviceName: 'ดูแลที่บ้าน',
            date: '10 ก.พ. 2026',
            location: 'ย่านคลองหนึ่ง ปทุมธานี',
            caregiver: 'มายด์',
            icon: Icons.home_filled,
            iconColor: Colors.green,
            statusText: 'เสร็จสิ้น',
            statusColor: Colors.green,
          ),
          const SizedBox(height: 12),

          // รายการประวัติที่ 2
          _buildHistoryCard(
            serviceName: 'พาไปพบแพทย์',
            date: '25 ม.ค. 2026',
            location: 'โรงพยาบาลธรรมศาสตร์เฉลิมพระเกียรติ',
            caregiver: 'ฝน',
            icon: Icons.local_hospital,
            iconColor: Colors.teal,
            statusText: 'เสร็จสิ้น',
            statusColor: Colors.green,
          ),
          const SizedBox(height: 12),

          // รายการประวัติที่ 3
          _buildHistoryCard(
            serviceName: 'พาเที่ยว',
            date: '5 ธ.ค. 2025',
            location: 'ฟิวเจอร์พาร์ค รังสิต',
            caregiver: 'บอส',
            icon: Icons.directions_car,
            iconColor: Colors.blue,
            statusText: 'ยกเลิก',
            statusColor: Colors.redAccent,
          ),
        ],
      ),
    );
  }

  // Widget ช่วยสร้างการ์ดประวัติเพื่อลดความซ้ำซ้อนของโค้ด
  Widget _buildHistoryCard({
    required String serviceName,
    required String date,
    required String location,
    required String caregiver,
    required IconData icon,
    required Color iconColor,
    required String statusText,
    required Color statusColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: iconColor, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      serviceName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1),
            ),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(date, style: const TextStyle(color: Colors.black87)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    location,
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Caregiver: คุณ $caregiver',
                  style: const TextStyle(color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
