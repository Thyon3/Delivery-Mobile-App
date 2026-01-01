class Address {
  final String? id;
  final String title;
  final String address;
  final String icon; // Icon name or string key

  Address({
    this.id,
    required this.title,
    required this.address,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'address': address,
      'icon': icon,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    // Handle backend response where fields might be different
    final label = map['label'] ?? map['title'] ?? 'Home';
    
    String fullAddress = map['address'] ?? '';
    if (fullAddress.isEmpty && map['addressLine1'] != null) {
      fullAddress = map['addressLine1'];
      if (map['city'] != null) fullAddress += ', ${map['city']}';
      if (map['state'] != null) fullAddress += ', ${map['state']}';
    }

    return Address(
      id: map['id'],
      title: label,
      address: fullAddress,
      icon: map['icon'] ?? _getIconForTitle(label),
    );
  }

  static String _getIconForTitle(String title) {
    switch (title.toLowerCase()) {
      case 'work':
        return 'work';
      case 'home':
        return 'home';
      default:
        return 'location_on';
    }
  }
}
