// ignore_for_file: avoid_print
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_reactive_flutter/main.dart';
import 'package:front_reactive_flutter/models/message_model.dart';
import 'package:front_reactive_flutter/models/user_model.dart';
import 'package:front_reactive_flutter/provider/chat_state.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:uuid/uuid.dart';

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier();
});

class ChatNotifier extends StateNotifier<ChatState> {
  ChatNotifier() : super(const ChatState()) {
    _initSocket();
    _handleSocketListening();
  }

  final _messagesStream = StreamController<dynamic>();
  final _usersStream = StreamController<dynamic>();
  final scrollController = ScrollController();
  late io.Socket socket;
  static const _uuid = Uuid();

  void _handleSocketListening() {
    _messagesStream.stream
        .map((e) => MessageModel.fromMap(e))
        .map((e) => e.copyWith(isMine: e.userId == state.userName?.uuid))
        .listen(_onMessageRecived);
    _usersStream.stream
        .map((e) => UserModel.fromMap(e))
        .where((e) => e.uuid != state.userName?.uuid)
        .listen(_onUserJoined);
  }

  void _onMessageRecived(MessageModel message) {
    state = state.copyWith(messages: [...state.messages, message]);
    Future.delayed(const Duration(milliseconds: 300), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _onUserJoined(UserModel user) {
    ScaffoldMessenger.of(navKey.currentState!.context).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green[700],
        content: Text(
          '${user.name} se ha unido al chat.',
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _initSocket() {
    socket = io.io(
      'https://backend-q445.onrender.com',
      io.OptionBuilder().setTransports(['websocket']).build(),
    );
    socket.onConnect((_) => print('connect'));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('chat:message', _messagesStream.add);
    socket.on('chat:userJoined', _usersStream.add);
  }

  void connectToChat(String userName) {
    final user = UserModel(name: userName, uuid: _uuid.v4());
    state = state.copyWith(
      userName: user,
    );
    socket.emit('chat:join', user.toMap());
  }

  void sendMessage(String message) {
    final messageModel = MessageModel(
      message: message,
      userName: state.userName!.name,
      userId: state.userName!.uuid,
      sendAt: DateTime.now(),
    );
    socket.emit('chat:message', messageModel.toMap());
  }
}
