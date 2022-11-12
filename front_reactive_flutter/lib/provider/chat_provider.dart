import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_reactive_flutter/provider/chat_state.dart';

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier();
});

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(const ChatState());

  void connectToChat(String userName) {
    state = state.copyWith(userName: userName);
  }
}
