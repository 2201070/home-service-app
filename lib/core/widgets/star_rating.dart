import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double size;
  final Color color;

  const StarRating({
    super.key,
    required this.rating,
    this.size = 16.0,
    this.color = const Color(0xFFFE893C),
  });

  @override
  Widget build(BuildContext context) {
    final int fullStars = rating.floor();
    final bool hasHalf = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Icon(Icons.star_rounded, color: color, size: size);
        } else if (index == fullStars && hasHalf) {
          return Icon(Icons.star_half_rounded, color: color, size: size);
        } else {
          return Icon(Icons.star_rounded, color: color.withValues(alpha: 0.2), size: size);
        }
      }),
    );
  }
}
