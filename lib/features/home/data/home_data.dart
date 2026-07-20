import '../../../models/category_model.dart';
import '../../../models/review_model.dart';

/// Static lists of categories and client reviews for the home dashboard.
class HomeData {
  static const List<CategoryModel> categories = [
    CategoryModel(
      id: 'cleaning',
      name: 'Cleaning',
      subtitle: 'Home & office',
      imageUrl: 'https://images.unsplash.com/photo-1600585152220-90363fe7e115?w=500&auto=format&fit=crop&q=80',
    ),
    CategoryModel(
      id: 'repairs',
      name: 'Repairs',
      subtitle: 'Fix & finish',
      imageUrl: 'https://images.unsplash.com/photo-1585704032915-c3400ca199e7?w=500&auto=format&fit=crop&q=80',
    ),
    CategoryModel(
      id: 'moving',
      name: 'Moving',
      subtitle: 'Pack & shift',
      imageUrl: 'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=500&auto=format&fit=crop&q=80',
    ),
    CategoryModel(
      id: 'security',
      name: 'Security',
      subtitle: 'Safe & secure',
      imageUrl: 'https://images.unsplash.com/photo-1558002038-1055907df827?w=500&auto=format&fit=crop&q=80',
    ),
  ];

  static const List<ReviewModel> testimonials = [
    ReviewModel(
      id: 'rev_1',
      userName: 'Sarah Williams',
      userAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150&auto=format&fit=crop&q=80',
      rating: 5.0,
      reviewText: 'Absolutely professional. My home hasn\'t looked this good in years!',
      serviceType: 'Deep Cleaning',
    ),
    ReviewModel(
      id: 'rev_2',
      userName: 'Michael Brown',
      userAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80',
      rating: 5.0,
      reviewText: 'The team was prompt, professional, and solved my plumbing issue in no time.',
      serviceType: 'Plumbing Repair',
    ),
    ReviewModel(
      id: 'rev_3',
      userName: 'Emily Davis',
      userAvatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&auto=format&fit=crop&q=80',
      rating: 5.0,
      reviewText: 'Highly recommend! Seamless moving process, everything arrived in perfect condition.',
      serviceType: 'House Moving',
    ),
  ];
}
