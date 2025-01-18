import 'package:get/get.dart';
import '../models/message_model.dart';
import '../services/chat_services.dart';

class ChatController extends GetxController {
  final ChatService _chatService = ChatService();
  final RxList<Message> messages = <Message>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final loadedMessages = await _chatService.getMessages();
      messages.assignAll(loadedMessages);
    } catch (e) {
      print('Error loading messages: $e');
      // TODO: Handle error (e.g., show a snackbar)
    }
  }

  Future<void> sendMessage(String text) async {
    try {
      final newMessage = await _chatService.sendMessage(text);
      messages.insert(0, newMessage);
    } catch (e) {
      print('Error sending message: $e');
      // TODO: Handle error (e.g., show a snackbar)
    }
  }
}

