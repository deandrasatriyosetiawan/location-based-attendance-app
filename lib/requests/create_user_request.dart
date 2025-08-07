class CreateUserRequest {
  const CreateUserRequest({required this.userId, required this.name, required this.email});

  final String userId, name, email;

  Map<String, dynamic> toJson() => {'name': name, 'email': email};
}
