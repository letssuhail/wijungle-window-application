// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// CustomPageRoute defines a custom page transition route with slide effects
class CustomPageRoute extends PageRouteBuilder {
  final Widget child; // The widget to be displayed for this route
  final AxisDirection direction; // The direction of the slide transition

  // Constructor for CustomPageRoute
  CustomPageRoute({
    required this.child, // Required child widget
    this.direction = AxisDirection.right, // Default transition direction
  }) : super(
          // Duration for both forward and reverse transitions
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 400),
          // The pageBuilder callback that builds the page for this route
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  // Build the transition animations for this route
  Widget buildTransitions(
      BuildContext context, // Build context of the route
      Animation<double> animation, // Animation for the transition
      Animation<double>
          secondaryAnimation, // Animation for the secondary route (e.g., when navigating back)
      Widget child // The child widget to transition in
      ) {
    // Use SlideTransition to animate the slide effect
    return SlideTransition(
      position: Tween<Offset>(
        begin: getBeginOffset(), // Offset where the animation starts
        end: Offset.zero, // Offset where the animation ends
      ).animate(animation), // Apply the animation to the Tween
      child: child, // The widget to be transitioned
    );
  }

  // Determine the starting offset based on the direction of the slide
  Offset getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, 1); // Slide from bottom to top
      case AxisDirection.down:
        return const Offset(0, -1); // Slide from top to bottom
      case AxisDirection.right:
        return const Offset(-1, 0); // Slide from left to right
      case AxisDirection.left:
        return const Offset(1, 0); // Slide from right to left
    }
  }
}
