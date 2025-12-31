import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/page/order/deliveryprogress.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';
import 'package:thydelivery_mobileapp/services/notifications/notification_service.dart';
import 'dart:async';

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({super.key});

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  @override
  void initState() {
    super.initState();
    _triggerOrderNotifications();
  }

  void _triggerOrderNotifications() {
    // Immediate notification
    NotificationService.showNotification(
      id: 1,
      title: 'Order Confirmed!',
      body: 'Your order #THY-78294 has been received.',
    );

    // Simulated status updates
    Timer(const Duration(seconds: 10), () {
      NotificationService.showNotification(
        id: 2,
        title: 'Preparing Your Meal',
        body: 'The chef is working on your delicious order!',
      );
    });

    Timer(const Duration(seconds: 25), () {
      NotificationService.showNotification(
        id: 3,
        title: 'Out for Delivery',
        body: 'Your rider is on the way with your food!',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Animated Success Icon Placeholder
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 80,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
              Text(
                'Order Placed Successfully!',
                style: AppTextStyles.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your delicious meal is being prepared and will be with you shortly.',
                style: AppTextStyles.bodyM.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 48),
              
              // Order ID Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order ID',
                      style: AppTextStyles.bodyM.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '#THY-78294',
                      style: AppTextStyles.bodyM.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(),
              
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Deliveryprogress()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('Track My Order'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                child: Text(
                  'Back to Home',
                  style: AppTextStyles.button.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
