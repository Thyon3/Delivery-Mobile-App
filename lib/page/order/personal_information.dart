import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thydelivery_mobileapp/models/restaurant.dart';
import 'package:thydelivery_mobileapp/page/order/order_success_page.dart';
import 'package:thydelivery_mobileapp/components/my_button.dart';
import 'package:thydelivery_mobileapp/components/my_text_field.dart';
import 'package:thydelivery_mobileapp/services/database/firestore_service.dart';
import 'package:thydelivery_mobileapp/theme/app_text_styles.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  void finish() {
    // Save to Firestore
    FirestoreService db = FirestoreService();
    db.saveUsersToFirestore(
      nameController.text,
      emailController.text,
      numberController.text,
    );

    // Save to local model
    context.read<Restaurant>().addUser(
      nameController.text,
      emailController.text,
      numberController.text,
    );

    // Navigate to Success Page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const OrderSuccessPage()),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'User Details',
          style: AppTextStyles.h2.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Finalize your order',
              style: AppTextStyles.h3,
            ),
            const SizedBox(height: 8),
            Text(
              'Please provide your details for delivery.',
              style: AppTextStyles.bodyM.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 40),
            
            MyTextField(
              textEditingController: nameController,
              hintText: 'Full Name',
              obscureText: false,
              prefixIcon: Icons.person_outline_rounded,
            ),
            const SizedBox(height: 20),
            
            MyTextField(
              textEditingController: emailController,
              hintText: 'Email Address',
              obscureText: false,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: 20),
            
            MyTextField(
              textEditingController: numberController,
              hintText: 'Phone Number',
              obscureText: false,
              prefixIcon: Icons.phone_android_rounded,
            ),
            
            const SizedBox(height: 60),
            
            MyButton(
              onTap: finish,
              text: 'Complete Order',
            ),
          ],
        ),
      ),
    );
  }
}
