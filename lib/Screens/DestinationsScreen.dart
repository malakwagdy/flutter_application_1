import 'package:flutter/material.dart';

const List<Map<String, String>> restaurants = [
  {'title': 'The Alchemist', 'genre': 'Fiction'},
  {'title': 'Dune', 'genre': 'Sci-fi'},
  {'title': 'Atomic Habits', 'genre': 'Self-help'},
  {'title': 'Sapiens', 'genre': 'History'},
  {'title': 'The Hobbit', 'genre': 'Fantasy'},
];

class Destinationsscreen extends StatelessWidget {
  const Destinationsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Explore Restaurants")),
      body: ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: Text(restaurant['title']!),
              subtitle: Text(restaurant['genre']!),
            ),
          );
        },
      ),
    );
  }
}
