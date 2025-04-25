// Manages which page to display based on the screen size
import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1100) {
          return mobileBody; // If screen size is less that 1100, go to the mobile layout
        } else {
          return desktopBody; // Otherwise go the the desktop layout
        }
      },
    );
  }
}
