import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:home_services/app/theme/app_colors.dart';
import 'package:home_services/core/widgets/star_rating.dart';
import 'package:home_services/models/service_model.dart';
import 'package:home_services/models/review_model.dart';

/// Reviews section with horizontal scrollable review cards.
class ReviewsSection extends StatelessWidget {
  final ServiceModel service;

  const ReviewsSection({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final color = AppColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.divider, width: 1),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : AppColors.figmaShadow.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reviews',
                style: TextStyle(
                  color: color.headingText,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.33,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(
                  color: AppColors.accentOrange,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 1.43,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (service.reviews.isEmpty)
            Text(
              'No reviews yet for this service.',
              style: TextStyle(
                color: color.secondaryText,
                fontSize: 14,
                fontFamily: 'Inter',
                fontStyle: FontStyle.italic,
              ),
            )
          else
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: service.reviews.length,
                separatorBuilder: (ctx, idx) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return _ReviewCard(review: service.reviews[index]);
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final ReviewModel review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    final color = AppColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 260,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.03)
            : AppColors.figmaLightGrayBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.divider, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: review.userAvatar,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 32,
                    height: 32,
                    color: color.surface,
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 32,
                    height: 32,
                    color: color.surface,
                    child: Icon(Icons.person, size: 16, color: color.secondaryText),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  review.userName,
                  style: TextStyle(
                    color: color.headingText,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.43,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          StarRating(rating: review.rating, size: 12),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              '"${review.reviewText}"',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color.bodyText,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.33,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
