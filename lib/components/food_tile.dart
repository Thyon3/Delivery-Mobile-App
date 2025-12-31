import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/app_image.dart';
import 'package:thydelivery_mobileapp/models/food.dart';
import 'package:thydelivery_mobileapp/page/food/food_details.dart';

import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class FoodTile extends StatelessWidget {
  final Food food;
  final VoidCallback onTap;

  const FoodTile({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            Hero(
              tag: 'food_${food.name}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: AppImage(
                  imagePath: food.imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: AppTextStyles.h3.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    food.description,
                    style: AppTextStyles.caption.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${food.price.toStringAsFixed(2)}',
                        style: AppTextStyles.price.copyWith(fontSize: 16),
                      ),
                      Row(
                        children: [
                          Icon(Icons.local_fire_department_rounded, size: 14, color: Colors.orange[700]),
                          const SizedBox(width: 4),
                          Text(
                            '350 kcal',
                            style: AppTextStyles.caption.copyWith(fontSize: 10),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.star_rounded, size: 16, color: Colors.amber[700]),
                          const SizedBox(width: 4),
                          Text(
                            '4.2',
                            style: AppTextStyles.bodyS.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
