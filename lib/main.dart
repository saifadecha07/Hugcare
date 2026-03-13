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
