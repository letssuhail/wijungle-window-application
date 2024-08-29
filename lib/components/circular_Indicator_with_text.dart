// Circular progress indicator with percentage and label
import 'package:flutter/material.dart';
import 'package:wijungle_assignment/components/custom_text.dart';

class CircularIndicatorWithText extends StatelessWidget {
  final double percentage;
  final String label;
  final Color blue = Colors.blue;
  final Color black = Colors.black;

  const CircularIndicatorWithText({
    super.key,
    required this.percentage,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 180,
              width: 180,
              child: CircularProgressIndicator(
                color: blue,
                value: percentage / 100,
                strokeWidth: 25,
                backgroundColor: Colors.grey[300],
              ),
            ),
            Positioned(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: customText(
                      '$percentage%',
                      FontWeight.w600,
                      20,
                      black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: customText(
                      label,
                      FontWeight.w400,
                      22,
                      black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
