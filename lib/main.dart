import 'package:denuanime/features/auth/presentation/views/landing_view.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: darkMode, home: LandingView());
  }
}
