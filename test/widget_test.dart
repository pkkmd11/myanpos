import 'package:flutter_test/flutter_test.dart';

// Import the MyanPOS application from our main.dart file.
import 'package:myanpos/main.dart';

void main() {
  // Test that the MyanPOS application starts successfully.
  testWidgets('MyanPOS displays the welcome message', (WidgetTester tester) async {
    // Start the MyanPOS application.
    await tester.pumpWidget(const MyanPOSApp());

    // Check that the application displays "Welcome to MyanPOS".
    expect(
      find.text('Welcome to MyanPOS'),
      findsOneWidget,
    );

    // Check that the application title is displayed.
    expect(
      find.text('MyanPOS'),
      findsOneWidget,
    );
  });
}