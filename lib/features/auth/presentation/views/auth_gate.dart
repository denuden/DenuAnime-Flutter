import 'package:denuanime/features/auth/domain/cubits/auth_cubit.dart';
import 'package:denuanime/features/auth/domain/cubits/auth_state.dart';
import 'package:denuanime/features/auth/presentation/views/landing_view.dart';
import 'package:denuanime/features/main/presentation/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      buildWhen: (previous, current) => previous.status != current.status,
      listenWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return switch (state.status) {
          AuthStatus.unknown => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          AuthStatus.authenticated => const HomeView(),
          AuthStatus.unauthenticated => const LandingView(),
        };
      },
      listener: (context, state) async {
        // Login or logout: close anything pushed on top (login page, settings…)
        // so the new root screen is what the user actually sees.
        Navigator.of(context).popUntil((route) {
          return route.isFirst;
        });
      },
    );
  }
}
