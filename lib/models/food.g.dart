// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
  id: json['id'] as String?,
  name: json['name'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toDouble(),
  imagePath: json['image'] as String,
  availableAddOns:
      (json['addons'] as List<dynamic>)
          .map((e) => AddOns.fromJson(e as Map<String, dynamic>))
          .toList(),
  restaurantId: json['restaurantId'] as String?,
  isAvailable: json['isAvailable'] as bool? ?? true,
);

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'image': instance.imagePath,
  'addons': instance.availableAddOns,
  'restaurantId': instance.restaurantId,
  'isAvailable': instance.isAvailable,
};

AddOns _$AddOnsFromJson(Map<String, dynamic> json) => AddOns(
  id: json['id'] as String?,
  name: json['name'] as String,
  price: (json['price'] as num).toDouble(),
);

Map<String, dynamic> _$AddOnsToJson(AddOns instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
};
