import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Screens/DestinationsScreen.dart';
import 'package:flutter_application_1/Screens/SignupScreen.dart';

void main() {
  runApp(const WanderlyApp());
}

class WanderlyApp extends StatefulWidget {
  const WanderlyApp({super.key});
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(home: StartScreen(), debugShowCheckedModeBanner: false);
  // }

  @override
  State<StatefulWidget> createState() => _WanderlyAppState();
}

class _WanderlyAppState extends State<WanderlyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.dark,
        ),
      ),
      home: StartScreen(onToggleTheme: _toggleTheme),
      // home: Signupscreen(),
      debugShowCheckedModeBanner: false,
    );
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? _themeMode = ThemeMode.dark
          : _themeMode = ThemeMode.light;
    });
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key, required this.onToggleTheme});
  final VoidCallback onToggleTheme;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(child: Icon(Icons.restaurant_menu)),
            Text(
              "Wanderly",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Text("Reviews at a touch!", style: TextStyle(color: Colors.white)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signupscreen()),
                );
              },
              child: Text("Start Exploring"),
            ),
            TextButton(
              onPressed: onToggleTheme,
              child: Text(
                "Toggle Theme",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
