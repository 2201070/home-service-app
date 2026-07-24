import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_services/app/theme/app_colors.dart';
import 'package:home_services/app/theme/app_spacing.dart';
import 'package:home_services/models/service_model.dart';
import 'package:home_services/app/routes/app_routes.dart';
import 'package:home_services/features/service_details/presentation/cubit/service_details_cubit.dart';
import 'package:home_services/features/service_details/presentation/widgets/service_image_header.dart';
import 'package:home_services/features/service_details/presentation/widgets/service_info_card.dart';
import 'package:home_services/features/service_details/presentation/widgets/about_section.dart';
import 'package:home_services/features/service_details/presentation/widgets/included_items_section.dart';
import 'package:home_services/features/service_details/presentation/widgets/provider_tile.dart';
import 'package:home_services/features/service_details/presentation/widgets/location_card.dart';
import 'package:home_services/features/service_details/presentation/widgets/reviews_section.dart';
import 'package:home_services/features/service_details/presentation/widgets/bottom_cta_bar.dart';
import 'package:home_services/features/service_details/presentation/widgets/service_top_bar.dart';

/// Detailed view screen for a single home service offering.
class ServiceDetailsScreen extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailsScreen({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceDetailsCubit(),
      child: _ServiceDetailsBody(service: service),
    );
  }
}

class _ServiceDetailsBody extends StatelessWidget {
  final ServiceModel service;

  const _ServiceDetailsBody({required this.service});

  @override
  Widget build(BuildContext context) {
    final color = AppColor(context);
    final isDescriptionExpanded = context.select<ServiceDetailsCubit, bool>(
      (c) => c.state.isDescriptionExpanded,
    );

    return Scaffold(
      backgroundColor: color.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ServiceImageHeader(service: service),

                  Transform.translate(
                    offset: const Offset(0, -40),
                    child: ServiceInfoCard(service: service),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                    child: AboutSection(
                      description: service.description,
                      isExpanded: isDescriptionExpanded,
                      onToggle: () => context.read<ServiceDetailsCubit>().toggleDescription(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s),

                  if (service.includedItems.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                      child: IncludedItemsSection(items: service.includedItems),
                    ),
                    const SizedBox(height: AppSpacing.s),
                  ],

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                    child: Column(
                      children: [
                        ProviderTile(
                          providerName: service.providerName,
                          providerAvatar: service.providerAvatar,
                        ),
                        const SizedBox(height: AppSpacing.s),
                        LocationCard(service: service),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                    child: ReviewsSection(service: service),
                  ),
                  const SizedBox(height: AppSpacing.m),
                ],
              ),
            ),
          ),

          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ServiceTopBar(),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomCtaBar(
              price: service.price,
              onPressed: () => Navigator.pushNamed(
                context,
                AppRoutes.booking,
                arguments: service,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
