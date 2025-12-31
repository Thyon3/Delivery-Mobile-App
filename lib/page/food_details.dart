import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/models/food.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';
import 'package:thydelivery_mobileapp/components/my_button.dart';

class FoodDetails extends StatefulWidget {
  final Food food;

  final Map<AddOns, bool> selectedAddOns = {};

  FoodDetails({super.key, required this.food}) {
    //lets intilaize the selected add ons
    for (AddOns addon in food.availableAddOns) {
      selectedAddOns[addon] = false;
    }
  }

  @override
  State<FoodDetails> createState() => _FoodDetailsState();
}

class _FoodDetailsState extends State<FoodDetails> {
  void _addToCart(Food food, Map<AddOns, bool> selectedAddOns) {
    final List<AddOns> selectedAddOnsList = [];

    for (AddOns item in widget.food.availableAddOns) {
      if (selectedAddOns[item] == true) {
        selectedAddOnsList.add(item);
      }
    }
    //now call the add to cart method
    context.read<Restaurant>().addToCart(food, selectedAddOnsList);
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.food.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //food image
            Image.asset(widget.food.imagePath),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //food name
                  Text(
                    widget.food.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$' + widget.food.price.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 15),

                  //food description
                  Text(
                    widget.food.description,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 25),

                  Text(
                    'Add Ons',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 8),

                  //addons
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.builder(
                      itemCount: widget.food.availableAddOns.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        //find each add on

                        AddOns addons = widget.food.availableAddOns[index];
                        return CheckboxListTile(
                          value: widget.selectedAddOns[addons],
                          checkColor: Colors.blue,
                          onChanged: (bool? value) {
                            setState(() {
                              widget.selectedAddOns[addons] = value!;
                            });
                          },
                          title: Text(addons.name),
                          subtitle: Text(
                            '\$' + addons.price.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  MyButton(
                    onTap: () {
                      _addToCart(widget.food, widget.selectedAddOns);
                    },
                    text: 'Add to cart',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
