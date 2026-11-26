import 'package:flutter/material.dart';

class ResponsiveBreakpoints {
  static const double mobile = 767;
  static const double tablet = 1024;
  static const double laptop = 1366;
  static const double desktop = 1440;
}

class ResponsiveUtils {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= ResponsiveBreakpoints.mobile;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width > ResponsiveBreakpoints.mobile &&
      MediaQuery.of(context).size.width <= ResponsiveBreakpoints.tablet;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > ResponsiveBreakpoints.tablet;

  static bool isLargeDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > ResponsiveBreakpoints.desktop;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static T responsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? desktop;
    return desktop;
  }

  static double responsiveFontSize(
    BuildContext context, {
    required double mobile,
    double? tablet,
    required double desktop,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet ?? (mobile + desktop) / 2;
    return desktop;
  }

  static EdgeInsets sectionPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 60);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 40, vertical: 80);
    }
    return const EdgeInsets.symmetric(horizontal: 80, vertical: 100);
  }

  static double maxContentWidth(BuildContext context) {
    final w = screenWidth(context);
    if (w > 1400) return 1200;
    if (w > 1024) return w * 0.88;
    if (w > 767) return w * 0.92;
    return w;
  }

  static int gridCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }

  static double heroTitleSize(BuildContext context) {
    final w = screenWidth(context);
    if (w <= 400) return 28;
    if (w <= 767) return 36;
    if (w <= 1024) return 48;
    if (w <= 1366) return 60;
    return 72;
  }
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= ResponsiveBreakpoints.mobile) {
          return mobile;
        } else if (constraints.maxWidth <= ResponsiveBreakpoints.tablet) {
          return tablet ?? desktop;
        }
        return desktop;
      },
    );
  }
}
