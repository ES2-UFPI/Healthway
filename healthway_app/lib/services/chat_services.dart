import '../models/message_model.dart';
import 'package:uuid/uuid.dart';

class ChatService {
  final List<Message> _messages = [];
  final _uuid = Uuid();

  Future<List<Message>> getMessages() async {
    // Simulating API call delay
    await Future.delayed(Duration(seconds: 1));
    return _messages;
  }

  Future<Message> sendMessage(String text) async {
    // Simulating API call delay
    await Future.delayed(Duration(milliseconds: 500));

    final newMessage = Message(
      id: _uuid.v4(),
      senderId: 'currentUser', // Replace with actual user ID
      senderName: 'You', // Replace with actual user name
      text: text,
      timestamp: DateTime.now(),
    );

    _messages.insert(0, newMessage);
    return newMessage;
  }
}

