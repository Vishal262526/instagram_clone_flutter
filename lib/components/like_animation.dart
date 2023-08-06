import 'package:flutter/material.dart';

class LikeAnimation extends StatefulWidget {
  const LikeAnimation({
    super.key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(microseconds: 150),
    required this.onEnd,
    this.isSmallLike = false,
  });

  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool isSmallLike;

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> scale;

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    scale = Tween<double>(begin: 1, end: 1.2).animate(_animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != widget.isAnimating) {
      startAnimation();
    }
  }

  void startAnimation() async {
    if (widget.isAnimating || widget.isSmallLike) {
      await _animationController.forward();
      await _animationController.reverse();
      await Future.delayed(
        const Duration(milliseconds: 200),
      );
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
