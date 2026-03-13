# HUGCARE 💙 - Caregiver Booking Application

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![UI/UX](https://img.shields.io/badge/UI%2FUX-Prototype-success?style=for-the-badge)

**HUGCARE (Care with Heart)** คือแอปพลิเคชันต้นแบบ (Prototype) สำหรับการจองและคัดเลือกผู้ดูแล (Caregiver) เพื่อดูแลผู้สูงอายุหรือผู้ป่วย

---

## ✨ Features (จุดเด่นของแอปพลิเคชัน)

- **Comprehensive Services:** รองรับบริการหลากหลายรูปแบบ เช่น ดูแลที่บ้าน, พาไปพบแพทย์, ดูแลส่วนตัว, และพาเที่ยว
- **Patient Profile Management:** ระบบจัดการประวัติผู้รับบริการ (ญาติผู้ใหญ่) พร้อมแบบประเมินสุขภาพเบื้องต้น
- **Smart Booking System:** ระบบนัดหมายที่สามารถระบุวันที่ เวลา และสถานที่ได้อย่างแม่นยำ
- **Swipe-to-Match Caregiver:** นวัตกรรมการคัดเลือกผู้ดูแลสไตล์แอปหาคู่ (Tinder-style swipe) ปัดขวาเพื่อเลือก ปัดซ้ายเพื่อข้าม พร้อมแสดงเรตติ้งและราคาชัดเจน
- **Real-time Tracking:** หน้าจอติดตามสถานะการทำงานของผู้ดูแลแบบ Timeline (เช่น กำลังเดินทาง, ถึงที่หมาย)
- **In-App Chat:** ระบบส่งข้อความสนทนา (Chat Room) ระหว่างผู้รับบริการและผู้ดูแลโดยตรง

---

## 📱 Screen Flows & UI Architecture

สถาปัตยกรรม UI ของแอปพลิเคชันถูกออกแบบมาในรูปแบบ **Component-based** เพื่อให้ง่ายต่อการขยายผลและบำรุงรักษา:

1. `home_screen.dart` - หน้าหลักแสดงบริการต่างๆ และแบนเนอร์
2. `select_patient_screen.dart` & `add_patient_screen.dart` - ระบบเลือกและสร้างโปรไฟล์ผู้รับบริการ
3. `appointment_detail_screen.dart` - ฟอร์มระบุวัน เวลา และสถานที่
4. `caregiver_swipe_screen.dart` - ระบบคัดเลือกผู้ดูแล (Card Swiping Mechanism)
5. `tracking_screen.dart` - หน้าจอแสดงสถานะ
6. `chat_screen.dart` - ระบบเเชท

---

## 🚀 Getting Started (วิธีการรันโปรเจกต์)

**Prerequisites:**
- ติดตั้ง [Flutter SDK](https://docs.flutter.dev/get-started/install) (เวอร์ชันล่าสุด)
- โปรแกรม Emulator (Android/iOS) หรืออุปกรณ์จริง

**Steps:**
1. Clone repository นี้ (หรือเปิดโฟลเดอร์โปรเจกต์)
2. เปิด Terminal แล้วรันคำสั่งเพื่อดึง Dependencies:
   ```bash
   flutter pub get
