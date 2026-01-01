import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';
import 'package:thydelivery_mobileapp/components/cart_item_card.dart';
import 'package:thydelivery_mobileapp/components/order_summary_card.dart';
import 'package:thydelivery_mobileapp/components/promo_code_input.dart';
import 'package:thydelivery_mobileapp/page/order/paymentpage.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double _discount = 0.0;

  void _handlePromoCode(String code) {
    setState(() {
      // Simple promo code logic - in real app, validate with backend
      if (code.toUpperCase() == 'SAVE10') {
        _discount = 10.0;
      } else if (code.toUpperCase() == 'FREESHIP') {
        _discount = 5.0;
      } else if (code.isEmpty) {
        _discount = 0.0;
      }
    });
  }

  double _calculateSubtotal(List cart) {
    double subtotal = 0;
    for (var cartItem in cart) {
      double itemTotal = cartItem.food.price;
      for (var addon in cartItem.addOns) {
        itemTotal += addon.price;
      }
      subtotal += itemTotal * cartItem.quantity;
    }
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        final userCart = restaurant.getCart;
        final subtotal = _calculateSubtotal(userCart);

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: Text(
              'My Cart',
              style: AppTextStyles.h2.copyWith(fontSize: 22),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              if (userCart.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Text(
                            'Clear Cart?',
                            style: AppTextStyles.h3,
                          ),
                          content: Text(
                            'Are you sure you want to remove all items from your cart?',
                            style: AppTextStyles.bodyM,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Cancel',
                                style: AppTextStyles.button.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                restaurant.clearCart();
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Clear',
                                style: AppTextStyles.button,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
            ],
          ),
          body: userCart.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 100,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your cart is empty',
                        style: AppTextStyles.h2.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add some delicious items to get started!',
                        style: AppTextStyles.bodyM.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cart Items
                            Text(
                              'Items (${userCart.length})',
                              style: AppTextStyles.h3.copyWith(fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            ...userCart.map((cartItem) {
                              return CartItemCard(cartItem: cartItem);
                            }).toList(),

                            const SizedBox(height: 24),

                            // Promo Code
                            Text(
                              'Promo Code',
                              style: AppTextStyles.h3.copyWith(fontSize: 16),
                            ),
                            const SizedBox(height: 12),
                            PromoCodeInput(onApplyPromo: _handlePromoCode),

                            const SizedBox(height: 24),

                            // Order Summary
                            OrderSummaryCard(
                              subtotal: subtotal,
                              discount: _discount,
                            ),

                            const SizedBox(height: 100), // Space for floating button
                          ],
                        ),
                      ),
                    ),

                    // Floating Checkout Button
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentPage(),
                              ),
                            );
                          },
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
                                'Proceed to Checkout',
                                style: AppTextStyles.button.copyWith(fontSize: 18),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '\$${(subtotal + 5.00 + subtotal * 0.08 - _discount).toStringAsFixed(2)}',
                                  style: AppTextStyles.button.copyWith(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

