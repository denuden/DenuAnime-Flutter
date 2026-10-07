import 'dart:async';

import 'package:denuanime/features/auth/data/request/register_request.dart';
import 'package:denuanime/features/auth/data/request/sign_in_request.dart';
import 'package:denuanime/features/auth/domain/cubits/auth_state.dart';
import 'package:denuanime/features/auth/domain/entities/app_user_model.dart';
import 'package:denuanime/features/auth/domain/entities/auth_failure.dart';
import 'package:denuanime/features/auth/domain/repositories/auth_repo.dart';
import 'package:denuanime/utils/core/async_value.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  StreamSubscription<AppUserModel?>? _authSubscription;

  AuthCubit({required this.authRepo}) : super(const AuthState()) {
    _authSubscription = authRepo.authStateChanges().listen((user) {
      emit(
        state.copyWith(
          status: user == null
              ? AuthStatus.unauthenticated
              : AuthStatus.authenticated,
          user: () => user,
        ),
      );
    });
  }

  Future<void> signInWithEmail(SignInRequest request) async {
    if (state.submission is AsyncLoading) return;

    emit(state.copyWith(submission: const AsyncLoading()));

    try {
      await authRepo.signInWithEmail(request);
      if (isClosed) return;

      // No need to set the user here — the stream fires and updates status.
      emit(state.copyWith(submission: const AsyncIdle()));
    } on AuthFailure catch (e) {
      if (isClosed) return;
      emit(state.copyWith(submission: AsyncFailure(e.message)));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          submission: AsyncFailure(
            "Something went wrong. Please try again. ${e.toString()}",
          ),
        ),
      );
    }
  }

  Future<void> registerWithEmail(RegisterRequest request) async {
    if (state.submission is AsyncLoading) return;

    emit(state.copyWith(submission: const AsyncLoading()));

    try {
      await authRepo.registerWithEmail(request);
      if (isClosed) return;

      // No need to set the user here — the stream fires and updates status.
      emit(state.copyWith(submission: const AsyncIdle()));
    } on AuthFailure catch (e) {
      if (isClosed) return;
      emit(state.copyWith(submission: AsyncFailure(e.message)));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          submission: AsyncFailure(
            "Something went wrong. Please try again. ${e.toString()}",
          ),
        ),
      );
    }
  }

  Future<void> signOut() async {
    if (state.submission is AsyncLoading) return;
    emit(state.copyWith(submission: const AsyncLoading()));
    try {
      await authRepo.signOut();
      emit(state.copyWith(submission: const AsyncIdle()));
    } on AuthFailure catch (e) {
      if (isClosed) return;
      emit(state.copyWith(submission: AsyncFailure(e.message)));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
