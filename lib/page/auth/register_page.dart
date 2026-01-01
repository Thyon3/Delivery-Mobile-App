import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thydelivery_mobileapp/components/my_text_field.dart';
import 'package:thydelivery_mobileapp/components/my_button.dart';
import 'package:thydelivery_mobileapp/components/social_login_button.dart';
import 'package:thydelivery_mobileapp/theme/app_snackbars.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';
import 'package:thydelivery_mobileapp/providers/auth_provider.dart';

class SignUpPage extends ConsumerStatefulWidget {
  final void Function() signIn;
  const SignUpPage({super.key, required this.signIn});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? firstNameError;
  String? lastNameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  bool validateFields() {
    setState(() {
      firstNameError = firstNameController.text.isEmpty ? 'First name required' : null;
      lastNameError = lastNameController.text.isEmpty ? 'Last name required' : null;
      
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

    return firstNameError == null && 
           lastNameError == null && 
           emailError == null && 
           passwordError == null && 
           confirmPasswordError == null;
  }

  void register(BuildContext context) async {
    if (!validateFields()) return;

    final success = await ref.read(authProvider.notifier).register(
      emailController.text,
      passwordController.text,
      firstNameController.text,
      lastNameController.text,
    );

    if (!success && mounted) {
       final error = ref.read(authProvider).error;
       AppSnackbars.showError(context, error ?? 'Registration failed');
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
            left: -100,
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
                  
                  // Back button
                  IconButton(
                    onPressed: widget.signIn,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  
                  const SizedBox(height: 32),
                  Text(
                    'Create Account',
                    style: AppTextStyles.h1,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Join us and enjoy delicious meals',
                    style: AppTextStyles.bodyM.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Name fields
                  Row(
                    children: [
                      Expanded(
                        child: MyTextField(
                          textEditingController: firstNameController,
                          hintText: 'First Name',
                          obscureText: false,
                          prefixIcon: Icons.person_outline,
                          errorText: firstNameError,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: MyTextField(
                          textEditingController: lastNameController,
                          hintText: 'Last Name',
                          obscureText: false,
                          prefixIcon: Icons.person_outline,
                          errorText: lastNameError,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

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

                  const SizedBox(height: 20),

                  // Confirm Password field
                  MyTextField(
                    textEditingController: confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                    prefixIcon: Icons.lock_reset_rounded,
                    errorText: confirmPasswordError,
                  ),

                  const SizedBox(height: 48),

                  // Sign up button
                  MyButton(
                    onTap: () => register(context),
                    text: 'Create Account',
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

                  // Sign back prompt
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already a member?',
                        style: AppTextStyles.bodyM,
                      ),
                      TextButton(
                        onPressed: widget.signIn,
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


