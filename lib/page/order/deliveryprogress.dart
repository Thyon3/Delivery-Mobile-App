import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/components/delivery_stepper.dart';
import 'package:thydelivery_mobileapp/components/live_tracking_map.dart';
import 'package:thydelivery_mobileapp/components/myreciet.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';
import 'package:thydelivery_mobileapp/services/database/firestore_service.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';
import 'dart:async';

class Deliveryprogress extends StatefulWidget {
  const Deliveryprogress({super.key});

  @override
  State<Deliveryprogress> createState() => _DeliveryprogressState();
}
class _DeliveryprogressState extends State<Deliveryprogress> {
  final FirestoreService db = FirestoreService();
  OrderStatus _currentStatus = OrderStatus.placed;

  @override
  void initState() {
    super.initState();
    _startStatusSimulation();
    // Save orders to firestore
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String orders = context.read<Restaurant>().userCartReciet();
      String currentAddress = context.read<Restaurant>().getDeliveryAddress;
      db.saveOrdersToFireStore(orders, currentAddress);
    });
  }

  void _startStatusSimulation() {
    Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => _currentStatus = OrderStatus.confirmed);
    });
    Timer(const Duration(seconds: 15), () {
      if (mounted) setState(() => _currentStatus = OrderStatus.preparing);
    });
    Timer(const Duration(seconds: 30), () {
      if (mounted) setState(() => _currentStatus = OrderStatus.onTheWay);
    });
    Timer(const Duration(seconds: 45), () {
      if (mounted) setState(() => _currentStatus = OrderStatus.delivered);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "Track Order",
          style: AppTextStyles.h2.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: _buildDriverInfo(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tracking Map
            const LiveTrackingMap(),
            
            const SizedBox(height: 30),

            // Order Status
            Text(
              'Order Status',
              style: AppTextStyles.h3.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
            DeliveryStepper(currentStatus: _currentStatus),

            const SizedBox(height: 30),

            // Reciept Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Details',
                  style: AppTextStyles.h3.copyWith(fontSize: 18),
                ),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      builder: (context) => DraggableScrollableSheet(
                        initialChildSize: 0.6,
                        maxChildSize: 0.9,
                        expand: false,
                        builder: (context, scrollController) => SingleChildScrollView(
                          controller: scrollController,
                          child: const Myreciet(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'View Receipt',
                    style: AppTextStyles.bodyS.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildOrderInfoRow(context, Icons.timer_outlined, 'Estimated Time', '25-30 mins'),
                  const Divider(height: 30),
                  _buildOrderInfoRow(context, Icons.location_on_outlined, 'Delivery Address', context.watch<Restaurant>().getDeliveryAddress),
                ],
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.caption),
              Text(value, style: AppTextStyles.bodyM.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDriverInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 40),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(35)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Driver Avatar
          CircleAvatar(
            radius: 28,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: const Icon(Icons.person_rounded, color: Colors.grey, size: 30),
          ),
          const SizedBox(width: 16),
          // Driver Details
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thyon Mengesha',
                  style: AppTextStyles.h3.copyWith(fontSize: 16),
                ),
                Text(
                  'Your Delivery Hero',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          // Actions
          _buildDriverAction(context, Icons.message_rounded, Colors.blue),
          const SizedBox(width: 12),
          _buildDriverAction(context, Icons.call_rounded, Colors.green),
        ],
      ),
    );
  }

  Widget _buildDriverAction(BuildContext context, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, color: color, size: 22),
      ),
    );
  }
}

