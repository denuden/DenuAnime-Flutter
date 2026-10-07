import 'package:denuanime/features/auth/data/request/register_request.dart';
import 'package:denuanime/features/auth/data/request/sign_in_request.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseDatasource {
  final FirebaseAuth auth;

  AuthFirebaseDatasource(this.auth);

  Stream<User?> authStateChanges() {
    return auth.userChanges();
  }

  Future<UserCredential?> signInWithEmail(SignInRequest request) {
    return auth.signInWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
  }

  Future<UserCredential?> registerWithEmail(RegisterRequest request) {
    return auth.createUserWithEmailAndPassword(
      email: request.email,
      password: request.password,
    );
  }

  Future<void> signOut() {
    return auth.signOut();
  }
}
