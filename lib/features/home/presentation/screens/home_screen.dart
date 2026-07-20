import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_services/app/theme/app_colors.dart';
import 'package:home_services/app/theme/app_spacing.dart';
import 'package:home_services/features/home/presentation/cubit/home_cubit.dart';
import 'package:home_services/features/home/presentation/widgets/home_header.dart';
import 'package:home_services/features/home/presentation/widgets/home_hero_card.dart';
import 'package:home_services/features/home/presentation/widgets/home_services_section.dart';
import 'package:home_services/features/home/presentation/widgets/home_testimonials_section.dart';
import 'package:home_services/features/home/presentation/widgets/home_bottom_nav_bar.dart';

/// The main dashboard screen for the HomeServe app.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  static const _placeholderPages = [
    Center(child: Text('Services Screen Placeholder', style: TextStyle(fontSize: 18))),
    Center(child: Text('Bookings Screen Placeholder', style: TextStyle(fontSize: 18))),
    Center(child: Text('Profile Screen Placeholder', style: TextStyle(fontSize: 18))),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentIndex = context.select<HomeCubit, int>((c) => c.state.currentTabIndex);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.figmaBackground,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: IndexedStack(
                index: currentIndex,
                children: [
                  const _HomeDashboard(),
                  ..._placeholderPages,
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: HomeBottomNavBar(
                currentIndex: currentIndex,
                onTap: (i) => context.read<HomeCubit>().selectTab(i),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeDashboard extends StatelessWidget {
  const _HomeDashboard();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s,
        vertical: AppSpacing.xs,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeader(),
          SizedBox(height: AppSpacing.m),
          HomeHeroCard(),
          SizedBox(height: AppSpacing.l),
          HomeServicesSection(),
          SizedBox(height: AppSpacing.l),
          HomeTestimonialsSection(),
          SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}
