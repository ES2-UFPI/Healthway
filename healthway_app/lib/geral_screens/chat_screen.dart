import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/chat_message_bubble.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF31BAC2),
              child: Icon(Icons.person, color: Colors.white),
              radius: 20,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nutricionista',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                Text('Online',
                    style: TextStyle(fontSize: 12, color: Colors.white70)),
              ],
            ),
          ],
        ),
        backgroundColor: Color(0xFF31BAC2),
        actions: [
          IconButton(icon: Icon(Icons.video_call), onPressed: () {}),
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  reverse: true,
                  itemCount: chatController.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatController.messages[index];
                    return ChatMessageBubble(message: message);
                  },
                );
              }),
            ),
            ChatInputField(
              onSendMessage: (String text) {
                chatController.sendMessage(text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
