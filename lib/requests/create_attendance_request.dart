class CreateAttendanceRequest {
  const CreateAttendanceRequest({
    required this.userId,
    required this.status,
    required this.imagePath,
    required this.createdAt,
    required this.distanceFromOfficeInMeters,
  });

  final String userId, status, imagePath;
  final DateTime createdAt;
  final double distanceFromOfficeInMeters;

  List<Object> toSqliteArguments() => [userId, status, imagePath, createdAt.millisecondsSinceEpoch];
}
