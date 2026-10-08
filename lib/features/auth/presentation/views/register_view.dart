import 'package:denuanime/features/auth/data/request/register_request.dart';
import 'package:denuanime/features/auth/domain/cubits/auth_cubit.dart';
import 'package:denuanime/features/auth/domain/cubits/auth_state.dart';
import 'package:denuanime/features/auth/presentation/common/background.dart';
import 'package:denuanime/utils/core/async_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  //? variable ============
  final _formKey = GlobalKey<FormState>();

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

  Future<void> _submit() async {
    // Runs every field's validator and shows errors under the fields.
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    //remove softinput keyboard
    FocusScope.of(context).unfocus();

    final cubit = context.read<AuthCubit>();

    await cubit.registerWithEmail(
      RegisterRequest(
        email: _email.text,
        password: _password.text,
        name: _name.text,
      ),
    );
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) {
      return "Please enter your email.";
    }
    if (!email.contains('@') || !email.contains('.')) {
      return "That email address doesn't look right.";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your password.";
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your name.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            previous.submission != current.submission,
        listener: (context, state) {
          final submission = state.submission;
          if (submission is AsyncFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(submission.message)));
          }
        },
        //? Form + _formKey: lets _submit validate all fields at once.
        child: Form(
          key: _formKey,
          //? AutofillGroup: tells the password manager these fields
          //? belong together, so it can fill both and offer to save.
          child: AutofillGroup(
            child: Background(
              content: Column(
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
                  const Text(
                    "Manage your favorite animes",
                    style: TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(labelText: "Nickname"),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.name],
                    autocorrect: false,
                    validator: _validateName,
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    autocorrect: false,
                    validator: _validateEmail,
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: obscureText,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.newPassword],
                    validator: _validatePassword,
                    keyboardType: .visiblePassword,

                    onFieldSubmitted: (_) {
                      _submit();
                    },
                  ),

                  const SizedBox(height: 24),

                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (p, c) => p.submission != c.submission,
                    builder: (context, state) {
                      final isLoading = state.submission is AsyncLoading;

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _submit,
                          child: isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "Sign up",
                                  style: TextStyle(fontSize: 18),
                                ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  //*======= social login
                  const SizedBox(
                    width: 50,
                    child: Divider(height: 0.5, thickness: 0.2),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "or sign up with",
                    style: TextStyle(color: Colors.white.withValues(alpha: .6)),
                  ),

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
                              child: Image.asset('assets/icons/ic_google.png'),
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
    );
  }
}
