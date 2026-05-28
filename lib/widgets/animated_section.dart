import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Wraps a child widget and triggers entrance animations
/// when the widget scrolls into the viewport.
class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset slideOffset;
  final double visibilityThreshold;

  const AnimatedSection({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 700),
    this.slideOffset = const Offset(0, 40),
    this.visibilityThreshold = 0.15,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('animated-section-${widget.key ?? identityHashCode(this)}'),
      onVisibilityChanged: (info) {
        if (!_isVisible && info.visibleFraction >= widget.visibilityThreshold) {
          setState(() => _isVisible = true);
        }
      },
      child: AnimatedOpacity(
        duration: Duration.zero,
        opacity: _isVisible ? 1.0 : 0.0,
        child: _isVisible
            ? widget.child
                .animate()
                .fadeIn(
                  duration: widget.duration,
                  delay: widget.delay,
                  curve: Curves.easeOutCubic,
                )
                .moveY(
                  begin: widget.slideOffset.dy,
                  end: 0,
                  duration: widget.duration,
                  delay: widget.delay,
                  curve: Curves.easeOutCubic,
                )
            : Opacity(opacity: 0, child: widget.child),
      ),
    );
  }
}
