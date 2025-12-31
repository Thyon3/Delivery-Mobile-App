import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class VoucherCard extends StatelessWidget {
  final String title;
  final String discount;
  final String expiryDate;
  final String code;
  final Color color;

  const VoucherCard({
    super.key,
    required this.title,
    required this.discount,
    required this.expiryDate,
    required this.code,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 120,
      child: Stack(
        children: [
          // Main Body
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.h3.copyWith(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        discount,
                        style: AppTextStyles.h2.copyWith(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.5)),
                  ),
                  child: Text(
                    code,
                    style: AppTextStyles.button.copyWith(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          
          // Side Cut-outs (Stylistic)
          Positioned(
            left: -10,
            top: 50,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -10,
            top: 50,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                shape: BoxShape.circle,
              ),
            ),
          ),
          
          // Expiry info
          Positioned(
            bottom: 8,
            left: 20,
            child: Text(
              'Expires: $expiryDate',
              style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
