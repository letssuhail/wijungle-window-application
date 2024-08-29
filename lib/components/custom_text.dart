import 'package:flutter/material.dart';

// Custom text widget to apply consistent styling
Widget customText(
    String text, // The text to display
    FontWeight fontweight, // The font weight (e.g., bold, normal)
    double fontsize, // The font size
    Color color // The text color
    ) {
  return Text(
    text, // The text content
    style: TextStyle(
        fontSize: fontsize, // Set the font size
        color: color, // Set the text color
        fontWeight: fontweight, // Set the font weight
        fontFamily: 'Aldrich' // Use the 'Aldrich' font family for the text
        ),
  );
}
