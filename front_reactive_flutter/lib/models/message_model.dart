import 'dart:convert';

import 'package:equatable/equatable.dart';

class MessageModel extends Equatable {
  final String message;
  final String userName;
  final String userId;
  final DateTime sendAt;
  final bool isMine;

  const MessageModel({
    required this.message,
    required this.userName,
    required this.userId,
    required this.sendAt,
    this.isMine = true,
  });

  MessageModel copyWith({
    String? message,
    String? userName,
    String? userId,
    DateTime? sendAt,
    bool? isMine,
  }) {
    return MessageModel(
      message: message ?? this.message,
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
      sendAt: sendAt ?? this.sendAt,
      isMine: isMine ?? this.isMine,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'userName': userName,
      'userId': userId,
      'sendAt': sendAt.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      message: map['message'] ?? '',
      userName: map['userName'] ?? '',
      userId: map['userId'] ?? '',
      sendAt: DateTime.fromMillisecondsSinceEpoch(map['sendAt']),
      isMine: map['isMine'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessageModel(message: $message, userName: $userName, userId: $userId, sendAt: $sendAt)';
  }

  @override
  List<Object> get props {
    return [
      message,
      userName,
      userId,
      sendAt,
      isMine,
    ];
  }
}
