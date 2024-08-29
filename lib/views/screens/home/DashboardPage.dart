// ignore: file_names
import 'dart:ui'; // Import this for BackdropFilter
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wijungle_assignment/components/circular_Indicator_with_text.dart';
import 'package:wijungle_assignment/components/custom_routAnimation.dart';
import 'package:wijungle_assignment/components/custom_text.dart';
import 'package:wijungle_assignment/components/window_buttons.dart';
import 'package:wijungle_assignment/consts/colors.dart';
import 'package:wijungle_assignment/views/screens/login.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isProcessing = false;

  // Sign out function
  Future<void> signOut(BuildContext context) async {
    try {
      setState(() {
        isProcessing = true;
      });

      // Show the sign-out message for 2 seconds
      await Future.delayed(const Duration(seconds: 3));

      // Remove authentication status from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('isAuthenticated');

      // Navigate to the LoginScreen and remove all previous routes
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        CustomPageRoute(child: LoginScreen(), direction: AxisDirection.right),
        (route) => false,
      );
    } catch (e) {
      // Handle error
      print('Sign out error: $e');
      // Optionally show an error message to the user
    } finally {
      setState(() {
        isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              // Sidebar
              Container(
                width: 250,
                decoration: const BoxDecoration(
                  color: darkblue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        WindowTitleBarBox(
                          child: MoveWindow(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 20),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/logo/dashboardlogo.png',
                                width: 186,
                                height: 74,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Sidebar item for Analytics
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListTile(
                              leading: Image.asset(
                                  'assets/logo/ServerSquareUpdate.png'),
                              title: customText(
                                  'Analytics', FontWeight.w400, 20, darkblue),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Sidebar item for Feedback
                    ListTile(
                      leading: Image.asset('assets/logo/Dialog.png'),
                      title: customText('FEEDBACK', FontWeight.w400, 20, white),
                      onTap: () {},
                    ),
                    // Sign out button
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: const Icon(
                          Icons.login,
                          color: white,
                        ),
                        title:
                            customText('LOG OUT', FontWeight.w400, 20, white),
                        onTap: () {
                          signOut(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // Main Content
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      children: [
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
                        // App Bar with Minimize and Close Buttons
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 44, bottom: 20, left: 14, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customText(
                                  'Analytics', FontWeight.w400, 24, darkblue),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      customText('Hello', FontWeight.w400, 16,
                                          lightfontgrey),
                                      customText('User', FontWeight.w400, 20,
                                          darkblue),
                                    ],
                                  ),
                                  const SizedBox(width: 17),
                                  const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: white,
                                    backgroundImage: NetworkImage(
                                        'https://s3-alpha-sig.figma.com/img/94ff/2b8b/04c25540f9da370b7d63a79b383cf029?Expires=1725840000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=BvT7lV-gzDM12BrxtcG-I4kVegVUR28bPCngmK-mW6~xJ4xu1IOW5mcn0abG7cQlQ7UDQWmSmWTGYYVzQtybJD1-EArhZp-3VDjZRuIiHkwHn9JHnSPniR-l9bTUBgZ3dOou-QrZUsJXjNstChRJI412oERFbtlYzBnS7n3dBV0A3uD6c1SqcrI2N15D8kblUlIDiZ1-xZ9-GvYSikEHhi7KFeoglQdJME19SH~GWp0xZ7kEZwYmxdNvolXC0nTGkbjSJRnAwXllGenZhO3d0FMw6tQIyyg~MOPSxbIBoj15AYoZBF-9TfMkCTwP3Vgsp3IEpl2kfjM0DHN-0ySJVw__'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Main content area
                        const Expanded(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CircularIndicatorWithText(
                                    label: 'CPU', percentage: 76),
                                CircularIndicatorWithText(
                                    label: 'RAM', percentage: 76),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Loading overlay
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
