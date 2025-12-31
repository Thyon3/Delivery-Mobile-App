import 'package:flutter/material.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class PromoCodeInput extends StatefulWidget {
  final ValueChanged<String>? onApplyPromo;

  const PromoCodeInput({
    super.key,
    this.onApplyPromo,
  });

  @override
  State<PromoCodeInput> createState() => _PromoCodeInputState();
}

class _PromoCodeInputState extends State<PromoCodeInput> {
  final TextEditingController _controller = TextEditingController();
  bool _isApplied = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _applyPromo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _isApplied = true;
      });
      widget.onApplyPromo?.call(_controller.text);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Promo code "${_controller.text}" applied!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _removePromo() {
    setState(() {
      _isApplied = false;
      _controller.clear();
    });
    widget.onApplyPromo?.call('');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _isApplied 
            ? Colors.green 
            : Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          width: _isApplied ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            _isApplied ? Icons.check_circle_rounded : Icons.local_offer_rounded,
            color: _isApplied ? Colors.green : Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _controller,
              enabled: !_isApplied,
              decoration: InputDecoration(
                hintText: 'Enter promo code',
                hintStyle: AppTextStyles.bodyM.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              style: AppTextStyles.bodyM.copyWith(
                fontWeight: _isApplied ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          if (_isApplied)
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: _removePromo,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            )
          else
            ElevatedButton(
              onPressed: _applyPromo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                elevation: 0,
              ),
              child: Text(
                'Apply',
                style: AppTextStyles.button.copyWith(fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }
}
