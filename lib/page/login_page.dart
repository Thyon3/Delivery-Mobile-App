import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/my_text_field.dart';
import 'package:thydelivery_mobileapp/components/my_button.dart';
import 'package:thydelivery_mobileapp/services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  final void Function() signUp;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key, required this.signUp});

  void signIn(BuildContext context) async {
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
                // Logo or Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.fastfood_rounded,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                
                const SizedBox(height: 30),

                // Welcome message
                Text(
                  'ThyDelivery',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 32,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 1.2,
                  ),
                ),
                
                const SizedBox(height: 10),
                
                Text(
                  'Delicious meals delivered to you',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.7),
                  ),
                ),

                const SizedBox(height: 50),

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

                const SizedBox(height: 10),

                // Forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
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

                // Sign up prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: signUp,
                      child: Text(
                        'Join Now',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
