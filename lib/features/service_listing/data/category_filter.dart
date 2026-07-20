/// Typed data class representing a filter chip option on the service listing screen.
class CategoryFilter {
  final String id;
  final String name;

  const CategoryFilter({required this.id, required this.name});
}

/// Static list of available category filter options.
class CategoryFilters {
  static const List<CategoryFilter> all = [
    CategoryFilter(id: 'all', name: 'All'),
    CategoryFilter(id: 'cleaning', name: 'Cleaning'),
    CategoryFilter(id: 'repairs', name: 'Repairs'),
    CategoryFilter(id: 'moving', name: 'Moving'),
    CategoryFilter(id: 'security', name: 'Security'),
  ];
}
