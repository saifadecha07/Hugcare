import 'package:flutter/material.dart';

// โครงสร้างข้อมูลจำลองสำหรับข้อความแชท
class ChatMessage {
  final String text;
  final bool
  isMe; // true = เราพิมพ์ (อยู่ขวา), false = Caregiver พิมพ์ (อยู่ซ้าย)

  ChatMessage({required this.text, required this.isMe});
}

class ChatScreen extends StatefulWidget {
  final String caregiverName;

  const ChatScreen({super.key, required this.caregiverName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  // ข้อความจำลองตอนเปิดหน้าแชทมาครั้งแรก
  final List<ChatMessage> _messages = [
    ChatMessage(text: 'สวัสดีครับ 😊', isMe: false),
    ChatMessage(text: 'ขอบคุณที่เลือกใช้บริการผมนะครับ', isMe: false),
    ChatMessage(text: 'ต้องการให้ไปรับที่ไหนบอกได้เลย', isMe: false),
    ChatMessage(text: 'พรุ่งนี้พบกัน 8 โมงเช้านะครับ', isMe: false),
  ];

  // ฟังก์ชันส่งข้อความ
  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      // เพิ่มข้อความที่เราพิมพ์เข้าไปใน List
      _messages.add(ChatMessage(text: _messageController.text, isMe: true));
    });

    // ล้างช่องพิมพ์หลังจากส่งเสร็จ
    _messageController.clear();

    // ตรงนี้ในแอปจริงสามารถใส่ logic ให้บอทตอบกลับอัตโนมัติได้
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.green.shade100,
              child: const Icon(Icons.person, color: Colors.green, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              'คุณ ${widget.caregiverName}',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 1,
      ),
      body: Column(
        children: [
          // พื้นที่แสดงข้อความแชท
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // แถบพิมพ์ข้อความด้านล่าง
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'พิมพ์ข้อความ...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // ปุ่มกดส่ง
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF00C853),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // วิดเจ็ตสำหรับสร้างกล่องข้อความ (สีเขียวคือเราพิมพ์, สีขาวคือเขาพิมพ์)
  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isMe
              ? const Color(0xFFE8F5E9)
              : Colors.white, // สีเขียวอ่อนสำหรับเรา สีขาวสำหรับ Caregiver
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: message.isMe
                ? const Radius.circular(16)
                : const Radius.circular(0),
            bottomRight: message.isMe
                ? const Radius.circular(0)
                : const Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          message.text,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
