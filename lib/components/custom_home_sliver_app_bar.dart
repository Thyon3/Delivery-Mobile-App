import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/home_search_bar.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class CustomSliverAppBar extends StatelessWidget {
  final Function(String)? onSearchChanged;
  final TextEditingController? searchController;

  const CustomSliverAppBar({
    super.key,
    this.onSearchChanged,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140,
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu_rounded),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
            child: Icon(Icons.person_rounded, color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deliver to',
            style: AppTextStyles.caption.copyWith(fontSize: 12),
          ),
          Row(
            children: [
              Text(
                'New York City',
                style: AppTextStyles.bodyM.copyWith(fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
            ],
          ),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(16, 120, 16, 0),
          child: Column(
            children: [
              HomeSearchBar(
                onChanged: onSearchChanged,
                controller: searchController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


