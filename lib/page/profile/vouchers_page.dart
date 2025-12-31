import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/voucher_card.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class VouchersPage extends StatelessWidget {
  const VouchersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _vouchers = [
      {
        'title': 'Welcome Discount',
        'discount': '\$10 OFF',
        'expiryDate': 'Dec 31, 2023',
        'code': 'WELCOME10',
        'color': Colors.blueAccent,
      },
      {
        'title': 'Free Delivery',
        'discount': 'FREE SHIP',
        'expiryDate': 'Nov 15, 2023',
        'code': 'FREESHIP',
        'color': Colors.orangeAccent,
      },
      {
        'title': 'Weekend Special',
        'discount': '20% OFF',
        'expiryDate': 'Nov 20, 2023',
        'code': 'WEEKEND20',
        'color': Colors.purpleAccent,
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'My Rewards',
          style: AppTextStyles.h2.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Vouchers',
              style: AppTextStyles.h3.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ..._vouchers.map((item) {
              return VoucherCard(
                title: item['title'],
                discount: item['discount'],
                expiryDate: item['expiryDate'],
                code: item['code'],
                color: item['color'],
              );
            }),
          ],
        ),
      ),
    );
  }
}
