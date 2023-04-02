import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.webScreen,
    required this.mobileScreen,
  });

  final Widget webScreen;
  final Widget mobileScreen;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webScreenSize) {
          return webScreen;
        } else {
          return mobileScreen;
        }
      },
    );
  }
}
