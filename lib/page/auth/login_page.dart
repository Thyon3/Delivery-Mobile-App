import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thydelivery_mobileapp/components/my_text_field.dart';
import 'package:thydelivery_mobileapp/components/my_button.dart';
import 'package:thydelivery_mobileapp/components/social_login_button.dart';
import 'package:thydelivery_mobileapp/theme/app_snackbars.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';
import 'package:thydelivery_mobileapp/providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  final void Function() signUp;
  LoginPage({super.key, required this.signUp});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
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

    // Use Riverpod auth provider
    final success = await ref.read(authProvider.notifier).login(
      emailController.text,
      passwordController.text,
    );

    if (!success && mounted) {
      final error = ref.read(authProvider).error;
      AppSnackbars.showError(context, error ?? 'Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          // Background decorative circles
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  
                  // App Logo Placeholder
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.restaurant_rounded,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  Text(
                    'Welcome Back',
                    style: AppTextStyles.h1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login to continue your culinary journey',
                    style: AppTextStyles.bodyM.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Email field
                  MyTextField(
                    textEditingController: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    prefixIcon: Icons.email_outlined,
                    errorText: emailError,
                  ),

                  const SizedBox(height: 20),

                  // Password field
                  MyTextField(
                    textEditingController: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    prefixIcon: Icons.lock_outline_rounded,
                    errorText: passwordError,
                  ),

                  const SizedBox(height: 16),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: AppTextStyles.bodyS.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Sign in button
                  MyButton(
                    onTap: () => signIn(context),
                    text: 'Sign In',
                  ),

                  const SizedBox(height: 40),

                  // Or continue with divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'OR CONTINUE WITH',
                          style: AppTextStyles.caption.copyWith(fontSize: 10),
                        ),
                      ),
                      Expanded(child: Divider(color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3))),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Social Login Buttons
                  Row(
                    children: [
                      Expanded(
                        child: SocialLoginButton(
                          logoPath: '',
                          label: 'Google',
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SocialLoginButton(
                          logoPath: '',
                          label: 'Apple',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // Sign up prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: AppTextStyles.bodyM,
                      ),
                      TextButton(
                        onPressed: widget.signUp,
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
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


