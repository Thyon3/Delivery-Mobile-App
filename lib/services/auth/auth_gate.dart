import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thydelivery_mobileapp/page/home/home_page.dart';
import 'package:thydelivery_mobileapp/services/auth/login_or_register.dart';
import 'package:thydelivery_mobileapp/page/auth/onboarding_page.dart';
import 'package:thydelivery_mobileapp/services/prefs_service.dart';
import 'package:thydelivery_mobileapp/providers/auth_provider.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    if (authState.isAuthenticated) {
      return const HomePage();
    }
    
    return FutureBuilder<bool>(
      future: PrefsService.isOnboardingSeen(),
      builder: (context, onboardingSnapshot) {
        if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        
        if (onboardingSnapshot.data == true) {
          return const LoginOrRegister();
        } else {
          return const OnboardingPage();
        }
      },
    );
  }
}
