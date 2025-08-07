import 'package:location_based_attendance_app/requests/create_attendance_request.dart';
import 'package:location_based_attendance_app/shared/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class AttendanceService {
  const AttendanceService({required DatabaseHelper databaseHelper}) : _databaseHelper = databaseHelper;

  final DatabaseHelper _databaseHelper;

  Future<int> insert(CreateAttendanceRequest request) async {
    try {
      final Database database = await _databaseHelper.database;

      return await database.rawInsert('''
        INSERT INTO ${_databaseHelper.attendanceTableName}
          (user_id, status, image_path, created_at) VALUES (?, ?, ?, ?);
        ''', request.toSqliteArguments());
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Map<String, Object?>>> fetchAllByUserId({required String userId}) async {
    try {
      final Database database = await _databaseHelper.database;

      final List<Map<String, Object?>> attendances = await database.query(
        _databaseHelper.attendanceTableName,
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'id DESC',
      );

      return attendances;
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, Object?>> fetchLatestByUserId({required String userId}) async {
    try {
      final Database database = await _databaseHelper.database;

      final List<Map<String, Object?>> attendances = await database.query(
        _databaseHelper.attendanceTableName,
        where: 'user_id = ?',
        whereArgs: [userId],
        orderBy: 'id DESC',
        limit: 1,
      );

      return attendances.isEmpty ? {} : attendances.first;
    } catch (error) {
      rethrow;
    }
  }
}
