import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/my_text_field.dart';
import 'package:thydelivery_mobileapp/components/my_button.dart';
import 'package:thydelivery_mobileapp/components/auth_header.dart';
import 'package:thydelivery_mobileapp/components/social_login_button.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';
import 'package:thydelivery_mobileapp/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function() signUp;
  LoginPage({super.key, required this.signUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  bool validateFields() {
    setState(() {
      emailError = emailController.text.isEmpty ? 'Email is required' : null;
      if (emailError == null && !emailController.text.contains('@')) {
        emailError = 'Enter a valid email';
      }
      passwordError = passwordController.text.isEmpty ? 'Password is required' : null;
    });

    return emailError == null && passwordError == null;
  }

  void signIn(BuildContext context) async {
    if (!validateFields()) return;

    final AuthService authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Login Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const AuthHeader(
                  title: 'ThyDelivery',
                  subtitle: 'Delicious meals delivered to you',
                ),
                const SizedBox(height: 50),

                // Email field
                MyTextField(
                  textEditingController: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  prefixIcon: Icons.email_outlined,
                  errorText: emailError,
                ),

                const SizedBox(height: 15),

                // Password field
                MyTextField(
                  textEditingController: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline_rounded,
                  errorText: passwordError,
                ),

                const SizedBox(height: 10),

                // Forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Forgot Password logic
                        },
                        child: Text(
                          'Forgot Password?',
                          style: AppTextStyles.bodyM.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Sign in button
                MyButton(
                  onTap: () => signIn(context),
                  text: 'Sign In',
                ),

                const SizedBox(height: 25),

                // Or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: Theme.of(context).colorScheme.secondary)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
                        ),
                      ),
                      Expanded(child: Divider(color: Theme.of(context).colorScheme.secondary)),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Social Login Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      SocialLoginButton(
                        logoPath: '',
                        label: 'Google',
                        onTap: () {},
                      ),
                      const SizedBox(width: 15),
                      SocialLoginButton(
                        logoPath: '',
                        label: 'Apple',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Sign up prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: AppTextStyles.bodyM.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: widget.signUp,
                      child: Text(
                        'Join Now',
                        style: AppTextStyles.bodyM.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
