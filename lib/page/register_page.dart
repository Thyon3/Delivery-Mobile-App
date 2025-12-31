import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/my_text_field.dart';
import 'package:thydelivery_mobileapp/components/my_button.dart';
import 'package:thydelivery_mobileapp/components/auth_header.dart';
import 'package:thydelivery_mobileapp/components/social_login_button.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';
import 'package:thydelivery_mobileapp/services/auth/auth_service.dart';

class SignUpPage extends StatefulWidget {
  final void Function() signIn;
  SignUpPage({super.key, required this.signIn});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  bool validateFields() {
    setState(() {
      emailError = emailController.text.isEmpty ? 'Email is required' : null;
      if (emailError == null && !emailController.text.contains('@')) {
        emailError = 'Enter a valid email';
      }
      passwordError = passwordController.text.isEmpty ? 'Password is required' : null;
      if (passwordError == null && passwordController.text.length < 6) {
        passwordError = 'Password must be at least 6 characters';
      }
      confirmPasswordError = confirmPasswordController.text.isEmpty ? 'Confirm password' : null;
      if (confirmPasswordError == null && passwordController.text != confirmPasswordController.text) {
        confirmPasswordError = 'Passwords do not match';
      }
    });

    return emailError == null && passwordError == null && confirmPasswordError == null;
  }

  void register(BuildContext context) async {
    if (!validateFields()) return;

    final AuthService authService = AuthService();

    try {
      await authService.signUpWithEmailPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registration Error'),
            content: Text(e.toString()),
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
                  title: 'Create Account',
                  subtitle: 'Start your delicious journey today',
                ),
                const SizedBox(height: 40),

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

                const SizedBox(height: 15),

                // Confirm Password field
                MyTextField(
                  textEditingController: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  prefixIcon: Icons.lock_reset_rounded,
                  errorText: confirmPasswordError,
                ),

                const SizedBox(height: 30),

                // Sign up button
                MyButton(
                  onTap: () => register(context),
                  text: 'Sign Up',
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

                // Sign in prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: AppTextStyles.bodyM.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: widget.signIn,
                      child: Text(
                        'Sign In',
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
