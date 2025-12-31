import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class NutritionalInfo extends StatelessWidget {
  const NutritionalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nutritional Information',
          style: AppTextStyles.h3.copyWith(fontSize: 18),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildNutritionCard(context, 'Calories', '450', 'kcal', Colors.orange),
              _buildNutritionCard(context, 'Protein', '25', 'g', Colors.green),
              _buildNutritionCard(context, 'Carbs', '35', 'g', Colors.blue),
              _buildNutritionCard(context, 'Fat', '18', 'g', Colors.red),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionCard(BuildContext context, String label, String value, String unit, Color color) {
    return Container(
      width: 85,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            style: AppTextStyles.caption.copyWith(fontSize: 10),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.h3.copyWith(color: color, fontSize: 18),
          ),
          Text(
            unit,
            style: AppTextStyles.caption.copyWith(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
