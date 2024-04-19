import 'package:flutter/material.dart';
import '../constants.dart';

// CustomPasswordField is a StatelessWidget for creating a styled password input field.
class CustomPasswordField extends StatelessWidget {
  // Constructor for the CustomPasswordField widget.
  const CustomPasswordField({
    Key? key,
    required this.isPasswordVisible,   // Determines whether the password is visible or hidden.
    required this.onTap,                // Callback function to execute when the visibility icon is tapped.
  }) : super(key: key);

  final bool isPasswordVisible;         // Determines whether the password is visible or hidden.
  final Function onTap;                  // Callback function to execute when the visibility icon is tapped.

  @override
  Widget build(BuildContext context) {
    // Padding widget for adding vertical space around the TextField.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      // TextField widget for user text input.
      child: TextField(
        // Styling for the text input.
        style: kBodyText.copyWith(
          color: Colors.white,
        ),
        // Determines whether the text should be obscured (hidden) or visible.
        obscureText: isPasswordVisible,
        // Specifies the type of keyboard input to use.
        keyboardType: TextInputType.text,
        // Specifies the type of action that the keyboard should take.
        textInputAction: TextInputAction.done,
        // Decoration for the input field, including hints, suffix icon, and borders.
        decoration: InputDecoration(
          // SuffixIcon for adding an icon at the end of the input field.
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            // IconButton for creating a clickable icon.
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              // Callback function to execute when the visibility icon is tapped.
              onPressed: () => onTap(),
              // Icon widget to display the visibility icon.
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
            ),
          ),
          // Padding around the content of the input field.
          contentPadding: const EdgeInsets.all(20),
          // Hint text to display when the input field is empty.
          hintText: 'Password',
          // Styling for the hint text.
          hintStyle: kBodyText,
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
