import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable()
class Food {
  final String? id; // Backend ID
  final String name;
  final String description;
  final double price;
  @JsonKey(name: 'image')
  final String imagePath;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Category category; // We'll handle mapping manually or separately
  @JsonKey(name: 'addons')
  List<AddOns> availableAddOns;
  
  // Extra backend fields
  final String? restaurantId;
  final bool isAvailable;
  
  @JsonKey(ignore: true)
  List<dynamic> reviews; // Temp fix for UI compatibility

  Food({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.category = Category.burger,
    required this.availableAddOns,
    this.restaurantId,
    this.isAvailable = true,
    this.reviews = const [],
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    // Custom mapping for Category if needed, or stick to default
    final food = _$FoodFromJson(json);
    // Simple logic to assign random category if backend doesn't send enum compatible string
    // Ideally backend sends 'categoryId' or 'category' object.
    return food;
  }
  
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}

enum Category { burger, sides, drink, desserts, salad }

@JsonSerializable()
class AddOns {
  final String? id;
  final String name;
  final double price;

  AddOns({
    this.id, 
    required this.name, 
    required this.price
  });

  factory AddOns.fromJson(Map<String, dynamic> json) => _$AddOnsFromJson(json);
  Map<String, dynamic> toJson() => _$AddOnsToJson(this);
}

