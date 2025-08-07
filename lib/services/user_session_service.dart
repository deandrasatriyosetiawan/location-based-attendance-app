import 'package:shared_preferences/shared_preferences.dart';

class UserSessionService {
  const UserSessionService();

  Future<void> save({required String userId}) async {
    try {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('user_id', userId);
    } catch (error) {
      rethrow;
    }
  }

  Future<String?> get() async {
    try {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences.getString('user_id');
    } catch (error) {
      rethrow;
    }
  }

  Future<void> clear() async {
    try {
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.clear();
    } catch (error) {
      rethrow;
    }
  }
}
