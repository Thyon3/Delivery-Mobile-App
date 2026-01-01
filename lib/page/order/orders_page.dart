import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/components/order_history_tile.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for order history
    final mockOrders = [
      {
        'id': '#THY7892',
        'date': 'Oct 12, 2023 â€¢ 12:45 PM',
        'amount': 42.50,
        'status': 'Delivered',
        'items': ['Cheese Burger', 'French Fries', 'Coca Cola'],
      },
      {
        'id': '#THY7845',
        'date': 'Oct 10, 2023 â€¢ 07:15 PM',
        'amount': 28.00,
        'status': 'Processing',
        'items': ['Pepperoni Pizza', 'Garlic Bread'],
      },
      {
        'id': '#THY7712',
        'date': 'Oct 05, 2023 â€¢ 01:20 PM',
        'amount': 15.75,
        'status': 'Cancelled',
        'items': ['Veggie Wrap', 'Orange Juice'],
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: AppTextStyles.h2.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: mockOrders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history_rounded,
                    size: 80,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No orders yet',
                    style: AppTextStyles.h3,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: mockOrders.length,
              itemBuilder: (context, index) {
                final order = mockOrders[index];
                return OrderHistoryTile(
                  orderId: order['id'] as String,
                  date: order['date'] as String,
                  amount: order['amount'] as double,
                  status: order['status'] as String,
                  items: order['items'] as List<String>,
                  onTap: () {
                    // Navigate to order details
                    _showOrderDetails(context, order);
                  },
                );
              },
            ),
    );
  }

  void _showOrderDetails(BuildContext context, Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ${order['id']}',
                  style: AppTextStyles.h2,
                ),
                TextButton(
                  onPressed: () => _showRatingModal(context),
                  child: Text(
                    'Rate Now',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(order['date'] as String, style: AppTextStyles.caption),
            const SizedBox(height: 24),
            Text('Items', style: AppTextStyles.h3.copyWith(fontSize: 16)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: (order['items'] as List).length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text((order['items'] as List)[index], style: AppTextStyles.bodyM),
                        Text('1x', style: AppTextStyles.caption),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(thickness: 1.5),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount', style: AppTextStyles.h3),
                Text('\$${(order['amount'] as double).toStringAsFixed(2)}', style: AppTextStyles.h2.copyWith(color: Theme.of(context).colorScheme.primary)),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text('Back to History'),
            ),
          ],
        ),
      ),
    );
  }

  void _showRatingModal(BuildContext context) {
    int rating = 0;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(child: Text('Rate your Meal', style: AppTextStyles.h3)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('How was the food and delivery?', textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => setState(() => rating = index + 1),
                    child: Icon(
                      index < rating ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: Colors.amber,
                      size: 40,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Share your thoughts...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Later'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Thank you for your feedback!')),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

