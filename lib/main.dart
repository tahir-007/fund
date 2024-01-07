import 'package:flutter/material.dart';
import 'package:fund/src/screen/homePage.screen.dart';
import 'package:fund/src/service/connectivity.service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Provide the ConnectivityService to the entire app using ChangeNotifierProvider
      create: (context) => ConnectivityService(),
      child: MaterialApp(
        // Light theme configuration
        theme: ThemeData.light().copyWith(
          primaryColor:
              const Color.fromRGBO(37, 179, 150, 1), // Set the primary color
        ),
        // Dark theme configuration
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: const Color.fromRGBO(
              37, 179, 150, 1), // Set the primary color for dark theme
        ),
        // Theme mode set to follow the system's theme
        themeMode: ThemeMode.system,
        // Home page of the application
        home: const HomePage(),
      ),
    );
  }
}
