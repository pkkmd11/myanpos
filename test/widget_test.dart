import 'package:flutter_test/flutter_test.dart';

// Import the MyanPOS application.
import 'package:myanpos/main.dart';

void main() {
  // Test that the MyanPOS dashboard loads correctly.
  testWidgets('MyanPOS dashboard displays correctly', (
    WidgetTester tester,
  ) async {
    // Start the MyanPOS application.
    await tester.pumpWidget(const MyanPOSApp());

    // Check that the application title is displayed.
    expect(find.text('MyanPOS'), findsOneWidget);

    // Check that the dashboard heading is displayed.
    expect(find.text('Dashboard'), findsOneWidget);

    // Check that the main POS actions are displayed.
    expect(find.text('New Sale'), findsOneWidget);
    expect(find.text('Products'), findsOneWidget);
    expect(find.text('Customers'), findsOneWidget);
    expect(find.text('Reports'), findsOneWidget);
  });
}