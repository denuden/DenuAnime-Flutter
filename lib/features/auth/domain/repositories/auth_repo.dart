import 'package:denuanime/features/auth/data/request/register_request.dart';
import 'package:denuanime/features/auth/data/request/sign_in_request.dart';
import 'package:denuanime/features/auth/domain/entities/app_user_model.dart';

abstract class AuthRepo {
  /// Emits the signed-in user, or null when signed out.
  /// Fires on app start too, since Firebase restores the session itself.
  Stream<AppUserModel?> authStateChanges();

  Future<AppUserModel?> signInWithEmail(SignInRequest request);
  Future<AppUserModel?> registerWithEmail(RegisterRequest request);
  Future<void> signOut();
  Future<AppUserModel?> getCurrentUser();
}
