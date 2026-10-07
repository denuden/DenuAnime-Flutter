import 'package:flutter/material.dart';

/// Shows a blocking loading dialog.
/// Keep the returned route and pass it to [hideLoadingDialog].
Route<void> showLoadingDialog(
  BuildContext context, {
  String message = 'Loading...',
}) {
  final navigator = Navigator.of(context, rootNavigator: true);

  final route = DialogRoute<void>(
    context: context,
    barrierDismissible: false, // Prevents closing by tapping outside
    themes: InheritedTheme.capture(from: context, to: navigator.context),
    builder: (context) {
      return PopScope(
        canPop: false, // Prevents closing via system back gesture
        child: AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 20),
              Flexible(child: Text(message)),
            ],
          ),
        ),
      );
    },
  );

  navigator.push(route);
  return route;
}

/// Closes exactly this dialog — never the page underneath.
/// Safe to call twice, or after the dialog is already gone.
void hideLoadingDialog(Route<void> route) {
  if (route.isActive) {
    route.navigator?.removeRoute(route);
  }
}
