HomeServe — Home Services Platform Mobile App

A Flutter mobile application for a Home Services Platform, allowing users to browse
service categories, view available services, and check service details. Built as
part of the Eduzah Flutter Internship (Task 1 + Task 2).

Flutter Version


Flutter 3.38.3 • channel stable
Dart 3.10.1


Packages Used


flutter_bloc ^8.1.3 — state management (Cubit)
google_fonts ^6.1.0 — Poppins/Inter typography
cached_network_image ^3.3.1 — efficient loading of dummy network images
cupertino_icons ^1.0.8 — iOS-style icons


Project Structure

lib/
├── main.dart
├── app/
│   ├── app.dart                # MaterialApp, theme, routing setup
│   ├── theme/                  # colors, typography, spacing, light/dark ThemeData, ThemeCubit
│   └── routes/                 # route names + custom page transitions
├── core/
│   ├── widgets/                # shared reusable widgets (buttons, cards, rating stars)
│   └── utils/                  # extensions, responsive helpers
├── features/
│   ├── home/                   # Home Screen (hero, services, testimonials, bottom nav)
│   ├── service_listing/        # Service Listing screen per category
│   └── service_details/        # Service Details screen
└── models/                     # Category, Service, Review models

Features


Home Screen with a hero section, horizontally scrollable service categories,
customer testimonials, and a modern bottom navigation bar
Service Listing screen with search bar and category filters
Service Details screen with ratings, reviews, full description, included
services, duration, and availability
Hero animations on service images between the Listing and Details screens
Smooth custom page transitions across all navigation
Light and dark theme support
Fully responsive layout across different mobile screen sizes
Dummy data only — no backend or database integration


Installation & Run Instructions


Clone the repository:


bash   git clone https://github.com/2201070/home-service-app.git
   cd home-service-app


Install dependencies:


bash   flutter pub get


Run the app:


bash   flutter run
