import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:home_services/app/theme/app_colors.dart';

class ProviderTile extends StatelessWidget {
  final String providerName;
  final String providerAvatar;

  const ProviderTile({
    super.key,
    required this.providerName,
    required this.providerAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: providerAvatar,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 56,
                height: 56,
                color: color.surface,
                child: Icon(
                  Icons.person_rounded,
                  color: color.secondaryText,
                  size: 28,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 56,
                height: 56,
                color: color.surface,
                child: Icon(
                  Icons.person_rounded,
                  color: color.secondaryText,
                  size: 28,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Provider',
                  style: TextStyle(
                    color: color.secondaryText,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 1.43,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  providerName,
                  style: TextStyle(
                    color: color.headingText,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.surface,
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(
                color: isDark ? Colors.white10 : AppColors.figmaBorder,
                width: 1,
              ),
            ),
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              color: color.headingText,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
