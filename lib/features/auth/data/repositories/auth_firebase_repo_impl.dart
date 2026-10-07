import 'package:denuanime/features/auth/data/datasource/auth_firbase_datasource.dart';
import 'package:denuanime/features/auth/data/request/register_request.dart';
import 'package:denuanime/features/auth/data/request/sign_in_request.dart';
import 'package:denuanime/features/auth/domain/entities/app_user_model.dart';
import 'package:denuanime/features/auth/domain/entities/auth_failure.dart';
import 'package:denuanime/features/auth/domain/repositories/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthFirebaseRepoImpl implements AuthRepo {
  final AuthFirebaseDatasource datasource;

  AuthFirebaseRepoImpl(this.datasource);

  @override
  Stream<AppUserModel?> authStateChanges() {
    return datasource.authStateChanges().map((user) {
      return user == null ? null : _toAppUser(user);
    });
  }

  @override
  Future<AppUserModel?> getCurrentUser() async {
    final currentUser = datasource.auth.currentUser;

    if (currentUser == null) {
      return null;
    } else {
      return AppUserModel(
        uid: currentUser.uid,
        name: currentUser.displayName,
        email: currentUser.email,
        photo: currentUser.photoURL,
        isEmailVerified: currentUser.emailVerified,
      );
    }
  }

  @override
  Future<AppUserModel?> registerWithEmail(RegisterRequest request) async {
    try {
      final credential = await datasource.registerWithEmail(
        request.copyWith(email: request.email.trim()),
      );

      final user = credential?.user;
      if (user == null) {
        throw const AuthFailure(
          "Something went wrong with user being null. Please try again",
        );
      }

      //update user's display name
      try {
        await user.updateDisplayName(request.name);
      } catch (e) {
        throw AuthFailure(e.toString());
      }

      return _toAppUser(user);
    } on FirebaseAuthException catch (e) {
      _log(e);
      throw AuthFailure(e.message ?? "User cannot be registered", code: e.code);
    } on AuthFailure {
      rethrow;
    } catch (e) {
      throw AuthFailure("Registration Failed: $e");
    }
  }

  @override
  Future<AppUserModel?> signInWithEmail(SignInRequest request) async {
    try {
      final credential = await datasource.signInWithEmail(
        request.copyWith(email: request.email.trim()),
      );

      final user = credential?.user;
      if (user == null) {
        throw const AuthFailure(
          "Something went wrong with user being null. Please try again",
        );
      }

      return _toAppUser(user);
    } on FirebaseAuthException catch (e) {
      _log(e);
      throw AuthFailure(e.message ?? "Invalid credentials", code: e.code);
    } on AuthFailure {
      rethrow;
    } catch (e) {
      throw AuthFailure("Authentication Failed: $e");
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await datasource.signOut();
    } catch (e) {
      throw const AuthFailure("Couldn't sign out. Please try again.");
    }
  }

  //? ============ helpers
  AppUserModel _toAppUser(User user) {
    return AppUserModel(
      uid: user.uid,
      email: user.email,
      name: user.displayName,
      photo: user.photoURL,
      isEmailVerified: user.emailVerified,
    );
  }

  void _log(FirebaseAuthException e) {
    if (kDebugMode) {
      debugPrint('FirebaseAuthException: ${e.code} — ${e.message}');
    }
  }
}
