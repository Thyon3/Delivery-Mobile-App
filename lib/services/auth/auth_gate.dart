import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thydelivery_mobileapp/services/auth/login_or_register.dart';

import 'package:thydelivery_mobileapp/page/onboarding_page.dart';
import 'package:thydelivery_mobileapp/services/prefs_service.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return FutureBuilder<bool>(
              future: PrefsService.isOnboardingSeen(),
              builder: (context, onboardingSnapshot) {
                if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (onboardingSnapshot.data == true) {
                  return const LoginOrRegister();
                } else {
                  return const OnboardingPage();
                }
              },
            );
          }
        },
      ),
    );
  }
}
