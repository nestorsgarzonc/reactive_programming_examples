import 'package:equatable/equatable.dart';
import 'package:front_reactive_flutter/models/message_model.dart';
import 'package:front_reactive_flutter/models/user_model.dart';

class ChatState extends Equatable {
  final UserModel? userName;
  final List<MessageModel> messages;

  const ChatState({this.userName, this.messages = const []});

  @override
  List<Object?> get props => [userName, messages];

  ChatState copyWith({
    UserModel? userName,
    List<MessageModel>? messages,
  }) {
    return ChatState(
      userName: userName ?? this.userName,
      messages: messages ?? this.messages,
    );
  }
}
