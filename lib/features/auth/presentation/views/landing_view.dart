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
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => LoginView()));
  }

  void navigateToRegister() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => RegisterView()));
  }

  void navigateToHome() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => HomeView()));
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
                    SizedBox(height: 16),

                    Chip(
                      avatar: Icon(
                        Icons.waving_hand_rounded,
                        color: primaryLight,
                        size: 18,
                      ),
                      labelStyle: TextStyle(
                        color: primaryLight,
                        fontWeight: FontWeight.w600,
                      ),
                      backgroundColor: glass,
                      label: Text("Welcome Back!"),
                      labelPadding: EdgeInsets.symmetric(
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

                    SizedBox(height: 24),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [primaryLight, primary, primaryDeep],
                      ).createShader(bounds),
                      child: Text(
                        "YOUR ANIME COMPANION APP",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          height: 0.9,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: inversePrimary, // IMPORTANT
                        ),
                      ),
                    ),
                    SizedBox(height: 8),

                    Text(
                      "Track, discover, and save your favorite anime.\nFind your next obsession, one episode at a time.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    SizedBox(height: 32),

                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: primaryLight,
                      ),
                      onPressed: () {
                        navigateToHome();
                      },
                      child: Text("Explore the app"),
                    ),

                    Row(
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

                    SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: primaryBorder),
                        ),
                        onPressed: () {
                          navigateToLogin();
                        },
                        child: Text("Login"),
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          navigateToRegister();
                        },
                        child: Text("Register"),
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
