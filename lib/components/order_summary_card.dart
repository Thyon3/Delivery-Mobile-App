import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class OrderSummaryCard extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double discount;

  const OrderSummaryCard({
    super.key,
    required this.subtotal,
    this.deliveryFee = 5.00,
    this.discount = 0.0,
  });

  double get tax => subtotal * 0.08; // 8% tax
  double get total => subtotal + deliveryFee + tax - discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Order Summary',
                style: AppTextStyles.h3.copyWith(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          _buildRow(context, 'Subtotal', subtotal),
          const SizedBox(height: 10),
          _buildRow(context, 'Delivery Fee', deliveryFee),
          const SizedBox(height: 10),
          _buildRow(context, 'Tax (8%)', tax),
          
          if (discount > 0) ...[
            const SizedBox(height: 10),
            _buildRow(context, 'Discount', -discount, isDiscount: true),
          ],
          
          const SizedBox(height: 16),
          Divider(color: Theme.of(context).colorScheme.secondary.withOpacity(0.2)),
          const SizedBox(height: 16),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTextStyles.h2.copyWith(fontSize: 20),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: AppTextStyles.h2.copyWith(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, double amount, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyM.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        Text(
          '${isDiscount ? '-' : ''}\$${amount.abs().toStringAsFixed(2)}',
          style: AppTextStyles.bodyM.copyWith(
            fontWeight: FontWeight.bold,
            color: isDiscount ? Colors.green : null,
          ),
        ),
      ],
    );
  }
}
