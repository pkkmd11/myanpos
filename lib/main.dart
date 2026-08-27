import 'package:flutter/material.dart';

// Application entry point.
// Flutter starts the MyanPOS application from here.
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

      // Remove Flutter's debug banner.
      debugShowCheckedModeBanner: false,

      // Use Material 3 design components.
      theme: ThemeData(
        useMaterial3: true,
      ),

      // First screen of the application.
      home: const HomeScreen(),
    );
  }
}

// Main dashboard screen of MyanPOS.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top navigation bar.
      appBar: AppBar(
        title: const Text('MyanPOS'),
      ),

      // Main dashboard content.
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dashboard heading.
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // Basic POS action buttons.
            Row(
              children: [
                Expanded(
                  child: _DashboardButton(
                    title: 'New Sale',
                    icon: Icons.point_of_sale,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DashboardButton(
                    title: 'Products',
                    icon: Icons.inventory_2,
                    onPressed: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _DashboardButton(
                    title: 'Customers',
                    icon: Icons.people,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DashboardButton(
                    title: 'Reports',
                    icon: Icons.bar_chart,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable dashboard button.
// Keeping this as a separate widget will make the UI easier to maintain
// when we add more features later.
class _DashboardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const _DashboardButton({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(title),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.all(20),
      ),
    );
  }
}