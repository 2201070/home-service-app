import 'package:flutter/material.dart';
import 'package:home_services/app/theme/app_colors.dart';
import 'package:home_services/app/theme/app_spacing.dart';

/// Sticky top bar with back button and favorite toggle.
class ServiceTopBar extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final VoidCallback? onFavoritePressed;

  const ServiceTopBar({
    super.key,
    this.onBackPressed,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CircularButton(
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: onBackPressed ?? () => Navigator.pop(context),
            ),
            _CircularButton(
              icon: Icons.favorite_border_rounded,
              onTap: onFavoritePressed ?? () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _CircularButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircularButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: AppColors.figmaNavy,
          size: icon == Icons.arrow_back_ios_new_rounded ? 18 : 20,
        ),
      ),
    );
  }
}
