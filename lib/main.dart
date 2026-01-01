import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/firebase_options.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';
import 'package:thydelivery_mobileapp/services/auth/auth_gate.dart';
import 'package:thydelivery_mobileapp/theme/theme_provider.dart';

import 'package:thydelivery_mobileapp/services/notifications/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initialize();
  runApp(
    ProviderScope(
      child: MultiProvider(
        providers: [
          //Theme Provider
          ChangeNotifierProvider(create: (context) => ThemeProvider()),

          //Restaurant provider
          ChangeNotifierProvider(create: (context) => Restaurant()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
