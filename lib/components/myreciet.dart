import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';

class Myreciet extends StatelessWidget {
  const Myreciet({super.key});

  Widget build(context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.primary),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 8, left: 15),
        child: Column(
          children: [
            Consumer<Restaurant>(
              builder: (context, restaurant, child) {
                return Text(restaurant.userCartReciet());
              },
            ),
          ],
        ),
      ),
    );
  }
}
