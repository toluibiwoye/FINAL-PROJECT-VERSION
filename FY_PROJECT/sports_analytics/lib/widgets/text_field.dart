import 'package:flutter/material.dart';

import '../constants.dart';

// CustomTextField is a StatelessWidget for creating a styled text input field.
class CustomTextField extends StatelessWidget {
  // Constructor for the CustomTextField widget.
  const CustomTextField({
    Key? key,
    required this.hintText,        // The hint text for the input field.
    required this.inputType,       // The type of keyboard input to display.
    required this.controller,      // The controller to manipulate the text input.
    required this.errorText,        // The error text to display if validation fails.
  }) : super(key: key);

  final String hintText;           // The hint text for the input field.
  final TextInputType inputType;  // The type of keyboard input to display.
  final TextEditingController controller;  // The controller to manipulate the text input.
  final String? errorText;         // The error text to display if validation fails.

  @override
  Widget build(BuildContext context) {
    // Padding widget for adding vertical space around the TextField.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      // TextField widget for user text input.
      child: TextField(
        // Styling for the text input.
        style: kBodyText.copyWith(color: Colors.white),
        // Specifies the type of keyboard input to use.
        keyboardType: inputType,
        // Specifies the type of action that the keyboard should take.
        textInputAction: TextInputAction.next,
        // Controller for manipulating the text input.
        controller: controller,
        // Decoration for the input field, including hints, error messages, and borders.
        decoration: InputDecoration(
          // Padding around the content of the input field.
          contentPadding: const EdgeInsets.all(20),
          // Hint text to display when the input field is empty.
          hintText: hintText,
          // Styling for the hint text.
          hintStyle: kBodyText,
          // Error text to display if validation fails.
          errorText: errorText,
          // Styling for the error text.
          errorStyle: const TextStyle(color: Colors.red),
          // Border and styling when the input field is not focused.
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          // Border and styling when the input field is focused.
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
