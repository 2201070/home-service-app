import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'theme/theme_cubit.dart';
import 'theme/app_theme.dart';
import 'routes/app_routes.dart';
import 'routes/page_transitions.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/service_listing/presentation/screens/service_listing_screen.dart';
import '../features/service_details/presentation/screens/service_details_screen.dart';
import '../models/service_model.dart';

/// The top-level MaterialApp widget that initializes state, theme, and routing configurations.
class HomeServeApp extends StatelessWidget {
  const HomeServeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'HomeServe',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            initialRoute: AppRoutes.home,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case AppRoutes.home:
                  return PageTransitions.slideUpFade(
                    const HomeScreen(),
                    settings,
                  );
                case AppRoutes.listing:
                  final categoryId = settings.arguments as String?;
                  return PageTransitions.slideUpFade(
                    ServiceListingScreen(initialCategoryId: categoryId),
                    settings,
                  );
                case AppRoutes.details:
                  final service = settings.arguments as ServiceModel;
                  return PageTransitions.slideUpFade(
                    ServiceDetailsScreen(service: service),
                    settings,
                  );
                default:
                  return MaterialPageRoute(
                    builder: (_) => const Scaffold(
                      body: Center(child: Text('Route not found')),
                    ),
                  );
              }
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
