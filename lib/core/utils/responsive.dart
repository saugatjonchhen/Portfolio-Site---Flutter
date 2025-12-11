import 'package:flutter/material.dart';

// Breakpoints
const int largeScreenThreshold = 1200;
const int mediumScreenThreshold = 768;

class ResponsiveLayout extends StatelessWidget {
  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;

  const ResponsiveLayout({
    super.key,
    required this.largeScreen,
    required this.mediumScreen,
    required this.smallScreen,
  });

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < mediumScreenThreshold;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= mediumScreenThreshold &&
        MediaQuery.of(context).size.width < largeScreenThreshold;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= largeScreenThreshold;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > largeScreenThreshold) {
          return largeScreen;
        } else if (constraints.maxWidth > mediumScreenThreshold) {
          return mediumScreen;
        } else {
          return smallScreen;
        }
      },
    );
  }
}