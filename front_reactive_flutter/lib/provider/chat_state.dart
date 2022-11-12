import 'package:equatable/equatable.dart';

class ChatState extends Equatable {
  final String? userName;

  const ChatState({this.userName});

  @override
  List<Object?> get props => [userName];

  ChatState copyWith({
    String? userName,
  }) {
    return ChatState(
      userName: userName ?? this.userName,
    );
  }
}
