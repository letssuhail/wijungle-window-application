import 'package:flutter/material.dart';
import 'package:wijungle_assignment/consts/colors.dart';

// Custom text field widget with styling
Widget customTextField({
  required String
      labeltext, // The text to display as the label of the text field
  required TextInputType
      keyboardtype, // Type of keyboard to display (e.g., text, number)
  required bool
      obscureText, // Whether to obscure text (e.g., for password fields)
  required TextEditingController
      controller, // Controller to manage the text input
}) {
  return Column(
    crossAxisAlignment:
        CrossAxisAlignment.start, // Align the column's children to the start
    children: [
      TextField(
        controller:
            controller, // Set the controller for managing the text field
        autofocus: false, // Do not autofocus the text field
        keyboardType: keyboardtype, // Set the keyboard type
        obscureText: obscureText, // Whether to obscure the text
        decoration: InputDecoration(
          labelStyle: const TextStyle(color: black), // Style for the label text
          labelText: labeltext, // The label text for the text field
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: black), // Color of the border
            borderRadius: BorderRadius.circular(10), // Border radius
          ),
        ),
      ),
    ],
  );
}
