import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/page/cart/cart.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget title;
  final Widget child;

  MySliverAppBar({super.key, required this.title, required this.child});
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 350,
      collapsedHeight: 120,
      title: Text(
        'T H Y O N ',
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      floating: true,
      pinned: true,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart()),
            );
          },
          icon: Icon(Icons.shopping_cart, size: 30),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(padding: EdgeInsets.only(bottom: 60), child: child),
        title: title,
        centerTitle: true,
        titlePadding: EdgeInsets.only(right: 0, left: 0, top: 10, bottom: 1),
      ),
    );
  }
}
