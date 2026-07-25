# HomeServe — Home Services Platform Mobile App

A Flutter mobile application for a Home Services Platform, allowing users to browse
service categories, view available services, check service details, and book a
service with a selected date, time, and address. Built as part of the Eduzah
Flutter Internship (Task 1 + Task 2 + Task 3).

## Flutter Version
- Flutter 3.38.3 • channel stable
- Dart 3.10.1

## Packages Used
- `flutter_bloc` ^8.1.3 — state management (Cubit)
- `google_fonts` ^6.1.0 — Poppins/Inter typography
- `cached_network_image` ^3.3.1 — efficient loading of dummy network images
- `cupertino_icons` ^1.0.8 — iOS-style icons
- `animated_text_kit` — rotating typewriter-style hint text in the Service
  Listing search bar
- `device_preview` — dev-only tool for testing responsiveness across device
  sizes (never included in release builds)

## Project Structure

lib/
├── main.dart
├── app/
│ ├── app.dart 
│ ├── theme/ 
│ └── routes/ 
├── core/
│ ├── widgets/ 
│ └── utils/ 
├── features/
│ ├── home/ 
│ ├── service_listing/ 
│ ├── service_details/
│ └── booking/ 
└── models/ 

## Features
- Home Screen with a hero section, horizontally scrollable service categories,
  customer testimonials, and a modern bottom navigation bar
- Service Listing screen with an animated rotating search hint and category filters
- Service Details screen with ratings, reviews, full description, included
  services, duration, and availability
- Booking screen: selected service summary, date & time selection via custom
  bottom sheets, address entry, notes, a booking summary, and total price
- Hero animations on service images between the Listing and Details screens
- Smooth custom page transitions across all navigation
- A modern success confirmation shown after booking
- Light and dark theme support, fully theme-aware across every screen and
  bottom sheet
- Fully responsive layout across different mobile screen sizes
- Dummy data only — no backend or database integration

## Installation & Run Instructions
1. Clone the repository:
```bash
   git clone https://github.com/2201070/home-service-app.git
   cd home-service-app
```
2. Install dependencies:
```bash
   flutter pub get
```
3. Run the app:
```bash
   flutter run
```



