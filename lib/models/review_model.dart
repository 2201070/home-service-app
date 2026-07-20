/// Model representing a client review/testimonial.
class ReviewModel {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String reviewText;
  final String serviceType;

  const ReviewModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.reviewText,
    required this.serviceType,
  });
}
