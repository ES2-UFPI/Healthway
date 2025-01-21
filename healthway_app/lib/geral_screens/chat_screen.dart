import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/chat_message_bubble.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      foregroundColor: Colors.white,
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: kPrimaryColor,
            radius: 20,
            child: Icon(Icons.person, color: Colors.white),
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
      backgroundColor: kPrimaryColor,
      actions: _buildAppBarActions(),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(icon: Icon(Icons.video_call), onPressed: () {}),
      IconButton(icon: Icon(Icons.call), onPressed: () {}),
      IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
    ];
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          _buildMessagesList(),
          ChatInputField(
            onSendMessage: (String text) {
              chatController.sendMessage(text);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return Expanded(
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
    );
  }
}
