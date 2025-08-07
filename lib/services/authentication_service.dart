import 'package:firebase_auth/firebase_auth.dart';
import 'package:location_based_attendance_app/requests/login_request.dart';
import 'package:location_based_attendance_app/requests/register_request.dart';

class AuthenticationService {
  AuthenticationService();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<String> registerWithEmail(RegisterRequest request) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      return userCredential.user!.uid;
    } catch (error) {
      rethrow;
    }
  }

  Future<String> loginWithEmail(LoginRequest request) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );

      return userCredential.user!.uid;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      rethrow;
    }
  }
}
