import 'package:denuanime/features/auth/presentation/views/login_view.dart';
import 'package:denuanime/features/auth/presentation/views/register_view.dart';
import 'package:denuanime/features/main/presentation/home_view.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  //* ============= functions
  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute<LoginView>(builder: (context) => const LoginView()),
    );
  }

  void navigateToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute<RegisterView>(
        builder: (context) => const RegisterView(),
      ),
    );
  }

  void navigateToHome() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<HomeView>(builder: (context) => const HomeView()));
  }

  //* ================== UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/full.png", height: 224),
                    const SizedBox(height: 16),

                    Chip(
                      avatar: const Icon(
                        Icons.waving_hand_rounded,
                        color: primaryLight,
                        size: 18,
                      ),
                      labelStyle: const TextStyle(
                        color: primaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: glass,
                      label: const Text("Welcome Back!"),
                      labelPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0.8,
                          color: primaryBorder,
                        ),
                        borderRadius: BorderRadiusGeometry.circular(24),
                      ),
                    ),

                    const SizedBox(height: 24),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [primaryLight, primary, primaryDeep],
                      ).createShader(bounds),
                      child: const Text(
                        "YOUR ANIME COMPANION APP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 0.9,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: inversePrimary, // IMPORTANT
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      "Track, discover, and save your favorite anime.\nFind your next obsession, one episode at a time.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 32),

                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: primaryLight,
                      ),
                      onPressed: () {
                        navigateToHome();
                      },
                      child: const Text("Explore the app"),
                    ),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 12,
                      children: [
                        SizedBox(
                          width: 80,
                          child: Divider(thickness: 0.5, color: divider),
                        ),
                        Text(
                          "or",
                          style: TextStyle(
                            color: textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Divider(thickness: 0.5, color: divider),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: primaryBorder),
                        ),
                        onPressed: () {
                          navigateToLogin();
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          navigateToRegister();
                        },
                        child: const Text("Register"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
