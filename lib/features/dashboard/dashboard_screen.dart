import 'package:flutter/material.dart';
import '../sales/sales_screen.dart';
// Main dashboard screen of MyanPOS.
//
// This screen contains the main actions that users will use
// to access different parts of the POS system.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top navigation bar of the dashboard.
      appBar: AppBar(
        title: const Text('MyanPOS'),
      ),

      // Main dashboard content.
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dashboard page heading.
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // First row of dashboard actions.
            Row(
              children: [
                Expanded(
                  child: _DashboardButton(
                    title: 'New Sale',
                    icon: Icons.point_of_sale,
                    // Open the Sales screen when the user taps New Sale.
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SalesScreen(),
                        ),
                      );
                    },
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

            // Second row of dashboard actions.
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

// Reusable button used by the dashboard.
//
// Keeping this widget separate means we can reuse the same
// button design for other dashboard actions later.
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