import 'package:denuanime/features/auth/domain/entities/app_user_model.dart';
import 'package:denuanime/utils/core/async_value.dart';
import 'package:flutter/foundation.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final AppUserModel? user;

  /// State of the last login/register/logout action, for the button and errors.
  /// `void` because the action has no data to show — the signed-in user
  /// arrives through the auth stream instead.
  /// Idle → normal, Loading → spinner, Failure → show message.
  final Async<void> submission;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.submission = const AsyncIdle(),
  });

  AuthState copyWith({
    AuthStatus? status,
    ValueGetter<AppUserModel?>? user,
    Async<void>? submission,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user != null ? user() : this.user,
      submission: submission ?? this.submission,
    );
  }
}
