import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

enum OrderStatus { placed, confirmed, preparing, onTheWay, delivered }

class DeliveryStepper extends StatelessWidget {
  final OrderStatus currentStatus;

  const DeliveryStepper({
    super.key,
    required this.currentStatus,
  });

  int _getStatusIndex() {
    return OrderStatus.values.indexOf(currentStatus);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _getStatusIndex();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildStepItem(
            context,
            'Order Placed',
            Icons.receipt_long_rounded,
            0,
            currentIndex,
          ),
          _buildConnector(context, 0, currentIndex),
          _buildStepItem(
            context,
            'Order Confirmed',
            Icons.check_circle_outline_rounded,
            1,
            currentIndex,
          ),
          _buildConnector(context, 1, currentIndex),
          _buildStepItem(
            context,
            'Preparing',
            Icons.restaurant_rounded,
            2,
            currentIndex,
          ),
          _buildConnector(context, 2, currentIndex),
          _buildStepItem(
            context,
            'On the Way',
            Icons.delivery_dining_rounded,
            3,
            currentIndex,
          ),
          _buildConnector(context, 3, currentIndex),
          _buildStepItem(
            context,
            'Delivered',
            Icons.done_all_rounded,
            4,
            currentIndex,
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(
    BuildContext context,
    String title,
    IconData icon,
    int stepIndex,
    int currentIndex,
  ) {
    final isCompleted = stepIndex < currentIndex;
    final isActive = stepIndex == currentIndex;
    final isPending = stepIndex > currentIndex;

    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted || isActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            border: Border.all(
              color: isCompleted || isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Icon(
            isCompleted ? Icons.check_rounded : icon,
            color: isCompleted || isActive
                ? Colors.white
                : Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.bodyM.copyWith(
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isPending
                  ? Theme.of(context).colorScheme.onSurface.withOpacity(0.4)
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        if (isActive)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'In Progress',
              style: AppTextStyles.caption.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildConnector(
    BuildContext context,
    int stepIndex,
    int currentIndex,
  ) {
    final isCompleted = stepIndex < currentIndex;

    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 4, bottom: 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 2,
        height: 30,
        color: isCompleted
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary.withOpacity(0.2),
      ),
    );
  }
}
