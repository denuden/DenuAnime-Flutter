import 'dart:ui';

import 'package:denuanime/features/auth/presentation/common/background_glow.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget content;
  final Widget? header;

  const Background({super.key, required this.content, this.header});

  @override
  Widget build(BuildContext context) {
    final header = this.header;

    return Stack(
      children: [
        // background — now fills the whole screen
        const Positioned.fill(child: ColoredBox(color: background)),

        // top right glow
        const Positioned(
          top: 120,
          right: -80,
          child: BackgroundGlow(color: primaryGlow, size: 250),
        ),

        // middle right glow
        const Positioned(
          top: 420,
          right: -100,
          child: BackgroundGlow(color: primarySoft, size: 180),
        ),

        // bottom left glow
        const Positioned(
          bottom: 60,
          left: -100,
          child: BackgroundGlow(color: primaryDark, size: 220),
        ),

        // Slight vignette
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                radius: 1.3,
                colors: [Colors.transparent, Color(0xAA090909)],
              ),
            ),
          ),
        ),

        //* page content — whole page scrolls, so the keyboard never squashes the card
        SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (header != null) ...[header, const SizedBox(height: 24)],

                  // Login Card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    //*glassmorphism
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      //*card itself to hold content — sizes to its content now
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        //*border
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          //* glass color
                          color: Colors.white.withValues(alpha: .05),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: .08),
                          ),
                        ),

                        //*===== content here
                        child: content,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
