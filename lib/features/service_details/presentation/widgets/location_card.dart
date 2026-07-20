import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:home_services/app/theme/app_colors.dart';
import 'package:home_services/models/service_model.dart';

/// Location map card with gradient overlay and location badge.
class LocationCard extends StatelessWidget {
  final ServiceModel service;

  const LocationCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final color = AppColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
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
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://maps.geoapify.com/v1/staticmap?style=osm-bright&width=600&height=300&center=lonlat:-73.9857,40.7484&zoom=13&apiKey=demo',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.03)
                  : AppColors.figmaLightGrayBg,
              child: Center(
                child: Icon(
                  Icons.map_outlined,
                  size: 48,
                  color: color.secondaryText,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.03)
                  : AppColors.figmaLightGrayBg,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map_outlined,
                    size: 24,
                    color: color.secondaryText,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Map View',
                    style: TextStyle(
                      color: color.secondaryText,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    color.surface.withValues(alpha: 0.95),
                    color.surface.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.divider, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.accentOrange,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Available in ${service.location}',
                    style: TextStyle(
                      color: color.bodyText,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
