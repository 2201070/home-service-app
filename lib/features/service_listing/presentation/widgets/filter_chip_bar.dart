import 'package:flutter/material.dart';
import 'package:home_services/app/theme/app_colors.dart';
import 'package:home_services/features/service_listing/data/category_filter.dart';

class FilterChipBar extends StatelessWidget {
  final List<CategoryFilter> categories;
  final String selectedId;
  final ValueChanged<String> onSelected;

  const FilterChipBar({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColor(context);

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (ctx, idx) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = selectedId == cat.id;

          return GestureDetector(
            onTap: () => onSelected(cat.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accentOrange : color.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? Colors.transparent : color.border,
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  cat.name,
                  style: TextStyle(
                    color: isSelected ? Colors.white : color.headingText,
                    fontFamily: 'Inter',
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
