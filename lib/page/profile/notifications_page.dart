import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mockNotifications = [
      {
        'title': 'Order Delivered!',
        'body': 'Your order #THY7892 has been delivered. Enjoy your meal!',
        'time': '2 mins ago',
        'isRead': false,
        'icon': Icons.delivery_dining_rounded,
        'color': Colors.green,
      },
      {
        'title': 'Special Offer ðŸŽ',
        'body': 'Get 50% OFF on your next burger order. Use code BURGER50.',
        'time': '1 hour ago',
        'isRead': false,
        'icon': Icons.local_offer_rounded,
        'color': Colors.orange,
      },
      {
        'title': 'Order Confirmed',
        'body': 'Restaurant has started preparing your order #THY7845.',
        'time': '2 hours ago',
        'isRead': true,
        'icon': Icons.restaurant_rounded,
        'color': Colors.blue,
      },
      {
        'title': 'Payment Success',
        'body': 'Your payment for #THY7845 was successful.',
        'time': '2 hours ago',
        'isRead': true,
        'icon': Icons.payment_rounded,
        'color': Colors.purple,
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: AppTextStyles.h2.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Mark all as read'),
          ),
        ],
      ),
      body: mockNotifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none_rounded,
                    size: 80,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: AppTextStyles.h3,
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: mockNotifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final notification = mockNotifications[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: notification['isRead'] as bool
                        ? Theme.of(context).colorScheme.surface.withOpacity(0.5)
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: notification['isRead'] as bool
                        ? null
                        : Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.1), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: (notification['color'] as Color).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          notification['icon'] as IconData,
                          color: notification['color'] as Color,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  notification['title'] as String,
                                  style: AppTextStyles.bodyM.copyWith(
                                    fontWeight: notification['isRead'] as bool ? FontWeight.normal : FontWeight.bold,
                                  ),
                                ),
                                if (!(notification['isRead'] as bool))
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notification['body'] as String,
                              style: AppTextStyles.bodyS.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              notification['time'] as String,
                              style: AppTextStyles.caption.copyWith(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

