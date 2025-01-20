import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/message_model.dart';

class ChatMessageBubble extends StatelessWidget {
  final Message message;

  const ChatMessageBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMe =
        message.senderId == 'currentUser'; // Replace with actual user ID check

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) SizedBox(width: 40),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isMe
                    ? kPrimaryColor.withValues(alpha: 0.2)
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat('HH:mm').format(message.timestamp),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                      if (isMe) SizedBox(width: 4),
                      if (isMe)
                        Icon(
                          Icons.done_all,
                          size: 16,
                          color: kPrimaryColor,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isMe) SizedBox(width: 40),
        ],
      ),
    );
  }
}
