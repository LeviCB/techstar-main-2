import 'package:flutter/material.dart';

class WaveDotsLoadingIndicator extends StatefulWidget {
  final double size;
  final Color color;

  const WaveDotsLoadingIndicator({
    Key? key,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  _WaveDotsLoadingIndicatorState createState() =>
      _WaveDotsLoadingIndicatorState();
}

class _WaveDotsLoadingIndicatorState extends State<WaveDotsLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 800,
      ),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.color;
    final double size = widget.size;
    final double dotSize = size * 0.17;
    final double negativeSpace = size - (4 * dotSize);
    final double gapBetweenDots = negativeSpace / 3;
    final double previousDotPosition = -(gapBetweenDots + dotSize);

    Widget translatingDot() => Transform.translate(
          offset: Tween<Offset>(
            begin: Offset.zero,
            end: Offset(previousDotPosition, 0),
          )
              .animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(
                    0.22,
                    0.82,
                  ),
                ),
              )
              .value,
          child: DrawDot.circular(
            dotSize: dotSize,
            color: color,
          ),
        );

    Widget scalingDot(bool scaleDown, Interval interval) => Transform.scale(
          scale: Tween<double>(
            begin: scaleDown ? 1.0 : 0.0,
            end: scaleDown ? 0.0 : 1.0,
          )
              .animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: interval,
                ),
              )
              .value,
          child: DrawDot.circular(
            dotSize: dotSize,
            color: color,
          ),
        );

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              scalingDot(
                true,
                const Interval(
                  0.0,
                  0.4,
                ),
              ),
              translatingDot(),
              translatingDot(),
              Stack(
                children: <Widget>[
                  scalingDot(
                    false,
                    const Interval(
                      0.3,
                      0.7,
                    ),
                  ),
                  translatingDot(),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class DrawDot extends StatelessWidget {
  final double width;
  final double height;
  final bool circular;
  final Color color;

  const DrawDot.circular({
    Key? key,
    required double dotSize,
    required this.color,
  })  : width = dotSize,
        height = dotSize,
        circular = true,
        super(key: key);

  const DrawDot.elliptical({
    Key? key,
    required this.width,
    required this.height,
    required this.color,
  })  : circular = false,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        shape: circular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: circular
            ? null
            : BorderRadius.all(Radius.elliptical(width, height)),
      ),
    );
  }
}
