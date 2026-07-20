import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_services/app/theme/app_colors.dart';
import 'package:home_services/app/theme/app_spacing.dart';
import 'package:home_services/features/service_listing/data/category_filter.dart';
import 'package:home_services/features/service_listing/presentation/cubit/service_listing_cubit.dart';
import 'package:home_services/features/service_listing/presentation/widgets/service_search_bar.dart';
import 'package:home_services/features/service_listing/presentation/widgets/filter_chip_bar.dart';
import 'package:home_services/features/service_listing/presentation/widgets/service_card.dart';

/// Screen listing all available services with search and category filters.
class ServiceListingScreen extends StatelessWidget {
  final String? initialCategoryId;

  const ServiceListingScreen({
    super.key,
    this.initialCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ServiceListingCubit()..initializeWithCategory(initialCategoryId),
      child: const _ServiceListingView(),
    );
  }
}

class _ServiceListingView extends StatefulWidget {
  const _ServiceListingView();

  @override
  State<_ServiceListingView> createState() => _ServiceListingViewState();
}

class _ServiceListingViewState extends State<_ServiceListingView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.08)
                    : AppColors.figmaBorder.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: color.headingText,
              size: 18,
            ),
          ),
        ),
        title: Text(
          'Explore Services',
          style: TextStyle(
            color: color.headingText,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.s,
                vertical: AppSpacing.xs,
              ),
              child: ServiceSearchBar(
                controller: _searchController,
                onChanged: (val) =>
                    context.read<ServiceListingCubit>().updateSearchQuery(val),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            BlocBuilder<ServiceListingCubit, ServiceListingState>(
              buildWhen: (prev, curr) =>
                  prev.selectedCategoryId != curr.selectedCategoryId,
              builder: (context, state) {
                return FilterChipBar(
                  categories: CategoryFilters.all,
                  selectedId: state.selectedCategoryId,
                  onSelected: (id) =>
                      context.read<ServiceListingCubit>().selectCategory(id),
                );
              },
            ),
            const SizedBox(height: AppSpacing.s),
            BlocBuilder<ServiceListingCubit, ServiceListingState>(
              builder: (context, state) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                  child: Text(
                    '${state.services.length} services found',
                    style: TextStyle(
                      color: color.secondaryText,
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _buildServicesList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesList(BuildContext context) {
    final state = context.watch<ServiceListingCubit>().state;
    final color = AppColor(context);

    if (state.services.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_rounded,
                size: 64,
                color: color.secondaryText,
              ),
              const SizedBox(height: 16),
              Text(
                'No Services Found',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: color.headingText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Try typing a different keyword or choosing another category.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Inter',
                  color: color.secondaryText,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s, vertical: AppSpacing.xs),
      itemCount: state.services.length,
      separatorBuilder: (ctx, idx) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final service = state.services[index];
        return ServiceCard(service: service);
      },
    );
  }
}
