import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:thydelivery_mobileapp/page/profile/help_center_page.dart';

void main() {
  testWidgets('HelpCenterPage renders FAQ sections', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HelpCenterPage(),
      ),
    );

    expect(find.text('Help Center'), findsOneWidget);
    expect(find.text('Frequently Asked Questions'), findsOneWidget);

    // At least one category title should be visible.
    expect(find.text('Orders & Tracking'), findsOneWidget);

    // Search field should exist.
    expect(find.byType(TextField), findsOneWidget);
  });
}
