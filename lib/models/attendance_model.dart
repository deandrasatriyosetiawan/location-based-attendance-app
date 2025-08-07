import 'package:equatable/equatable.dart';
import 'package:location_based_attendance_app/shared/extensions/date_extension.dart';

class AttendanceModel extends Equatable {
  const AttendanceModel({this.id, this.userId, this.status, this.imagePath, this.createdAt});

  factory AttendanceModel.fromSqliteDatabase(Map<String, dynamic> map) {
    final int? millisecondsSinceEpoch = map['created_at'];

    return AttendanceModel(
      id: map['id'],
      userId: map['user_id'],
      status: map['status'],
      imagePath: map['image_path'],
      createdAt: millisecondsSinceEpoch == null ? null : DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch),
    );
  }

  final int? id;
  final String? userId, status, imagePath;
  final DateTime? createdAt;

  bool get isPresentToday => createdAt?.dateOnly == DateTime.now().dateOnly;

  @override
  List<Object?> get props => [id, userId, status, imagePath, createdAt];
}
