import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:thydelivery_mobileapp/components/payment_method_tile.dart';
import 'package:thydelivery_mobileapp/page/order/personal_information.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PaymentPageState();
  }
}

class _PaymentPageState extends State<PaymentPage> {
  String _selectedPaymentMethod = 'card';
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCVVFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _proceedToDelivery() {
    if (_selectedPaymentMethod == 'card') {
      if (formKey.currentState!.validate()) {
        _showConfirmation();
      }
    } else {
      _showConfirmation();
    }
  }

  void _showConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Confirm Order',
          style: AppTextStyles.h3,
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Payment Method:',
                style: AppTextStyles.bodyM.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                _getPaymentMethodName(),
                style: AppTextStyles.bodyM,
              ),
              if (_selectedPaymentMethod == 'card') ...[
                const SizedBox(height: 12),
                Text(
                  'Card Details:',
                  style: AppTextStyles.bodyM.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text('Card: **** **** **** ${cardNumber.substring(cardNumber.length > 4 ? cardNumber.length - 4 : 0)}'),
                Text('Holder: $cardHolderName'),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.button.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PersonalInformation(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Confirm',
              style: AppTextStyles.button,
            ),
          ),
        ],
      ),
    );
  }

  String _getPaymentMethodName() {
    switch (_selectedPaymentMethod) {
      case 'card':
        return 'Credit/Debit Card';
      case 'cash':
        return 'Cash on Delivery';
      case 'wallet':
        return 'Digital Wallet';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Payment',
          style: AppTextStyles.h2.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Payment Method Selection
                  Text(
                    'Select Payment Method',
                    style: AppTextStyles.h3.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  
                  PaymentMethodTile(
                    title: 'Credit/Debit Card',
                    icon: Icons.credit_card_rounded,
                    isSelected: _selectedPaymentMethod == 'card',
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = 'card';
                      });
                    },
                  ),
                  
                  PaymentMethodTile(
                    title: 'Cash on Delivery',
                    icon: Icons.money_rounded,
                    isSelected: _selectedPaymentMethod == 'cash',
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = 'cash';
                      });
                    },
                  ),
                  
                  PaymentMethodTile(
                    title: 'Digital Wallet',
                    icon: Icons.account_balance_wallet_rounded,
                    isSelected: _selectedPaymentMethod == 'wallet',
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = 'wallet';
                      });
                    },
                  ),

                  // Card Details (only show if card is selected)
                  if (_selectedPaymentMethod == 'card') ...[
                    const SizedBox(height: 24),
                    Text(
                      'Card Details',
                      style: AppTextStyles.h3.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    CreditCardWidget(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCVVFocused,
                      onCreditCardWidgetChange: (creditCardBrand) {},
                      cardBgColor: Theme.of(context).colorScheme.primary,
                    ),
                    CreditCardForm(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      onCreditCardModelChange: (CreditCardModel data) {
                        setState(() {
                          cardNumber = data.cardNumber;
                          expiryDate = data.expiryDate;
                          cardHolderName = data.cardHolderName;
                          cvvCode = data.cvvCode;
                          isCVVFocused = data.isCvvFocused;
                        });
                      },
                      formKey: formKey,
                    ),
                  ],

                  if (_selectedPaymentMethod == 'cash') ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Please have exact change ready. Our delivery partner will collect payment upon delivery.',
                              style: AppTextStyles.bodyM,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  if (_selectedPaymentMethod == 'wallet') ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'You will be redirected to your digital wallet to complete the payment.',
                              style: AppTextStyles.bodyM,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Floating Button
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: _proceedToDelivery,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Continue',
                  style: AppTextStyles.button.copyWith(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


