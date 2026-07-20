import 'package:flutter/material.dart';
import 'package:home_services/app/theme/app_colors.dart';

/// Custom bottom navigation bar for the home screen.
/// Displays 4 navigation items with the selected item shown as a pill.
class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black45 : Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        border: Border.all(
          color: isDark ? Colors.white10 : AppColors.figmaBorder.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavItem(
            index: 0,
            icon: Icons.home_rounded,
            label: 'Home',
            isSelected: currentIndex == 0,
            onTap: onTap,
          ),
          _NavItem(
            index: 1,
            icon: Icons.design_services_rounded,
            label: 'Services',
            isSelected: currentIndex == 1,
            onTap: onTap,
          ),
          _NavItem(
            index: 2,
            icon: Icons.calendar_month_rounded,
            label: 'Bookings',
            isSelected: currentIndex == 2,
            onTap: onTap,
          ),
          _NavItem(
            index: 3,
            icon: Icons.person_rounded,
            label: 'Profile',
            isSelected: currentIndex == 3,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final String label;
  final bool isSelected;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.index,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isSelected) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.figmaOrange,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.figmaBrown, size: 20),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.figmaBrown,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isDark ? AppColors.textSecondaryDark : AppColors.figmaTextGray,
              size: 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isDark ? AppColors.textSecondaryDark : AppColors.figmaTextGray,
                fontFamily: 'Inter',
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
