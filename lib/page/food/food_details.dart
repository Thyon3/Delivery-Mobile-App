import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/models/food.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';
import 'package:thydelivery_mobileapp/components/addon_checkbox.dart';
import 'package:thydelivery_mobileapp/components/quantity_selector.dart';
import 'package:thydelivery_mobileapp/components/nutritional_info.dart';
import 'package:thydelivery_mobileapp/components/premium_food_card.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';
import 'package:flutter/services.dart';
import 'package:thydelivery_mobileapp/theme/app_snackbars.dart';

import 'package:thydelivery_mobileapp/page/cart/cart.dart';

class FoodDetails extends StatefulWidget {
  final Food food;

  const FoodDetails({super.key, required this.food});

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> with SingleTickerProviderStateMixin {
  final Map<AddOns, bool> selectedAddOns = {};
  int quantity = 1;
  late AnimationController _animationController;
  late Animation<Offset> _flyAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _showFlyer = false;

  @override
  void initState() {
    super.initState();
    // Initialize selected add-ons
    for (AddOns addon in widget.food.availableAddOns) {
      selectedAddOns[addon] = false;
    }

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _flyAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4), // Start from bottom
      end: const Offset(0.35, -0.45), // End at top right
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    ));

    _scaleAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.5), weight: 20),
      TweenSequenceItem(tween: Tween<double>(begin: 1.5, end: 0.2), weight: 80),
    ]).animate(_animationController);

    _opacityAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 1.0), weight: 10),
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.0), weight: 70),
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.0), weight: 20),
    ]).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showFlyer = false;
        });
        _animationController.reset();
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _calculateTotalPrice() {
    double total = widget.food.price * quantity;
    for (var entry in selectedAddOns.entries) {
      if (entry.value) {
        total += entry.key.price * quantity;
      }
    }
    return total;
  }

  void _addToCart() {
    final List<AddOns> selectedAddOnsList = [];
    
    for (AddOns item in widget.food.availableAddOns) {
      if (selectedAddOns[item] == true) {
        selectedAddOnsList.add(item);
      }
    }

    // Add to cart with quantity
    for (int i = 0; i < quantity; i++) {
      context.read<Restaurant>().addToCart(widget.food, selectedAddOnsList);
    }

    // Show success feedback
    if (context.mounted) {
      HapticFeedback.heavyImpact();
      AppSnackbars.showSuccess(context, '$quantity x ${widget.food.name} added to cart!');
      
      setState(() {
        _showFlyer = true;
      });
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Premium Full-Width Image Header
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: Theme.of(context).colorScheme.background,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_rounded, color: Theme.of(context).colorScheme.primary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart_outlined, color: Theme.of(context).colorScheme.primary),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const Cart()));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      child: IconButton(
                        icon: Icon(Icons.favorite_border_rounded, color: Theme.of(context).colorScheme.primary),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'food_${widget.food.name}',
                    child: Image.asset(
                      widget.food.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Rating
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.food.name,
                                    style: AppTextStyles.h1.copyWith(fontSize: 26),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.star_rounded, size: 20, color: Colors.amber[700]),
                                      const SizedBox(width: 4),
                                      Text('4.5', style: AppTextStyles.bodyM.copyWith(fontWeight: FontWeight.bold)),
                                      const SizedBox(width: 4),
                                      Text(
                                        '(120+ ratings)',
                                        style: AppTextStyles.caption,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                '\$${widget.food.price.toStringAsFixed(2)}',
                                style: AppTextStyles.h2.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Description
                        Text(
                          'Description',
                          style: AppTextStyles.h3.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.food.description,
                          style: AppTextStyles.bodyM.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Quantity Selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Quantity',
                              style: AppTextStyles.h3.copyWith(fontSize: 18),
                            ),
                            QuantitySelector(
                              quantity: quantity,
                              onIncrement: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              onDecrement: () {
                                setState(() {
                                  if (quantity > 1) quantity--;
                                });
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Add-ons Section
                        if (widget.food.availableAddOns.isNotEmpty) ...[
                          Text(
                            'Customize Your Order',
                            style: AppTextStyles.h3.copyWith(fontSize: 18),
                          ),
                          const SizedBox(height: 12),
                          ...widget.food.availableAddOns.map((addon) {
                            return AddonCheckbox(
                              addon: addon,
                              isSelected: selectedAddOns[addon] ?? false,
                              onChanged: (value) {
                                setState(() {
                                  selectedAddOns[addon] = value ?? false;
                                });
                              },
                            );
                          }).toList(),
                          const SizedBox(height: 24),
                        ],

                        // Nutritional Info
                        const NutritionalInfo(),

                        const SizedBox(height: 24),

                        // Similar Items
                        Consumer<Restaurant>(
                          builder: (context, restaurant, child) {
                            final similarItems = restaurant.menu
                                .where((item) => item.category == widget.food.category && item.name != widget.food.name)
                                .take(3)
                                .toList();

                            if (similarItems.isEmpty) return const SizedBox.shrink();

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'You Might Also Like',
                                  style: AppTextStyles.h3.copyWith(fontSize: 18),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  height: 280,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: similarItems.length,
                                    itemBuilder: (context, index) {
                                      final food = similarItems[index];
                                      return PremiumFoodCard(
                                        food: food,
                                        onTap: () {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FoodDetails(food: food),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        const SizedBox(height: 100), // Space for floating button
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Floating Add to Cart Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: _addToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add to Cart',
                        style: AppTextStyles.button.copyWith(fontSize: 18),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '\$${_calculateTotalPrice().toStringAsFixed(2)}',
                          style: AppTextStyles.button.copyWith(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Flying Animation Element
          if (_showFlyer)
            IgnorePointer(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment(_flyAnimation.value.dx, _flyAnimation.value.dy),
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(widget.food.imagePath),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
