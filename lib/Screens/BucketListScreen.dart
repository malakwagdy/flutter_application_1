import 'package:flutter/material.dart';
import 'DestinationsScreen.dart';

class Bucketlistscreen extends StatelessWidget {
  final List<Destination> savedDestinations;

  const Bucketlistscreen({super.key, required this.savedDestinations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Bucket List")),
      body: ListView.builder(
        itemCount: savedDestinations.length,
        itemBuilder: (context, index) {
          final d = savedDestinations[index];
          return Card(
            child: ListTile(
              leading: FlagImage(url: d.flagUrl),
              title: Text(d.name),
              subtitle: Text('${d.capital}, ${d.region}, ${d.population}'),
            ),
          );
        },
      ),
    );
  }
}
