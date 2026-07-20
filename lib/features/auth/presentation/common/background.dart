import 'dart:ui';

import 'package:denuanime/features/auth/presentation/common/background_glow.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget content;

  const Background({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      //*main container
      borderRadius: BorderRadiusGeometry.circular(20),
      child: Stack(
        children: [
          // background
          Container(color: background),

          // top right glow
          const Positioned(
            top: -100,
            right: -20,
            child: BackgroundGlow(color: primaryGlow, size: 250),
          ),

          // bottom left glow
          const Positioned(
            bottom: -60,
            left: -60,
            child: BackgroundGlow(color: primaryDark, size: 220),
          ),

          const Positioned(
            top: 270,
            right: -90,
            child: BackgroundGlow(color: primarySoft, size: 180),
          ),

          // Slight vignette
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                radius: 1.3,
                colors: [Colors.transparent, Color(0xAA090909)],
              ),
            ),
          ),

          // Login Card
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                //*glassmorphism
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  //*card itself to hold content
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    //*border
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),

                      //*remove both for just plain glass

                      //* glass color
                      //*makes it bit whiter if you want glassy
                      color: Colors.white.withValues(alpha: .05),

                      //*makes it even darker
                      //* subtle gradient
                      // gradient: LinearGradient(
                      //   begin: Alignment.topLeft,
                      //   end: Alignment.bottomRight,
                      //   colors: [
                      //     Colors.white.withValues(alpha: .04),
                      //     Colors.white.withValues(alpha: .01),
                      //   ],
                      // ),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: .08),
                      ),
                    ),

                    //*===== content here
                    child: content,
                  ),
                ),
              ),
            ),
          ),

          // your card goes here
        ],
      ),
    );
  }
}
