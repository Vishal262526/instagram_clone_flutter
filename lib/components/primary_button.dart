import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.isLoading,
    this.height = 50,
    this.backgroundColor = blueColor,
  });

  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  final double height;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height,
        width: double.infinity,
        alignment: Alignment.center,
        // padding: const Edge=Insets.symmetric(vertical: 8, horizontal:8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: backgroundColor),
        child: isLoading
            ? const CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                color: Colors.white,
              )
            : Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
