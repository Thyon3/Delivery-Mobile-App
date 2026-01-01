import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/models/cart_item.dart';
import 'package:thydelivery_mobileapp/models/food.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:thydelivery_mobileapp/models/app_user.dart';
import 'package:thydelivery_mobileapp/models/address.dart';
import 'package:thydelivery_mobileapp/services/database/firestore_service.dart';
import 'package:thydelivery_mobileapp/services/notifications/notification_service.dart';
import 'package:thydelivery_mobileapp/services/api/api_client.dart';
import 'package:thydelivery_mobileapp/services/api/restaurant_api.dart';
import 'package:thydelivery_mobileapp/services/api/order_api.dart';

class Restaurant with ChangeNotifier {
  final RestaurantApi _restaurantApi = RestaurantApi(ApiClient());
  final OrderApi _orderApi = OrderApi(ApiClient());
  
  List<Food> _menu = [];
  List<Food> get menu => _menu;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _error;
  String? get error => _error;

  // Fetch menu from backend
  Future<void> fetchMenu() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Get restaurants near a default location or the user's location
      final restaurants = await _restaurantApi.getNearbyRestaurants(
        lat: 40.7128, // Default NYC layout for demo
        lng: -74.0060,
      );

      if (restaurants.isNotEmpty) {
        // Use the first restaurant found to populate the "Restaurant App" menu
        // In a multi-restaurant app, this logic would change.
        final restaurantId = restaurants[0]['id'];
        final details = await _restaurantApi.getRestaurantDetails(restaurantId);
        
        final List<dynamic> menuItems = details['menuItems'] ?? [];
        
        _menu = menuItems.map((item) {
          // Map backend item to Food model
          // AddOns mapping needs adjustment if backend structure differs, 
          // assuming backend sends array of addons.
          List<AddOns> addons = [];
          if (item['addons'] != null) {
            addons = (item['addons'] as List).map((a) => AddOns.fromJson(a)).toList();
          }

          return Food(
            id: item['id'],
            name: item['name'],
            description: item['description'] ?? '',
            price: double.tryParse(item['price'].toString()) ?? 0.0,
            imagePath: item['image'] ?? '', // Handle empty image
            category: _mapCategory(item['category']?['name'] ?? 'BURGER'),
            availableAddOns: addons,
            restaurantId: restaurantId,
            isAvailable: item['isAvailable'] ?? true,
          );
        }).toList();
      }
    } catch (e) {
      _error = e.toString();
      debugPrint('Error fetching menu: $_error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Category _mapCategory(String categoryName) {
    switch (categoryName.toUpperCase()) {
      case 'SIDES': return Category.sides;
      case 'DRINKS': 
      case 'DRINK': return Category.drink;
      case 'DESSERTS': 
      case 'DESSERT': return Category.desserts;
      case 'SALADS': 
      case 'SALAD': return Category.salad;
      case 'BURGERS': 
      case 'BURGER': 
      default: return Category.burger;
    }
  }

  //

  // getters
  List<CartItem> get getCart {
    return _cart;
  }

  String get getDeliveryAddress {
    return _deliveryAddress;
  }

  List<AppUser> get getUsers {
    return _users;
  }

  // Favorites
  final List<Food> _favorites = [];
  List<Food> get favorites => _favorites;

  bool isFavorite(Food food) {
    return _favorites.any((f) => f.name == food.name);
  }

  void toggleFavorite(Food food) {
    final index = _favorites.indexWhere((f) => f.name == food.name);
    if (index != -1) {
      _favorites.removeAt(index);
    } else {
      _favorites.add(food);
    }
    notifyListeners();
  }

  void setFavorites(List<String> favoriteNames) {
    _favorites.clear();
    for (var name in favoriteNames) {
      final food = menu.firstWhereOrNull((f) => f.name == name);
      if (food != null) {
        _favorites.add(food);
      }
    }
    notifyListeners();
  }

  Future<void> loadFavorites() async {
    final names = await FirestoreService().getFavoritesFromFirestore();
    setFavorites(names);
  }

  // Saved Addresses
  List<Address> _savedAddresses = [
    Address(title: 'Home', address: '123 Maple Street, New York, NY 10001', icon: 'home'),
    Address(title: 'Work', address: '456 Broadway, Suite 200, New York, NY 10013', icon: 'work'),
  ];
  List<Address> get savedAddresses => _savedAddresses;

  void addAddress(Address address) {
    _savedAddresses.add(address);
    notifyListeners();
  }

  void setAddresses(List<Address> addresses) {
    _savedAddresses = addresses;
    notifyListeners();
  }

  Future<void> loadAddresses() async {
    final addresses = await FirestoreService().getAddressesFromFirestore();
    if (addresses.isNotEmpty) {
      setAddresses(addresses);
    }
  }

  //operators

  //creat a cart for the items
  final List<CartItem> _cart = [];

  // the delivery address

  String _deliveryAddress = 'Arat Killo Adwa St';

  //add to cart
  void addToCart(Food food, List<AddOns> availabaleAddOns) {
    //check if the item we are adding is already exist on the cart

    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      //check if the food items we are passing are the same with any the ones in the cart

      final bool isTheSameFood = item.food == food;

      //check the addons
      final bool isTheSameAddOns = ListEquality().equals(
        item.availableAddOns,
        availabaleAddOns,
      );
      return isTheSameAddOns && isTheSameFood;
    });

    //if the cart item alrady exist we only have to increase the quantity of the item

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(food: food, addOns: availabaleAddOns));
    }

    notifyListeners();
  }

  //remove from cart

  void removeFromCart(CartItem cartItem) {
    final int cartIndex = _cart.indexOf(cartItem);
    if (cartIndex > -1) {
      if (cartItem.quantity > 1) {
        cartItem.quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
  }

  //get the total price of the cart

  double getTotalPrice() {
    double price = 0.0;
    for (CartItem cart in _cart) {
      price = price + (cart.getTotalPrice * cart.quantity);
    }
    return price;
  }

  //get the number of items inside of th cart

  int getNumberOfItemsInTheCart() {
    int total = 1;
    for (CartItem cart in _cart) {
      total += cart.quantity;
    }
    return total;
  }

  //cear the cart

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  //fomratting double price into dollar values and addons to strings

  String formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}'; //returns $price
  }

  //formatting the addons

  String formatAddons(List<AddOns> addons) {
    return addons
        .map((element) => '${element.name}(${formatPrice(element.price)})')
        .join(', ');
  }

  //generate a reciet

  String userCartReciet() {
    final reciet = StringBuffer();
    reciet.writeln('Here is Your reciet');
    reciet.writeln();

    String formattedDate = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(DateTime.now());

    reciet.writeln(formattedDate);
    reciet.writeln();
    reciet.writeln('------------------------------------------');

    // print out all the necessary information about the order including the quantity, food type and the addons
    for (final item in _cart) {
      reciet.writeln(
        '${item.quantity} x ${item.food.name} - ${formatPrice(item.food.price)}',
      );
      if (item.availableAddOns.isNotEmpty) {
        reciet.writeln('Add Ons: ${formatAddons(item.availableAddOns)}');
      }
    }

    reciet.writeln('------------------------------------------');
    reciet.writeln();

    reciet.writeln('Total Items: ${getNumberOfItemsInTheCart()} ');
    reciet.writeln('Total Price: ${getTotalPrice()}');
    return reciet.toString();
  }

  //helper methods

  // updating the delivery address

  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

  //  create a list of users
  final List<AppUser> _users = [];

  // have a function to add a new user

  void addUser(String name, String email, String phoneNumber) {
    _users.add(AppUser(name: name, email: email, phoneNumber: phoneNumber));
  }
  
  Future<void> placeOrder() async {
    if (_cart.isEmpty) return;
    
    _isLoading = true;
    notifyListeners();

    try {
      // Map cart to order items
      final List<Map<String, dynamic>> orderItems = _cart.map((item) {
        return {
          'menuItemId': item.food.id,
          'quantity': item.quantity,
          'addons': item.addOns.map((a) => a.id).where((id) => id != null).toList(), // Assuming backend accepts addon IDs
        };
      }).toList();

      // Assuming single restaurant for now, use ID from first item
      final restaurantId = _cart.first.food.restaurantId;
      
      if (restaurantId != null) {
        await _orderApi.createOrder(
          restaurantId: restaurantId,
          items: orderItems,
          deliveryAddressId: 'default-address-id', // Needs address management
          paymentMethod: 'CASH',
        );
      }
      
      // 1. Clear the cart
      clearCart();

      // 2. Schedule notifications (Local simulation or rely on backend push)
      // Keeping local for immediate feedback
      await _scheduleOrderNotifications();
      
    } catch (e) {
      debugPrint('Order placement failed: $e');
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _scheduleOrderNotifications() async {
    int notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    // Order Placed
    await NotificationService.showNotification(
      id: notificationId,
      title: 'Order Placed!',
      body: 'Your order has been placed successfully.',
    );

    // Preparing (5 seconds later)
    await Future.delayed(const Duration(seconds: 5));
    await NotificationService.showNotification(
      id: notificationId + 1,
      title: 'Order Preparing',
      body: 'The restaurant is preparing your delicious food.',
    );

    // Out for delivery (10 seconds later)
    await Future.delayed(const Duration(seconds: 5));
    await NotificationService.showNotification(
      id: notificationId + 2,
      title: 'Out for Delivery',
      body: 'Your order is on the way!',
    );

    // Delivered (15 seconds later)
    await Future.delayed(const Duration(seconds: 5));
    await NotificationService.showNotification(
      id: notificationId + 3,
      title: 'Order Delivered',
      body: 'Enjoy your meal!',
    );
  }
}
