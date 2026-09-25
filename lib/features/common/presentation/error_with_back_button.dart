import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class ErrorWithBackButton extends StatelessWidget {
  final Widget child;

  const ErrorWithBackButton({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: BackButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  secondary.withValues(alpha: 0.5),
                ),
                iconColor: const WidgetStatePropertyAll(white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
