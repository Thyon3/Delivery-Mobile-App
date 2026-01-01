import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/models/cart_item.dart';
import 'package:thydelivery_mobileapp/models/food.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:thydelivery_mobileapp/models/app_user.dart';
import 'package:thydelivery_mobileapp/models/address.dart';
import 'package:thydelivery_mobileapp/services/notifications/notification_service.dart';
import 'package:thydelivery_mobileapp/services/api/api_client.dart';
import 'package:thydelivery_mobileapp/services/api/restaurant_api.dart';
import 'package:thydelivery_mobileapp/services/api/address_api.dart';
import 'package:thydelivery_mobileapp/services/api/order_api.dart';

class Restaurant with ChangeNotifier {
  final AddressApi _addressApi = AddressApi(ApiClient());
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
        final restaurantId = restaurants[0]['id'];
        final details = await _restaurantApi.getRestaurantDetails(restaurantId);
        
        final List<dynamic> menuItems = details['menuItems'] ?? [];
        
        _menu = menuItems.map((item) {
          List<AddOns> addons = [];
          if (item['addons'] != null) {
            addons = (item['addons'] as List).map((a) => AddOns.fromJson(a)).toList();
          }

          return Food(
            id: item['id'],
            name: item['name'],
            description: item['description'] ?? '',
            price: double.tryParse(item['price'].toString()) ?? 0.0,
            imagePath: item['image'] ?? '', 
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

  // Cart
  final List<CartItem> _cart = [];
  List<CartItem> get getCart => _cart;

  void addToCart(Food food, List<AddOns> availabaleAddOns) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      final bool isTheSameFood = item.food == food;
      final bool isTheSameAddOns = ListEquality().equals(
        item.availableAddOns,
        availabaleAddOns,
      );
      return isTheSameAddOns && isTheSameFood;
    });

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(food: food, addOns: availabaleAddOns));
    }
    notifyListeners();
  }

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
  
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  double getTotalPrice() {
    double price = 0.0;
    for (CartItem cart in _cart) {
      price = price + (cart.getTotalPrice * cart.quantity);
    }
    return price;
  }

  int getNumberOfItemsInTheCart() {
    int total = 1;
    for (CartItem cart in _cart) {
      total += cart.quantity;
    }
    return total;
  }

  String formatPrice(double price) {
    return '\$${price.toStringAsFixed(2)}'; 
  }

  String formatAddons(List<AddOns> addons) {
    return addons
        .map((element) => '${element.name}(${formatPrice(element.price)})')
        .join(', ');
  }

  String userCartReciet() {
    final reciet = StringBuffer();
    reciet.writeln('Here is Your reciet');
    reciet.writeln();

    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    reciet.writeln(formattedDate);
    reciet.writeln();
    reciet.writeln('------------------------------------------');

    for (final item in _cart) {
      reciet.writeln('${item.quantity} x ${item.food.name} - ${formatPrice(item.food.price)}');
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

  // Address Management
  List<Address> _savedAddresses = [];
  List<Address> get savedAddresses => _savedAddresses;
  
  Address? _selectedAddress;
  Address? get selectedAddress => _selectedAddress;
  
  String get getDeliveryAddress {
    if (_selectedAddress != null) {
      return _selectedAddress!.fullAddress; 
    }
    return _savedAddresses.isNotEmpty ? _savedAddresses.first.fullAddress : 'Select Address';
  }

  Future<void> loadAddresses() async {
    try {
      final data = await _addressApi.getAddresses();
      _savedAddresses = data.map((item) => Address.fromMap(item)).toList();
      
      if (_selectedAddress == null && _savedAddresses.isNotEmpty) {
        _selectedAddress = _savedAddresses.firstWhereOrNull((a) => a.icon == 'home') ?? _savedAddresses.first;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load addresses: $e');
    }
  }

  void updateDeliveryAddress(Address address) {
    _selectedAddress = address;
    notifyListeners();
  }
  
  Future<void> saveAddress(Address address) async {
    try {
      await _addressApi.createAddress({
        'label': address.title,
        'addressLine1': address.address,
        'city': 'New York', // Default for now
        'state': 'NY',
        'postalCode': '10001',
        'country': 'USA',
        'latitude': 40.7128,
        'longitude': -74.0060,
      });
      await loadAddresses();
    } catch (e) {
       debugPrint('Failed to save address: $e');
       rethrow;
    }
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

  Future<void> loadFavorites() async {
     // Placeholder for future API integration
     // _favorites = await _favoritesApi.getFavorites();
     notifyListeners();
  }

  // Users
  final List<AppUser> _users = [];
  List<AppUser> get getUsers => _users; 

  void addUser(String name, String email, String phoneNumber) {
    _users.add(AppUser(name: name, email: email, phoneNumber: phoneNumber));
    notifyListeners();
  }

  // Order Placement
  Future<void> placeOrder() async {
    if (_cart.isEmpty) return;
    
    _isLoading = true;
    notifyListeners();

    try {
      final List<Map<String, dynamic>> orderItems = _cart.map((item) {
        return {
          'menuItemId': item.food.id,
          'quantity': item.quantity,
          'addons': item.addOns.map((a) => a.id).where((id) => id != null).toList(),
        };
      }).toList();

      final restaurantId = _cart.first.food.restaurantId;
      
      if (restaurantId != null) {
        if (_selectedAddress == null || _selectedAddress!.id == null) {
          // If no address selected but we have saved addresses, use the first one
          if (_savedAddresses.isNotEmpty) {
             _selectedAddress = _savedAddresses.first;
          } else {
             throw 'Please select a delivery address';
          }
        }
        
        await _orderApi.createOrder(
          restaurantId: restaurantId,
          items: orderItems,
          deliveryAddressId: _selectedAddress!.id!, 
          paymentMethod: 'CASH',
        );
      }
      
      clearCart();
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

    await NotificationService.showNotification(
      id: notificationId,
      title: 'Order Placed!',
      body: 'Your order has been placed successfully.',
    );
    // ... further notifications if needed
  }
}

extension AddressHelper on Address {
  String get fullAddress => address;
}
