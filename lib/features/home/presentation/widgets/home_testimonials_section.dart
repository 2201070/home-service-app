import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:home_services/app/theme/app_colors.dart';
import 'package:home_services/app/theme/app_spacing.dart';
import 'package:home_services/core/widgets/star_rating.dart';
import 'package:home_services/features/home/data/home_data.dart';

/// Testimonials section with horizontal scrollable review cards.
class HomeTestimonialsSection extends StatelessWidget {
  const HomeTestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'What Clients Say',
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.figmaNavy,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'All Reviews',
              style: TextStyle(
                color: AppColors.figmaBrown,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: HomeData.testimonials.length,
            separatorBuilder: (context, index) => const SizedBox(width: AppSpacing.s),
            itemBuilder: (context, index) {
              final review = HomeData.testimonials[index];
              return _TestimonialCard(
                userName: review.userName,
                userAvatar: review.userAvatar,
                serviceType: review.serviceType,
                rating: review.rating,
                reviewText: review.reviewText,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String userName;
  final String userAvatar;
  final String serviceType;
  final double rating;
  final String reviewText;

  const _TestimonialCard({
    required this.userName,
    required this.userAvatar,
    required this.serviceType,
    required this.rating,
    required this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white10 : AppColors.figmaBorder.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black12 : AppColors.figmaShadow.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: CachedNetworkImageProvider(userAvatar),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        color: isDark ? Colors.white : AppColors.figmaNavy,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      serviceType,
                      style: TextStyle(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.figmaTextGray,
                        fontSize: 11,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          StarRating(rating: rating),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              '"$reviewText"',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: isDark ? AppColors.textLight : AppColors.figmaTextGray,
                fontSize: 12,
                fontStyle: FontStyle.italic,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
