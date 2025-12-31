import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/my_text_field.dart';
import 'package:thydelivery_mobileapp/components/my_button.dart';
import 'package:thydelivery_mobileapp/services/auth/auth_service.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key, required this.singIn});

  final void Function() singIn;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // have the register method to register the user

  void register(BuildContext context) {
    //get the auth intance first
    final AuthService authService = AuthService();

    // call the signUpWithEmailPassword method

    // first check if the enterd passwords match

    if (passwordController.text == confirmPasswordController.text) {
      try {
        authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
        );
      } catch (e) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    } else {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(content: Text('password do not match')),
      );
    }
  }

  Widget build(context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_open_outlined, size: 100),
            SizedBox(height: 25),
            Text(
              'Welcome to ThyDelivery',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            SizedBox(height: 25),
            MyTextField(
              textEditingController: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            SizedBox(height: 10),
            MyTextField(
              textEditingController: passwordController,
              hintText: 'Passwrod',
              obscureText: true,
            ),
            SizedBox(height: 10),
            MyTextField(
              textEditingController: confirmPasswordController,
              hintText: 'Confirm Password',
              obscureText: true,
            ),
            SizedBox(height: 25),
            MyButton(
              onTap: () {
                register(context);
              },
              text: 'Sign Up',
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Have an Account?',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: singIn,
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
