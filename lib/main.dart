import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:wijungle_assignment/consts/colors.dart';
import 'package:wijungle_assignment/views/screens/login.dart';
import 'package:wijungle_assignment/views/screens/home/DashboardPage.dart';

void main() async {
  // Ensure Flutter binding is initialized before calling runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Set up custom HTTP client to ignore bad certificates
  HttpOverrides.global = MyHttpOverrides();

  // Retrieve authentication status from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final isAuthenticated = prefs.getBool('isAuthenticated') ?? false;

  // Pass the authentication status to the app
  runApp(MyApp(isAuthenticated: isAuthenticated));

  // Configure window properties for supported platforms (Windows, Linux, macOS)
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    doWhenWindowReady(() {
      // Center the app window
      appWindow.alignment = Alignment.center;

      // Set minimum and maximum window size
      appWindow.minSize = Size(900, 650); // Minimum size
      appWindow.maxSize = Size(1920, 1080); // Maximum size

      // Set default window size
      appWindow.size = Size(1280, 720);
      appWindow.show();
    });
  }
}

// Custom HttpOverrides to bypass bad certificate validation
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    // Allow all certificates (insecure; only for development)
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

// Main application widget
class MyApp extends StatelessWidget {
  final bool isAuthenticated;

  const MyApp({super.key, required this.isAuthenticated});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      title: 'Flutter Demo',
      // Decide which screen to show based on authentication status
      home: isAuthenticated
          ? Scaffold(
              body: WindowBorder(
              color: lightfontgrey,
              child: const DashboardPage(),
            ))
          : Scaffold(
              body: WindowBorder(
              color: lightfontgrey,
              child: const LoginScreen(),
            )),
    );
  }
}
