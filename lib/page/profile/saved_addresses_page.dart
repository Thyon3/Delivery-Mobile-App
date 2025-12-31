import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/components/address_tile.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';
import 'package:thydelivery_mobileapp/models/address.dart';
import 'package:thydelivery_mobileapp/services/database/firestore_service.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class SavedAddressesPage extends StatefulWidget {
  const SavedAddressesPage({super.key});

  @override
  State<SavedAddressesPage> createState() => _SavedAddressesPageState();
}

class _SavedAddressesPageState extends State<SavedAddressesPage> {
  int _selectedIndex = 0;

  void _showAddAddressDialog() {
    final titleController = TextEditingController();
    final addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Address', style: AppTextStyles.h3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title (e.g. Home, Work)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Full Address'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && addressController.text.isNotEmpty) {
                final newAddress = Address(
                  title: titleController.text,
                  address: addressController.text,
                  icon: 'location_on',
                );
                Provider.of<Restaurant>(context, listen: false).addAddress(newAddress);
                FirestoreService().saveAddressToFirestore(newAddress);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home': return Icons.home_rounded;
      case 'work': return Icons.work_rounded;
      case 'fitness': return Icons.fitness_center_rounded;
      default: return Icons.location_on_rounded;
    }
  }

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
      body: Consumer<Restaurant>(
        builder: (context, restaurant, child) {
          final addresses = restaurant.savedAddresses;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ...Iterable.generate(addresses.length).map((index) {
                  final item = addresses[index];
                  return AddressTile(
                    title: item.title,
                    address: item.address,
                    isSelected: _selectedIndex == index,
                    icon: _getIconData(item.icon),
                    onTap: () => setState(() => _selectedIndex = index),
                  );
                }),
                const SizedBox(height: 20),
                
                // Add New Address Button
                OutlinedButton(
                  onPressed: _showAddAddressDialog,
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
          );
        },
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
