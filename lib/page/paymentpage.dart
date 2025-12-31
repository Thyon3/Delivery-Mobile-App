import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:thydelivery_mobileapp/components/my_button.dart';
import 'package:thydelivery_mobileapp/page/deliveryprogress.dart';
import 'package:thydelivery_mobileapp/page/personal_information.dart';

class PaymentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaymentPageState();
  }
}

class _PaymentPageState extends State<PaymentPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCVVFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void payNow() {
    //only show dialog if the form is valid
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Confirm your payment'),

              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text('Card Number: $cardNumber'),
                    Text('Expiry Date: $expiryDate'),
                    Text('Cvv: $cvvCode'),
                    Text('Card Holder Name: $cardHolderName'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonalInformation(),
                      ),
                    );
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chekout')),
      body: Column(
        children: [
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCVVFocused,
            onCreditCardWidgetChange: (creditCardBrand) {
              // Update the UI based on the card brand if needed
            },
          ),
          CreditCardForm(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            onCreditCardModelChange: (CreditCardModel data) {
              cardNumber = data.cardNumber;
              expiryDate = data.expiryDate;
              cardHolderName = data.cardHolderName;
              cvvCode = data.cvvCode;
              isCVVFocused = data.isCvvFocused;
            },
            formKey: formKey,
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: MyButton(onTap: payNow, text: 'Pay Now'),
          ),
        ],
      ),
    );
  }
}
