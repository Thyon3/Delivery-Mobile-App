import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thydelivery_mobileapp/theme/app_snackbars.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  final String referralCode = 'THYON2023';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Refer & Earn',
          style: AppTextStyles.h2.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Illustration Placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.card_giftcard_rounded,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            
            const SizedBox(height: 40),
            Text(
              'Invite Friends, Get \$15',
              style: AppTextStyles.h2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Share your code and get \$15 for every friend who places their first order.',
              style: AppTextStyles.bodyM.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 48),
            
            // Promo Code Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1)),
              ),
              child: Column(
                children: [
                  Text(
                    'Your Referral Code',
                    style: AppTextStyles.caption,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        referralCode,
                        style: AppTextStyles.h1.copyWith(
                          letterSpacing: 4,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: referralCode));
                          AppSnackbars.showSuccess(context, 'Code copied to clipboard!');
                        },
                        icon: const Icon(Icons.copy_rounded),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 60),
            
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text('Share to Friends'),
            ),
          ],
        ),
      ),
    );
  }
}

