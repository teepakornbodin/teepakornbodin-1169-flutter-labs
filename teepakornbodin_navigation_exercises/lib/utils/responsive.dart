import 'package:flutter/material.dart';

class Responsive {
  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 900;

  static bool isMobile(double width) {
    return width < tabletBreakpoint;
  }

  static bool isTablet(double width) {
    return width >= tabletBreakpoint && width < desktopBreakpoint;
  }

  static bool isDesktop(double width) {
    return width >= desktopBreakpoint;
  }

  static int getColumnCount(double width) {
    if (isMobile(width)) {
      return 1;
    } else if (isTablet(width)) {
      return 2;
    } else {
      return 3;
    }
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static EdgeInsets getScreenPadding(BuildContext context) {
    if (MediaQuery.of(context).size.width < 600) {
      return const EdgeInsets.all(16.0);
    } else {
      return const EdgeInsets.all(8.0);
    }
  }
}
