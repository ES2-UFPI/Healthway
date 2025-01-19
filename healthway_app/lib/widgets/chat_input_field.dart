import 'package:healthway_app/constants.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatefulWidget {
  final Function(String) onSendMessage;

  const ChatInputField({super.key, required this.onSendMessage});

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  void _handleSubmitted(String text) {
    widget.onSendMessage(text);
    setState(() {
      _isComposing = false;
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.emoji_emotions_outlined, color: kPrimaryColor),
                onPressed: () {
                  // TODO: Implement emoji picker
                },
              ),
              Expanded(
                child: TextField(
                  controller: _textController,
                  onChanged: (text) {
                    setState(() {
                      _isComposing = text.isNotEmpty;
                    });
                  },
                  onSubmitted: _isComposing ? _handleSubmitted : null,
                  decoration: InputDecoration(
                    hintText: 'Digite uma mensagem...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
              IconButton(
                icon: Icon(Icons.attach_file, color: kPrimaryColor),
                onPressed: () {
                  // TODO: Implement file attachment
                },
              ),
              IconButton(
                icon: Icon(_isComposing ? Icons.send : Icons.mic,
                    color: kPrimaryColor),
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : () {
                        // TODO: Implement voice recording
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
