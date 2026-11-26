import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedVisibility extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset slideOffset;
  final bool fadeIn;

  const AnimatedVisibility({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.slideOffset = const Offset(0, 30),
    this.fadeIn = true,
  });

  @override
  State<AnimatedVisibility> createState() => _AnimatedVisibilityState();
}

class _AnimatedVisibilityState extends State<AnimatedVisibility> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          if (mounted) setState(() => _visible = true);
        }
      },
      child: AnimatedOpacity(
        duration: widget.duration,
        opacity: _visible ? 1.0 : 0.0,
        child: AnimatedSlide(
          duration: widget.duration,
          curve: Curves.easeOut,
          offset: _visible ? Offset.zero : Offset(0, widget.slideOffset.dy / 100),
          child: widget.child,
        ),
      ),
    );
  }
}

// A simpler slide-fade wrapper using flutter_animate
class FadeSlideIn extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate(delay: delay)
        .fadeIn(duration: duration, curve: Curves.easeOut)
        .slideY(
          begin: 0.15,
          end: 0,
          duration: duration,
          curve: Curves.easeOut,
        );
  }
}
