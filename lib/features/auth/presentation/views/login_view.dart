import 'package:denuanime/features/auth/presentation/common/auth_textfield.dart';
import 'package:denuanime/features/auth/presentation/common/background.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //? variable ============
  bool obscureText = true;
  late TextEditingController _email;
  late TextEditingController _password;
  IconData passwordIcon = Icons.password;

  //? functions ==============
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    passwordListener();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void passwordListener() {
    _password.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* main layout
            Image.asset("assets/full.png", height: 140),
            const SizedBox(height: 16),

            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Background(
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //*Contents of background card
                        const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Manage your favorite animes",
                          style: TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 24),

                        AuthTextfield(
                          controller: _email,
                          hint: "Email",
                          isPassword: false,
                          suffixIcon: const Icon(Icons.email),
                          type: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 16),

                        AuthTextfield(
                          controller: _password,
                          hint: "Password",
                          isPassword: obscureText,
                          suffixIcon: IconButton(
                            icon: Icon(() {
                              if (_password.text.isEmpty) {
                                return Icons.password;
                              }

                              if (obscureText) {
                                return Icons.visibility;
                              }

                              return Icons.visibility_off;
                            }()),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                          type: TextInputType.visiblePassword,
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text(
                              "Sign In",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .6),
                          ),
                        ),

                        //*======= social login
                        const SizedBox(height: 24),
                        const SizedBox(
                          width: 50,
                          child: Divider(height: 0.5, thickness: 0.2),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsetsGeometry.all(8),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/ic_facebook.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsetsGeometry.all(8),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/icons/ic_google.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
