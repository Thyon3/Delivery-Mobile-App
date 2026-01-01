import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/page/profile/support_chat_page.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';
import 'package:thydelivery_mobileapp/theme/design_system.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = _faqCategories;

    final query = _searchController.text.trim().toLowerCase();
    final filteredCategories = query.isEmpty
        ? categories
        : categories
            .map((c) => c.copyWith(
                  items: c.items
                      .where((i) =>
                          i.question.toLowerCase().contains(query) ||
                          i.answer.toLowerCase().contains(query))
                      .toList(),
                ))
            .where((c) => c.items.isNotEmpty)
            .toList();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Help Center',
          style: AppTextStyles.h2.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DesignSystem.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How can we help?',
                style: AppTextStyles.h3.copyWith(fontSize: 18),
              ),
              const SizedBox(height: DesignSystem.paddingM),
              _SearchField(controller: _searchController, onChanged: (_) => setState(() {})),
              const SizedBox(height: DesignSystem.paddingL),
              Text(
                'Frequently Asked Questions',
                style: AppTextStyles.h3.copyWith(fontSize: 18),
              ),
              const SizedBox(height: DesignSystem.paddingM),

              if (filteredCategories.isEmpty)
                _EmptyState(query: _searchController.text)
              else
                ...filteredCategories.map(
                  (category) => Padding(
                    padding: const EdgeInsets.only(bottom: DesignSystem.paddingL),
                    child: _FaqCategorySection(category: category),
                  ),
                ),

              const SizedBox(height: DesignSystem.paddingS),
              Text(
                'Still need help?',
                style: AppTextStyles.h3.copyWith(fontSize: 18),
              ),
              const SizedBox(height: DesignSystem.paddingM),
              _SupportCard(
                onChat: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SupportChatPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(DesignSystem.radiusL),
        boxShadow: DesignSystem.softShadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: DesignSystem.paddingM),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search questionsâ€¦',
          hintStyle: AppTextStyles.bodyM.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.45),
          ),
          icon: Icon(
            Icons.search_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          suffixIcon: controller.text.trim().isEmpty
              ? null
              : IconButton(
                  tooltip: 'Clear',
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                  icon: Icon(
                    Icons.close_rounded,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
        ),
      ),
    );
  }
}

class _FaqCategorySection extends StatelessWidget {
  final FaqCategory category;

  const _FaqCategorySection({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(category.icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: DesignSystem.paddingS),
            Text(
              category.title,
              style: AppTextStyles.bodyM.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: DesignSystem.paddingS),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(DesignSystem.radiusL),
            boxShadow: DesignSystem.softShadow,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(DesignSystem.radiusL),
            child: ExpansionPanelList.radio(
              elevation: 0,
              expandedHeaderPadding: EdgeInsets.zero,
              animationDuration: const Duration(milliseconds: 200),
              children: [
                for (final item in category.items)
                  ExpansionPanelRadio(
                    value: item.id,
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DesignSystem.paddingM,
                          vertical: DesignSystem.paddingM,
                        ),
                        child: Text(
                          item.question,
                          style: AppTextStyles.bodyM.copyWith(fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                    body: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        DesignSystem.paddingM,
                        0,
                        DesignSystem.paddingM,
                        DesignSystem.paddingM,
                      ),
                      child: Text(
                        item.answer,
                        style: AppTextStyles.bodyM.copyWith(
                          height: 1.4,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.72),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SupportCard extends StatelessWidget {
  final VoidCallback onChat;

  const _SupportCard({required this.onChat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignSystem.paddingL),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.10),
        borderRadius: BorderRadius.circular(DesignSystem.radiusL),
      ),
      child: Row(
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: DesignSystem.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chat with Support',
                  style: AppTextStyles.bodyM.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  'Typical response time: 2 mins',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onChat,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DesignSystem.radiusM),
              ),
            ),
            child: const Text('Chat'),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String query;

  const _EmptyState({required this.query});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(DesignSystem.paddingL),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(DesignSystem.radiusL),
        boxShadow: DesignSystem.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No results found',
            style: AppTextStyles.bodyM.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: DesignSystem.paddingS),
          Text(
            'Try a different keyword, or contact support.',
            style: AppTextStyles.bodyM.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          if (query.trim().isNotEmpty) ...[
            const SizedBox(height: DesignSystem.paddingM),
            Text(
              'Search: "$query"',
              style: AppTextStyles.caption.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.55),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

@immutable
class FaqItem {
  final String id;
  final String question;
  final String answer;

  const FaqItem({required this.id, required this.question, required this.answer});
}

@immutable
class FaqCategory {
  final String id;
  final String title;
  final IconData icon;
  final List<FaqItem> items;

  const FaqCategory({
    required this.id,
    required this.title,
    required this.icon,
    required this.items,
  });

  FaqCategory copyWith({List<FaqItem>? items}) {
    return FaqCategory(
      id: id,
      title: title,
      icon: icon,
      items: items ?? this.items,
    );
  }
}

const List<FaqCategory> _faqCategories = [
  FaqCategory(
    id: 'orders',
    title: 'Orders & Tracking',
    icon: Icons.local_shipping_outlined,
    items: [
      FaqItem(
        id: 'track_order',
        question: 'How do I track my order?',
        answer:
            'You can track your order in real-time by tapping "Track Order" on the order confirmation screen or from "My Orders".',
      ),
      FaqItem(
        id: 'cancel_order',
        question: 'Can I cancel my order?',
        answer:
            'Orders can usually be cancelled within a few minutes of placement. After preparation begins, cancellation may not be possible.',
      ),
    ],
  ),
  FaqCategory(
    id: 'delivery',
    title: 'Delivery',
    icon: Icons.access_time_rounded,
    items: [
      FaqItem(
        id: 'delivery_hours',
        question: 'What are the delivery hours?',
        answer:
            'Most restaurant partners deliver from 10:00 AM to 11:00 PM. Hours can vary by restaurant and location.',
      ),
      FaqItem(
        id: 'late_delivery',
        question: 'What if my delivery is late?',
        answer:
            'If your order is delayed, check tracking for live updates. You can also contact support from this page for assistance.',
      ),
    ],
  ),
  FaqCategory(
    id: 'payments',
    title: 'Payments & Promos',
    icon: Icons.payments_outlined,
    items: [
      FaqItem(
        id: 'apply_promo',
        question: 'How do I apply a promo code?',
        answer:
            'Enter your promo code in the cart before checkout, then tap "Apply" to see the discount reflected in your total.',
      ),
      FaqItem(
        id: 'payment_failed',
        question: 'My payment failed â€” what should I do?',
        answer:
            'Try again with a different payment method, ensure your card details are correct, or contact your bank if the issue persists.',
      ),
    ],
  ),
];

