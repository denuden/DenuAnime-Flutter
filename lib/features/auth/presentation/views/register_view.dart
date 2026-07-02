import 'package:denuanime/features/auth/presentation/common/auth_textfield.dart';
import 'package:denuanime/features/auth/presentation/common/background.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //? variable ============
  bool obscureText = true;
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _name;
  IconData passwordIcon = Icons.password;

  //? functions ==============
  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();

    passwordListener();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _name.dispose();
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
            SizedBox(height: 16),

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
                          "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Manage your favorite animes",
                          style: TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 24),

                        AuthTextfield(
                          controller: _name,
                          hint: "Nickname",
                          isPassword: false,
                          suffixIcon: Icon(Icons.person),
                          type: TextInputType.text,
                        ),

                        const SizedBox(height: 16),

                        AuthTextfield(
                          controller: _email,
                          hint: "Email",
                          isPassword: false,
                          suffixIcon: Icon(Icons.email),
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
                              "Sign Up",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Text(
                          "or sign up with",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .6),
                          ),
                        ),

                        //*======= social login
                        SizedBox(height: 24),
                        SizedBox(
                          width: 50,
                          child: Divider(height: 0.5, thickness: 0.2),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 64,
                              height: 64,
                              child: Card(
                                child: Padding(
                                  padding: EdgeInsetsGeometry.all(8),
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
                                  padding: EdgeInsetsGeometry.all(8),
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
