import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';
import 'package:thydelivery_mobileapp/components/my_cart_imte_tile.dart';
import 'package:thydelivery_mobileapp/components/my_button.dart';
import 'package:thydelivery_mobileapp/page/paymentpage.dart';

class Cart extends StatelessWidget {
  Cart({super.key});

  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        //get the cart from the Restaurant class
        final userCart = restaurant.getCart;
        return Scaffold(
          appBar: AppBar(
            title: Text('Cart'),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 15),
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete all the orders in the cart?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.inversePrimary,
                                ),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {
                                restaurant.clearCart();
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.inversePrimary,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            backgroundColor: Colors.transparent,
          ),
          body:
              userCart.isEmpty
                  ? Center(
                    child: Text(
                      'Your cart is Empty please add some elemnts and come back',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                  : Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: userCart.length,
                            itemBuilder: (context, index) {
                              final singleCartItem = userCart[index];
                              return MyCartImteTile(cartItem: singleCartItem);
                            },
                          ),
                        ),
                        MyButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PaymentPage(),
                              ),
                            );
                          },
                          text: 'Pay Now',
                        ),
                      ],
                    ),
                  ),
        );
      },
    );
  }
}
