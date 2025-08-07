import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromJson(String id, Map<String, dynamic> json) {
    return UserModel(id: id, name: json['name'], email: json['email']);
  }

  final String id, name, email;

  @override
  List<Object?> get props => [id, name, email];
}
