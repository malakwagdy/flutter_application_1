import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/Screens/BucketListScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const List<Map<String, String>> restaurants = [
//   {'title': 'The Alchemist', 'genre': 'Fiction'},
//   {'title': 'Dune', 'genre': 'Sci-fi'},
//   {'title': 'Atomic Habits', 'genre': 'Self-help'},
//   {'title': 'Sapiens', 'genre': 'History'},
//   {'title': 'The Hobbit', 'genre': 'Fantasy'},
// ];

class Destination {
  final String name;
  final String capital;
  final String region;
  final int population;
  final String flagUrl;
  bool isFavorite = false;

  Destination({
    required this.name,
    required this.capital,
    required this.region,
    required this.population,
    required this.flagUrl,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    String? capital = json['capital'];
    if (capital == null || capital.isEmpty) {
      capital = 'N/A';
    }
    final String code = json['alpha2Code'];

    return Destination(
      name: json['name'],
      capital: capital,
      region: json['region'],
      population: json['population'],
      flagUrl: 'https://flagcdn.com/w80/${code.toLowerCase()}.png',
    );
  }
}

class Destinationsscreen extends StatefulWidget {
  const Destinationsscreen({super.key});
  @override
  State<StatefulWidget> createState() => _DestinationState();
}

class _DestinationState extends State<Destinationsscreen> {
  List<Destination> destinations = [];
  Set<String> favoriteNames = {};
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();
  static const _favKey = 'favorite_destinations';

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    fetchDestinations();
  }

  void _toggleFavorite(String name) {
    setState(() {
      if (favoriteNames.contains(name)) {
        favoriteNames.remove(name);
      } else {
        favoriteNames.add(name);
      }
      _prefs.setStringList(_favKey, favoriteNames.toList());
    });
  }

  Future<void> _loadFavorites() async {
    final favorites = await _prefs.getStringList(_favKey) ?? [];
    setState(() {
      favoriteNames = favorites.toSet();
    });
  }

  Future<void> fetchDestinations() async {
    try {
      final response = await Dio().get(
        'https://countries.dev/countries?fields=name,capital,region,population,alpha2Code',
      );
      final List data = response.data as List;
      setState(() {
        destinations = data
            .map((e) => Destination.fromJson(e as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (destinations.isEmpty) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      body = ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final d = destinations[index];
          return Card(
            child: ListTile(
              leading: FlagImage(url: d.flagUrl),
              title: Text(d.name),
              subtitle: Text('${d.capital}, ${d.region}, ${d.population}'),
              trailing: IconButton(
                icon: favoriteNames.contains(d.name)
                    ? Icon(Icons.favorite, color: Colors.blueAccent)
                    : Icon(Icons.favorite_border),
                iconSize: 20,
                onPressed: () => _toggleFavorite(d.name),
              ),
            ),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Restaurants"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Bucketlistscreen(
                  savedDestinations: destinations
                      .where((d) => favoriteNames.contains(d.name))
                      .toList(),
                ),
              ),
            ),
            icon: Icon(Icons.bookmark),
          ),
        ],
      ),
      body: body,
    );
  }
}

class FlagImage extends StatelessWidget {
  final String url;
  final double width;
  FlagImage({super.key, required this.url, this.width = 40});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return SizedBox(
          width: width,
          height: width,
          child: const CircularProgressIndicator(strokeWidth: 2),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.flag_outlined);
      },
    );
  }
}
