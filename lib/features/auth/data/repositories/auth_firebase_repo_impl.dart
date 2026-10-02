import 'package:denuanime/features/auth/data/datasource/auth_firbase_datasource.dart';
import 'package:denuanime/features/auth/data/request/register_request.dart';
import 'package:denuanime/features/auth/data/request/sign_in_request.dart';
import 'package:denuanime/features/auth/domain/entities/app_user_model.dart';
import 'package:denuanime/features/auth/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseRepoImpl implements AuthRepo {
  final AuthFirbaseDatasource datasource;

  AuthFirebaseRepoImpl(this.datasource)

  @override
  Stream<AppUserModel?> authStateChanges() {
   return datasource.authStateChanges().map((user) {
      return user == null ? null : _toAppUser(user);
    });
  }

  @override
  Future<AppUserModel?> getCurrentUser() async {
    final currentUser = datasource.auth.currentUser;

    if(currentUser == null ){
      return null;
    } else {
        return AppUserModel(uid: currentUser.uid, name: currentUser.displayName, email: currentUser.email, photo: currentUser.photoURL, isEmailVerified: currentUser.emailVerified);
    }
  }

  @override
  Future<AppUserModel?> registerWithEmail(RegisterRequest request) {
    // TODO: implement registerWithEmail
    throw UnimplementedError();
  }

  @override
  Future<AppUserModel?> signInWithEmail(SignInRequest request) {
    // TODO: implement signInWithEmail
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }


    //? ============ helpers
  AppUserModel _toAppUser(User user) {
    return AppUserModel(
      uid: user.uid,
      email: user.email,
      name: user.displayName,
      photo: user.photoURL,
    );
  }
}


