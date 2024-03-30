import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerView extends StatelessWidget {
  const ShimmerView._({
    Key? key,
    required this.height,
    required this.width,
    this.isCircle = false,
    this.borderRadius,
  }) : super(key: key);

  final double height;
  final double width;
  final bool isCircle;
  final BorderRadiusGeometry? borderRadius;

  factory ShimmerView.rect(
          {required double width, required double height, BorderRadiusGeometry? borderRadius}) =>
      ShimmerView._(
        width: width,
        height: height,
        borderRadius: borderRadius,
      );

  factory ShimmerView.circle({required double width, required double height}) => ShimmerView._(
        width: width,
        height: height,
        isCircle: true,
      );

  @override
  Widget build(BuildContext context) {
    if (isCircle) {
      return ClipOval(
        child: Shimmer.fromColors(
          baseColor: const Color(0xFFE0E0E0),
          highlightColor: const Color(0xFFF5F5F5),
          direction: ShimmerDirection.ltr,
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(5),
      child: Shimmer.fromColors(
        baseColor: const Color(0xFFE0E0E0),
        highlightColor: const Color(0xFFF5F5F5),
        direction: ShimmerDirection.ltr,
        child: Container(
          width: width,
          height: height,
          color: Colors.white,
        ),
      ),
    );
  }
}
