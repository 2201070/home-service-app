import 'package:flutter/material.dart';
import 'package:home_services/app/theme/app_colors.dart';

/// Reusable "About This Service" section with a "Read more" toggle.
/// Displays the service description capped at 3 lines by default.
class AboutSection extends StatelessWidget {
  final String description;
  final bool isExpanded;
  final VoidCallback onToggle;

  const AboutSection({
    super.key,
    required this.description,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
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
          Text(
            'About This Service',
            style: TextStyle(
              color: color.headingText,
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.33,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            maxLines: isExpanded ? null : 3,
            overflow:
                isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: TextStyle(
              color: color.bodyText,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 1.63,
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: onToggle,
            child: Text(
              isExpanded ? 'Read less' : 'Read more',
              style: TextStyle(
                color: AppColors.accentOrange,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1.63,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
