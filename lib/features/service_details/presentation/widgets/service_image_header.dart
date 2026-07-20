import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:home_services/app/theme/app_colors.dart';
import 'package:home_services/models/service_model.dart';

/// Hero image header with bottom gradient overlay for the service details screen.
class ServiceImageHeader extends StatelessWidget {
  final ServiceModel service;

  const ServiceImageHeader({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final color = AppColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: double.infinity,
      height: 350,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Hero(
            tag: 'service-image-${service.id}',
            child: CachedNetworkImage(
              imageUrl: service.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: isDark ? AppColors.surfaceDark : Colors.grey[300],
                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
              ),
              errorWidget: (context, url, error) => Container(
                color: isDark ? AppColors.surfaceDark : Colors.grey[300],
                child: Icon(
                  Icons.broken_image_outlined,
                  color: color.secondaryText,
                  size: 48,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 160,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    color.background,
                    color.background.withValues(alpha: 0.8),
                    color.background.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
