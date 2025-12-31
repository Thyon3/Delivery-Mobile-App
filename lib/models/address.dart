class Address {
  final String title;
  final String address;
  final String icon; // Icon name or string key

  Address({
    required this.title,
    required this.address,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'address': address,
      'icon': icon,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      title: map['title'] ?? '',
      address: map['address'] ?? '',
      icon: map['icon'] ?? 'home',
    );
  }
}
