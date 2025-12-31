import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/address_tile.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class SavedAddressesPage extends StatefulWidget {
  const SavedAddressesPage({super.key});

  @override
  State<SavedAddressesPage> createState() => _SavedAddressesPageState();
}

class _SavedAddressesPageState extends State<SavedAddressesPage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _addresses = [
    {
      'title': 'Home',
      'address': '123 Maple Street, New York, NY 10001',
      'icon': Icons.home_rounded,
    },
    {
      'title': 'Work',
      'address': '456 Broadway, Suite 200, New York, NY 10013',
      'icon': Icons.work_rounded,
    },
    {
      'title': 'Gym',
      'address': '789 Fitness Way, Brooklyn, NY 11201',
      'icon': Icons.fitness_center_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Saved Addresses',
          style: AppTextStyles.h2.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ...Iterable.generate(_addresses.length).map((index) {
              final item = _addresses[index];
              return AddressTile(
                title: item['title'],
                address: item['address'],
                isSelected: _selectedIndex == index,
                icon: item['icon'],
                onTap: () => setState(() => _selectedIndex = index),
              );
            }),
            const SizedBox(height: 20),
            
            // Add New Address Button
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  width: 2,
                  style: BorderStyle.solid, // Note: dashed borders require a custom painter/package
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_location_alt_rounded, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    'Add New Address',
                    style: AppTextStyles.button.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Confirm Address'),
          ),
        ),
      ),
    );
  }
}
