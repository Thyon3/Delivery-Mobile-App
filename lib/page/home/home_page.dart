import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/components/my_description_box.dart';
import 'package:thydelivery_mobileapp/components/my_sliver_app_bar.dart';
import 'package:thydelivery_mobileapp/components/my_tab_bar.dart';
import 'package:thydelivery_mobileapp/models/food.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';
import 'package:thydelivery_mobileapp/components/my_drawer.dart';
import 'package:thydelivery_mobileapp/components/my_current_location.dart';
import 'package:thydelivery_mobileapp/components/food_tile.dart';
import 'package:thydelivery_mobileapp/components/home_skeleton.dart';
import 'package:thydelivery_mobileapp/page/food/food_details.dart';

import 'package:thydelivery_mobileapp/components/category_pill.dart';
import 'package:thydelivery_mobileapp/components/custom_home_sliver_app_bar.dart';
import 'package:thydelivery_mobileapp/components/filter_chip_group.dart';
import 'package:thydelivery_mobileapp/components/premium_food_card.dart';
import 'package:thydelivery_mobileapp/components/promo_banner.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Category _selectedCategory = Category.burger;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Food> _filterMenuByCategory(Category category, List<Food> menu) {
    return menu.where((food) => food.category == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const CustomSliverAppBar(),
        ],
        body: _isLoading 
          ? const HomeSkeleton()
          : Consumer<Restaurant>(
              builder: (context, restaurant, child) {
            final filteredMenu = _filterMenuByCategory(_selectedCategory, restaurant.menu);
            
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Promo Banners
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: PromoBanner(),
                  ),
                  
                  const SizedBox(height: 20),

                  // Quick Filters
                  const FilterChipGroup(),

                  const SizedBox(height: 30),

                  // Categories
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Categories',
                      style: AppTextStyles.h2.copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: Category.values.length,
                      itemBuilder: (context, index) {
                        final category = Category.values[index];
                        return CategoryPill(
                          title: category.toString().split('.').last,
                          isSelected: _selectedCategory == category,
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Popular Near You
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular Near You',
                          style: AppTextStyles.h2.copyWith(fontSize: 18),
                        ),
                        Text(
                          'View All',
                          style: AppTextStyles.bodyS.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: restaurant.menu.length > 5 ? 5 : restaurant.menu.length,
                      itemBuilder: (context, index) {
                        final food = restaurant.menu[index];
                        return PremiumFoodCard(
                          food: food,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FoodDetails(food: food)),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Selected Category Items
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'All ${_selectedCategory.toString().split('.').last}s',
                      style: AppTextStyles.h2.copyWith(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredMenu.length,
                    itemBuilder: (context, index) {
                      final food = filteredMenu[index];
                      return FoodTile(
                        food: food,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FoodDetails(food: food)),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
