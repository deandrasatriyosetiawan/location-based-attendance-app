import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_based_attendance_app/models/user_model.dart';
import 'package:location_based_attendance_app/requests/create_user_request.dart';

class UserService {
  UserService();

  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> createUser(CreateUserRequest request) async {
    try {
      _usersCollection.doc(request.userId).set(request.toJson());
    } catch (error) {
      rethrow;
    }
  }

  Future<UserModel> fetchUser({required String id}) async {
    try {
      final DocumentSnapshot documentSnapshot = await _usersCollection.doc(id).get();

      return UserModel.fromJson(id, documentSnapshot.data() as Map<String, dynamic>);
    } catch (error) {
      rethrow;
    }
  }
}
