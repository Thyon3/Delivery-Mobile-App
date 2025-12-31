import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/components/app_image.dart';
import 'package:thydelivery_mobileapp/models/food.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';
import 'package:thydelivery_mobileapp/services/database/firestore_service.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class PremiumFoodCard extends StatelessWidget {
  final Food food;
  final VoidCallback onTap;

  const PremiumFoodCard({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: 16, bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Hero(
                tag: 'food_${food.name}',
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Stack(
                    children: [
                      AppImage(
                        imagePath: food.imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Consumer<Restaurant>(
                          builder: (context, restaurant, child) {
                            final isFavorite = restaurant.isFavorite(food);
                            return GestureDetector(
                              onTap: () {
                                restaurant.toggleFavorite(food);
                                FirestoreService().toggleFavoriteInFirestore(food.name, !isFavorite);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                  size: 18,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Info
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: AppTextStyles.h3.copyWith(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, size: 16, color: Colors.amber[700]),
                      const SizedBox(width: 4),
                      Text(
                        '4.5',
                        style: AppTextStyles.bodyS.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(120+)',
                        style: AppTextStyles.caption.copyWith(fontSize: 10),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '• 25-35 min',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${food.price.toStringAsFixed(2)}',
                        style: AppTextStyles.price,
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
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
