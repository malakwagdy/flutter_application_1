import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/DestinationsScreen.dart';

class WelcomeScreen extends StatelessWidget {
  final String name;
  const WelcomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.restaurant_menu, size: 80),
            Text(
              'Welcome, $name',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const Text('Your next review is awaiting'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Destinationsscreen()),
                );
              },
              child: Text('Browse Destinations'),
            ),
          ],
        ),
      ),
    );
  }
}
