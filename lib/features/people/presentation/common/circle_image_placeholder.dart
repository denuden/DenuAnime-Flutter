import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class CircleImagePlaceholder extends StatelessWidget {
  final double radius;

  const CircleImagePlaceholder({super.key, this.radius = 24});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: const BoxDecoration(color: tertiary, shape: BoxShape.circle),
    );
  }
}
