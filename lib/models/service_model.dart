import 'review_model.dart';

/// Model representing a service offering.
class ServiceModel {
  final String id;
  final String name;
  final String categoryId;
  final double rating;
  final int reviewCount;
  final double price;
  final String imageUrl;
  final String description;
  final String providerName;
  final String providerAvatar;
  final bool isPremium;
  final List<ReviewModel> reviews;
  final String duration;
  final bool isAvailableToday;
  final List<String> includedItems;
  final String location;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.rating,
    required this.reviewCount,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.providerName,
    required this.providerAvatar,
    this.isPremium = false,
    this.reviews = const [],
    this.duration = '2h',
    this.isAvailableToday = true,
    this.includedItems = const [],
    this.location = 'Your Area',
  });
}
