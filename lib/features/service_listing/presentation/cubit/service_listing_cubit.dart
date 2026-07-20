import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/service_model.dart';
import '../../data/services_data.dart';

class ServiceListingState {
  final List<ServiceModel> services;
  final String selectedCategoryId;
  final String searchQuery;

  const ServiceListingState({
    required this.services,
    required this.selectedCategoryId,
    required this.searchQuery,
  });

  ServiceListingState copyWith({
    List<ServiceModel>? services,
    String? selectedCategoryId,
    String? searchQuery,
  }) {
    return ServiceListingState(
      services: services ?? this.services,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ServiceListingCubit extends Cubit<ServiceListingState> {
  ServiceListingCubit()
      : super(const ServiceListingState(
          services: ServicesData.services,
          selectedCategoryId: 'all',
          searchQuery: '',
        ));

  void initializeWithCategory(String? categoryId) {
    if (categoryId != null) {
      _filter(categoryId, state.searchQuery);
    }
  }

  void selectCategory(String categoryId) {
    _filter(categoryId, state.searchQuery);
  }

  void updateSearchQuery(String query) {
    _filter(state.selectedCategoryId, query);
  }

  void _filter(String categoryId, String query) {
    List<ServiceModel> filtered = ServicesData.services;

    if (categoryId != 'all') {
      filtered = filtered.where((s) => s.categoryId == categoryId).toList();
    }

    if (query.isNotEmpty) {
      final q = query.toLowerCase();
      filtered = filtered.where((s) {
        return s.name.toLowerCase().contains(q) ||
            s.description.toLowerCase().contains(q) ||
            s.providerName.toLowerCase().contains(q);
      }).toList();
    }

    emit(ServiceListingState(
      services: filtered,
      selectedCategoryId: categoryId,
      searchQuery: query,
    ));
  }
}
