import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/my_text_field.dart';
import 'package:thydelivery_mobileapp/components/my_button.dart';
import 'package:thydelivery_mobileapp/components/auth_header.dart';
import 'package:thydelivery_mobileapp/components/social_login_button.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';
import 'package:thydelivery_mobileapp/services/auth/auth_service.dart';

class SignUpPage extends StatelessWidget {
  final void Function() signIn;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  SignUpPage({super.key, required this.signIn});

  void register(BuildContext context) async {
    final AuthService authService = AuthService();

    if (passwordController.text == confirmPasswordController.text) {
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
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match'),
        ),
      );
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
                ),

                const SizedBox(height: 15),

                // Password field
                MyTextField(
                  textEditingController: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: Icons.lock_outline_rounded,
                ),

                const SizedBox(height: 15),

                // Confirm Password field
                MyTextField(
                  textEditingController: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  prefixIcon: Icons.lock_reset_rounded,
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
                      onTap: signIn,
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
