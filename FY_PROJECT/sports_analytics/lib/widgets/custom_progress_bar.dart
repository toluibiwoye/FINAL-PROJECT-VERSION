import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// CustomProgressBar is a StatelessWidget for displaying a custom progress bar using Lottie animation.
class CustomProgressBar extends StatelessWidget {
  // Constructor for the CustomProgressBar widget.
  const CustomProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Lottie.asset is a widget for displaying Lottie animations loaded from an asset.
    return Lottie.asset(
      'assets/loading.json',   // The path to the Lottie animation asset.
      width: 50.0,             // The width of the Lottie animation.
      height: 50.0,            // The height of the Lottie animation.
      fit: BoxFit.cover,       // The BoxFit property to control how the animation should be resized to fit.
    );
  }
}
