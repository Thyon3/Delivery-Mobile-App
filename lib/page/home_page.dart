import 'dart:ffi';

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

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  void initState() {
    super.initState();
    tabController = TabController(length: Category.values.length, vsync: this);
  }

  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  //sort out the foods that belong to a single category
  List<Food> filterMenuByCategory(Category category, List<Food> menu) {
    return menu.where((food) => food.category == category).toList();
  }

  //get list of foods within a category

  List<Widget> getFoodInCategory(List<Food> menu) {
    return Category.values.map((category) {
      List<Food> categoryMenu = filterMenuByCategory(category, menu);

      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        itemCount: categoryMenu.length,
        itemBuilder: (context, index) => FoodTile(food: categoryMenu[index]),
      );
    }).toList();
  }

  Widget build(context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              MySliverAppBar(
                title: MyTabBar(tabController: tabController),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //current location
                    MyCurrentLocation(),
                    MyDescriptionBox(),
                  ],
                ),
              ),
            ],
        body: Consumer<Restaurant>(
          builder:
              (context, Restaurant, child) => TabBarView(
                controller: tabController,
                children: getFoodInCategory(Restaurant.menu),
              ),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
