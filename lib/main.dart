import 'package:flutter/material.dart';

// The entry point of the MyanPOS application.
// Flutter starts the app from this function.
void main() {
  runApp(const MyanPOSApp());
}

// The root widget of our MyanPOS application.
class MyanPOSApp extends StatelessWidget {
  const MyanPOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name.
      title: 'MyanPOS',

      // Hide the debug banner shown by Flutter.
      debugShowCheckedModeBanner: false,

      // The first screen displayed when the app starts.
      home: Scaffold(
        // Top navigation bar of the application.
        appBar: AppBar(
          title: const Text('MyanPOS'),
        ),

        // Main content of the first screen.
        body: const Center(
          child: Text(
            'Welcome to MyanPOS',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}