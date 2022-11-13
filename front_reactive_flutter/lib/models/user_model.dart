import 'dart:convert';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String uuid;

  const UserModel({
    required this.name,
    required this.uuid,
  });

  UserModel copyWith({
    String? name,
    String? uuid,
  }) {
    return UserModel(
      name: name ?? this.name,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uuid': uuid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uuid: map['uuid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(name: $name, uuid: $uuid)';

  @override
  List<Object> get props => [name, uuid];
}
