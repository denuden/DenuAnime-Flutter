import 'package:flutter/material.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
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
                      label: Text("Welcome Back!"),
                      labelPadding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      labelStyle: TextStyle(fontWeight: FontWeight.w600),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 0.5,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        borderRadius: BorderRadiusGeometry.circular(24),
                      ),
                    ),

                    SizedBox(height: 16),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFFFD180),
                          Color(0xFFFFA726),
                          Color(0xFFFF8C00),
                        ],
                      ).createShader(bounds),
                      child: Text(
                        "YOUR ANIME COMPANION APP",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          height: 0.9,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // IMPORTANT
                        ),
                      ),
                    ),
                    SizedBox(height: 8),

                    Text(
                      "Track, discover, and save your favorite anime.\nFind your next obsession, one episode at a time.",
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 32),

                    TextButton(
                      onPressed: () {},
                      child: Text("Explore the app"),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 12,
                      children: [
                        SizedBox(
                          width: 80,
                          child: Divider(thickness: 0.5, color: Colors.white),
                        ),
                        Text("or"),
                        SizedBox(
                          width: 80,
                          child: Divider(thickness: 0.5, color: Colors.white),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text("Login"),
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {},
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
