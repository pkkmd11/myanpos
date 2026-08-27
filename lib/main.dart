import 'package:flutter/material.dart';

// Import the dashboard screen from the dashboard feature.
import 'features/dashboard/dashboard_screen.dart';

// Application entry point.
void main() {
  runApp(const MyanPOSApp());
}

// Root widget of the MyanPOS application.
class MyanPOSApp extends StatelessWidget {
  const MyanPOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name.
      title: 'MyanPOS',

      // Hide Flutter's debug banner.
      debugShowCheckedModeBanner: false,

      // Use Material 3 components.
      theme: ThemeData(
        useMaterial3: true,
      ),

      // Start the application with the dashboard.
      home: const DashboardScreen(),
    );
  }
}