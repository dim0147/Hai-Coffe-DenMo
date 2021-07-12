import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

enum Role { Admin, Staff }

@JsonSerializable()
class UserModel {
  final int id;
  final String username;
  final String name;
  final String password;
  final Role role;

  UserModel(
      {required this.id,
      required this.username,
      required this.name,
      required this.password,
      required this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
