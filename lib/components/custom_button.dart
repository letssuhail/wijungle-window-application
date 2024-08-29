import 'package:flutter/material.dart';
import 'package:wijungle_assignment/components/custom_text.dart';

// A custom button widget with configurable properties
Widget customButton(
  VoidCallback ontap, // Callback function for button press
  Color backgroundcolor, // Background color of the button
  String text, // Button text
  double fontsize, // Font size of the button text
  double radius, // Border radius of the button
  Color color, // Color of the button text
) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundcolor, // Set background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius), // Set border radius
      ),
    ),
    onPressed: ontap, // Set the callback for button press
    child: customText(text, FontWeight.w500, fontsize,
        color), // Custom text widget as button child
  );
}

// A rectangular button widget that uses TextButton and Card for styling
class RectangularButton extends StatelessWidget {
  // Constructor for RectangularButton
  const RectangularButton({
    super.key,
    required this.onPressed, // Callback function for button press
    required this.label, // Label text for the button
  });

  final VoidCallback? onPressed; // Optional callback for button press
  final String label; // Text label for the button

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, // Set the callback for button press
      child: Card(
        color: onPressed != null
            ? Colors.white24
            : null, // Conditional color based on onPressed
        child: Center(
          child: Text(
            label, // Button label text
            style: const TextStyle(
              letterSpacing: 2, // Letter spacing for the text
              fontSize: 25, // Font size of the text
              fontWeight: FontWeight.w400, // Font weight of the text
            ),
          ),
        ),
      ),
    );
  }
}
