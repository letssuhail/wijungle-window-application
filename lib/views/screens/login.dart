import 'dart:convert';
import 'dart:ui';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wijungle_assignment/components/custom_button.dart';
import 'package:wijungle_assignment/components/custom_routAnimation.dart';
import 'package:wijungle_assignment/components/custom_textField.dart';
import 'package:wijungle_assignment/components/window_buttons.dart';
import 'package:wijungle_assignment/consts/colors.dart';
import 'package:wijungle_assignment/views/screens/home/DashboardPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers for username and password text fields
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // Variables to manage the state of the checkbox and processing indicator
  bool isChecked = false;
  bool isProcessing = false;

  // Method to handle login functionality
  void login(String username, String password) async {
    // URL for login API endpoint
    final url = Uri.parse(
        "https://mfatest.wijungle.com:9084/auth.php?type=login&username=testing&password=12345");

    try {
      // Show processing indicator
      setState(() {
        isProcessing = true;
      });

      // Perform HTTP GET request with username and password as query parameters
      final response = await http.get(
        url.replace(queryParameters: {
          'type': 'login',
          'username': username,
          'password': password,
        }),
      );

      // Print debug information about the request and response
      print('Request URL: ${response.request?.url}');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      // Decode response body
      final data = jsonDecode(response.body);

      // Check if response status is OK
      if (response.statusCode == 200) {
        if (data['status'] == 'success') {
          // Save login state to SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isAuthenticated', true);

          // Hide processing indicator and navigate to DashboardPage
          setState(() {
            isProcessing = false;
          });
          print('Login successful');
          Navigator.of(context)
              .pushReplacement(CustomPageRoute(child: DashboardPage()));
        } else {
          // Handle unsuccessful login
          print('Failed: ${data['errors']}');
          setState(() {
            isProcessing = false;
          });
        }
      } else {
        print('Error: ${response.statusCode}');
        setState(() {
          isProcessing = false;
        });
      }
    } catch (err) {
      // Handle any exceptions
      print('Exception: ${err.toString()}');
      setState(() {
        isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsive design
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                // Window title bar with move window functionality and custom window buttons
                WindowTitleBarBox(
                  child: Row(
                    children: [
                      Expanded(
                        child: MoveWindow(),
                      ),
                      const WindowButtons(),
                    ],
                  ),
                ),
                // Application logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Image.asset(
                        'assets/logo/logo.png',
                        width: 150,
                        height: 50,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Left side with login image
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              width: 680,
                              height: 498,
                              child: Image.asset(
                                'assets/images/loginimage.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        // Right side with login form
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: screenHeight * 0.02,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    'Let’s Secure Your PC',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 30,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                // Username text field
                                customTextField(
                                    labeltext: 'Username',
                                    keyboardtype: TextInputType.name,
                                    obscureText: false,
                                    controller: usernameController),
                                const SizedBox(height: 40),
                                // Password text field
                                customTextField(
                                    labeltext: 'Password',
                                    keyboardtype: TextInputType.name,
                                    obscureText: true,
                                    controller: passwordController),
                                const SizedBox(height: 40),
                                // Checkbox and terms text
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isChecked = value ?? false;
                                        });
                                      },
                                    ),
                                    const Expanded(
                                      child: Text(
                                        'By continuing, you agree to Terms & Conditions\nand Privacy Policy.',
                                        style: TextStyle(fontSize: 12),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40),
                                // Login button
                                SizedBox(
                                  height: 40,
                                  width: double.infinity,
                                  child: customButton(() {
                                    login(usernameController.text,
                                        passwordController.text);
                                  }, darkblue, 'Log In', 12, 10, white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Processing indicator overlay
          if (isProcessing)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      color: Colors.white,
                      size: 140,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
