import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';

class MyCurrentLocation extends StatelessWidget {
  TextEditingController controller = TextEditingController();

  MyCurrentLocation({super.key});
  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Your address'),
            content: TextField(
              decoration: InputDecoration(hintText: 'Search address...'),
              controller: controller,
            ),
            actions: [
              MaterialButton(
                onPressed: Navigator.of(context).pop,
                child: Text('Cancel'),
              ),
              MaterialButton(
                onPressed: () {
                  context.read<Restaurant>().updateDeliveryAddress(
                    controller.text,
                  );
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deliver Now',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),

            GestureDetector(
              onTap: () {
                openLocationSearchBox(context);
              },
              child: Row(
                children: [
                  Consumer<Restaurant>(
                    builder:
                        (context, restaurant, child) => Text(
                          restaurant.getDeliveryAddress,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  ),
                  Icon(Icons.keyboard_arrow_down_outlined),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
