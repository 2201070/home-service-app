import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:home_services/app/theme/app_colors.dart';
import 'package:home_services/app/theme/app_spacing.dart';
import 'package:home_services/models/service_model.dart';
import 'package:home_services/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:home_services/features/booking/presentation/widgets/date_bottom_sheet.dart';
import 'package:home_services/features/booking/presentation/widgets/time_bottom_sheet.dart';

class BookingScreen extends StatelessWidget {
  final ServiceModel service;

  const BookingScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BookingCubit(initialPrice: service.price),
      child: BookingView(service: service),
    );
  }
}

class BookingView extends StatelessWidget {
  final ServiceModel service;

  const BookingView({super.key, required this.service});

  String _getFormattedDate(DateTime date) {
    final List<String> weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final weekday = weekdays[date.weekday - 1];
    final month = months[date.month - 1];
    return '$weekday, $month ${date.day}';
  }

  String _getFormattedTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String _getShortAddress(String fullAddress) {
    final lines = fullAddress.split('\n');
    if (lines.isNotEmpty) {
      return lines.first;
    }
    return fullAddress;
  }

  void _showAddressDialog(BuildContext context, String currentAddress, BookingCubit cubit) {
    final controller = TextEditingController(text: currentAddress);
    final color = AppColor(context);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: color.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Change Service Address',
          style: TextStyle(color: color.headingText, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: controller,
          maxLines: 3,
          style: TextStyle(color: color.bodyText),
          decoration: InputDecoration(
            hintText: 'Enter new address...',
            hintStyle: TextStyle(color: color.secondaryText.withValues(alpha: 0.6)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.figmaOrange, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: color.divider),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: TextStyle(color: color.secondaryText)),
          ),
          ElevatedButton(
            onPressed: () {
              cubit.updateAddress(controller.text);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.figmaOrange,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Save', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: color.background,
          body: Stack(
            children: [
              // Main content
              Positioned.fill(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Card
                      _buildHeader(context, isDark),

                      const SizedBox(height: AppSpacing.s),

                      // Schedule Picker Card ("When should we come?")
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                        child: _buildScheduleCard(context, state, color, isDark),
                      ),

                      const SizedBox(height: AppSpacing.m),

                      // Section 1: Service Address
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                        child: _buildSectionTitle('1', 'Service Address', color),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                        child: _buildAddressCard(context, state, color, isDark),
                      ),

                      const SizedBox(height: AppSpacing.m),

                      // Section 2: Additional Notes
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                        child: _buildSectionTitle('2', 'Additional Notes (Optional)', color),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                        child: _buildNotesCard(context, color, isDark),
                      ),

                      const SizedBox(height: AppSpacing.m),

                      // Section 3: Booking Summary
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                        child: _buildSectionTitle('3', 'Booking Summary', color),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
                        child: _buildReceiptCard(state, color, isDark),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Sticky Confirmation Bar
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildBottomConfirmBar(context, state, color, isDark),
              ),

              // Success Overlay
              if (state.isConfirmed)
                Positioned.fill(
                  child: _buildSuccessOverlay(context, state, color),
                ),
            ],
          ),
        );
      },
    );
  }

  // Header Widget with Background, titles, rating badge and back button
  Widget _buildHeader(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      height: 220,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: service.imageUrl,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Image.network(
              'https://placehold.co/390x160',
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.4),
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          // Back button and titles
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Row with Back Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Bottom Row with Titles and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              service.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              service.providerName,
                              style: const TextStyle(
                                color: Color(0xFFE1E2E5),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Rating Badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.figmaOrange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              service.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Card showing schedule (Date and Time Pickers).
  // Date/time text values use tightly-scoped BlocBuilders so only those
  // rebuild on state changes — the rest of the card stays static.
  Widget _buildScheduleCard(BuildContext context, BookingState state, AppColor color, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.divider, width: 1),
        boxShadow: color.cardShadow,
      ),
      child: Column(
        children: [
          // Header inside card
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'When should we come?',
                style: TextStyle(
                  color: color.headingText,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          // ── Date Row ──────────────────────────────────────────────────
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                barrierColor: Colors.black.withValues(alpha: 0.3),
                builder: (_) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: BlocProvider.value(
                    value: context.read<BookingCubit>(),
                    child: const DateBottomSheet(),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.figmaOrange,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      // Scoped BlocBuilder — rebuilds only this Text on date change.
                      BlocBuilder<BookingCubit, BookingState>(
                        buildWhen: (prev, next) =>
                            prev.selectedDate != next.selectedDate,
                        builder: (_, s) => Text(
                          _getFormattedDate(s.selectedDate),
                          style: TextStyle(
                            color: color.headingText,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: color.secondaryText,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Divider(color: color.divider, height: 1),
          ),

          // ── Time Row ──────────────────────────────────────────────────
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                barrierColor: Colors.black.withValues(alpha: 0.3),
                builder: (_) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: BlocProvider.value(
                    value: context.read<BookingCubit>(),
                    child: const TimeBottomSheet(),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        color: AppColors.figmaOrange,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      // Scoped BlocBuilder — rebuilds only this Text on time change.
                      BlocBuilder<BookingCubit, BookingState>(
                        buildWhen: (prev, next) =>
                            prev.selectedTime != next.selectedTime,
                        builder: (_, s) => Text(
                          _getFormattedTime(s.selectedTime),
                          style: TextStyle(
                            color: color.headingText,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: color.secondaryText,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // Section title row with badges
  Widget _buildSectionTitle(String number, String title, AppColor color) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: AppColors.figmaOrange,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            color: color.headingText,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Address card widget
  Widget _buildAddressCard(BuildContext context, BookingState state, AppColor color, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.divider, width: 1),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.figmaOrange.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.figmaOrange,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    state.address,
                    style: TextStyle(
                      color: color.bodyText,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _showAddressDialog(context, state.address, context.read<BookingCubit>()),
            child: const Text(
              'Change',
              style: TextStyle(
                color: AppColors.figmaOrange,
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Notes textfield card widget
  Widget _buildNotesCard(BuildContext context, AppColor color, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.divider, width: 1),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.black.withValues(alpha: 0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        maxLines: 3,
        style: TextStyle(color: color.bodyText, fontSize: 15, fontFamily: 'Inter'),
        onChanged: (val) => context.read<BookingCubit>().updateNotes(val),
        decoration: InputDecoration(
          hintText: 'e.g. Gate code, pet in the house...',
          hintStyle: TextStyle(
            color: color.secondaryText.withValues(alpha: 0.5),
            fontSize: 15,
            fontFamily: 'Inter',
          ),
          contentPadding: const EdgeInsets.all(16),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Receipt Card Widget
  Widget _buildReceiptCard(BookingState state, AppColor color, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.divider, width: 1),
        boxShadow: color.cardShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Thick vertical accent line on left side
              Container(
                width: 5,
                color: AppColors.figmaOrange,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BOOKING RECEIPT',
                        style: TextStyle(
                          color: color.secondaryText,
                          fontSize: 11,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildReceiptRow('Service', service.name, color, isBoldValue: true),
                      const SizedBox(height: 12),
                      _buildReceiptRow('Date', _getFormattedDate(state.selectedDate), color),
                      const SizedBox(height: 12),
                      _buildReceiptRow('Time', _getFormattedTime(state.selectedTime), color),
                      const SizedBox(height: 12),
                      _buildReceiptRow('Address', _getShortAddress(state.address), color),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value, AppColor color, {bool isBoldValue = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: color.secondaryText,
            fontSize: 14,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: color.headingText,
              fontSize: 14,
              fontFamily: 'Inter',
              fontWeight: isBoldValue ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Sticky bottom confirm bar widget
  Widget _buildBottomConfirmBar(BuildContext context, BookingState state, AppColor color, bool isDark) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: color.surface,
        border: Border(
          top: BorderSide(
            color: color.divider,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black45 : Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Price',
                style: TextStyle(
                  color: color.secondaryText,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '\$${state.basePrice.toStringAsFixed(0)}',
                style: TextStyle(
                  color: color.headingText,
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: SizedBox(
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  context.read<BookingCubit>().confirmBooking();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.figmaOrange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Confirm Booking',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Premium success overlay screen shown on booking confirmation
  Widget _buildSuccessOverlay(BuildContext context, BookingState state, AppColor color) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Container(
        color: Colors.black.withValues(alpha: 0.65),
        alignment: Alignment.center,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 300),
          builder: (context, val, child) {
            return Transform.scale(
              scale: val,
              child: Opacity(
                opacity: val,
                child: child,
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: color.surface,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Badge
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.check_circle_rounded,
                    color: Color(0xFF2E7D32),
                    size: 54,
                  ),
                ),
                const SizedBox(height: 24),
                // Titles
                const Text(
                  'Booking Confirmed!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Your booking for ${service.name} has been successfully scheduled with ${service.providerName}.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: color.secondaryText,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                // Divider
                Divider(color: color.divider, height: 1),
                const SizedBox(height: 16),
                // Highlight Receipt
                _buildSuccessSummaryRow('Date', _getFormattedDate(state.selectedDate), color),
                const SizedBox(height: 8),
                _buildSuccessSummaryRow('Time', _getFormattedTime(state.selectedTime), color),
                const SizedBox(height: 8),
                _buildSuccessSummaryRow('Address', _getShortAddress(state.address), color),
                const SizedBox(height: 24),
                // Home Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate back to the home screen dashboard.
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.figmaOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessSummaryRow(String label, String value, AppColor color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: color.secondaryText, fontSize: 13, fontFamily: 'Inter'),
        ),
        Text(
          value,
          style: TextStyle(color: color.headingText, fontSize: 13, fontFamily: 'Inter', fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
