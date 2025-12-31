import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/skeleton_loader.dart';

class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Search Bar Skeleton
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SkeletonLoader(height: 55, width: double.infinity, borderRadius: 15),
          ),
          const SizedBox(height: 25),
          
          // Promo Banner Skeleton
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SkeletonLoader(height: 160, width: double.infinity, borderRadius: 25),
          ),
          const SizedBox(height: 25),
          
          // Categories Skeleton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: List.generate(4, (index) => const Padding(
                padding: EdgeInsets.only(right: 12),
                child: SkeletonLoader(height: 40, width: 80, borderRadius: 20),
              )),
            ),
          ),
          const SizedBox(height: 32),
          
          // Featured Section Skeleton
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SkeletonLoader(height: 24, width: 150, borderRadius: 5),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: List.generate(2, (index) => const Padding(
                padding: EdgeInsets.only(right: 16),
                child: SkeletonLoader(height: 280, width: 220, borderRadius: 25),
              )),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // List Skeleton
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SkeletonLoader(height: 24, width: 120, borderRadius: 5),
          ),
          const SizedBox(height: 16),
          ...List.generate(3, (index) => const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: SkeletonLoader(height: 100, width: double.infinity, borderRadius: 20),
          )),
        ],
      ),
    );
  }
}
