// lib/widgets/action_button.dart

import 'package:flutter/material.dart';

/// Reusable ActionButton Widget for different actions.
class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const ActionButton({
    super.key,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve screen dimensions for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          width: screenWidth * 0.6,
          height: isPrimary ? screenHeight * 0.054 : screenHeight * 0.04,
          decoration: BoxDecoration(
            color: isPrimary
                ? const Color.fromRGBO(40, 16, 191, 1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
            border: isPrimary
                ? null
                : Border.all(
                    color: const Color.fromRGBO(40, 16, 191, 0.5), width: 0.5),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isPrimary
                    ? Colors.white
                    : const Color.fromARGB(195, 0, 0, 0),
                fontSize: screenWidth * 0.04,
                fontWeight: isPrimary ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
