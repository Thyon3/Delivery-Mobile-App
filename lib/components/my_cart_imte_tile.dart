import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/components/my_quantity_selector.dart';
import 'package:thydelivery_mobileapp/models/cart_item.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';

class MyCartImteTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartImteTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder:
          (context, restaurant, child) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      cartItem.food.imagePath,
                      height: 100,
                      width: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(cartItem.food.name),
                          Text(cartItem.food.price.toString()),
                        ],
                      ),
                    ),
                    // Spacer(),
                    Expanded(
                      child: MyQuantitySelector(
                        food: cartItem.food,
                        onIncrement: () {
                          //call the add to cart method from the Restaurant class using the provider
                          restaurant.addToCart(cartItem.food, cartItem.addOns);
                        },
                        onDecrement: () {
                          restaurant.removeFromCart(cartItem);
                        },
                        quantity: cartItem.quantity,
                      ),
                    ),
                  ],
                ),
                // adds on
                SizedBox(
                  height: cartItem.addOns.isEmpty ? 0 : 60,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    children:
                        cartItem.addOns.map((item) {
                          return Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(item.name),
                                  Text(' (\$${item.price.toString()}) '),
                                ],
                              ),
                              shape: StadiumBorder(
                                side: BorderSide(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.inversePrimary,
                                  width: 0.5,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.inversePrimary,
                                fontWeight: FontWeight.bold,
                              ),
                              backgroundColor:
                                  CupertinoColors
                                      .secondarySystemGroupedBackground,
                              onSelected: (value) {},
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
