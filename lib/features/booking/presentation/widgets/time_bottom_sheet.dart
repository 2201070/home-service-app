/// Time bottom sheet for the Booking feature.
///
/// Shows a [CupertinoDatePicker] in time mode inside a modal bottom sheet.
/// Caller: invoke via [showModalBottomSheet] with [isScrollControlled: true]
/// and [backgroundColor: Colors.transparent].
library;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_services/app/theme/app_colors.dart';
import 'package:home_services/app/theme/app_spacing.dart';
import 'package:home_services/features/booking/presentation/cubit/booking_cubit.dart';

import 'package:home_services/app/theme/app_typography.dart';

class TimeBottomSheet extends StatefulWidget {
  const TimeBottomSheet({super.key});

  @override
  State<TimeBottomSheet> createState() => _TimeBottomSheetState();
}

class _TimeBottomSheetState extends State<TimeBottomSheet> {
  late DateTime _selectedDateTime;

  @override
  void initState() {
    super.initState();
    // Seed with the cubit's current time, anchored to today's date.
    final tod = context.read<BookingCubit>().state.selectedTime;
    final now = DateTime.now();
    _selectedDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      tod.hour,
      tod.minute,
    );
  }

  String _getFormattedDate(DateTime date) {
    final List<String> weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final weekday = weekdays[date.weekday - 1];
    final month = months[date.month - 1];
    return '$weekday, $month ${date.day}';
  }

  void _onConfirm(BuildContext ctx) {
    ctx
        .read<BookingCubit>()
        .selectTime(TimeOfDay.fromDateTime(_selectedDateTime));
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    final color = AppColor(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    final selectedDate = context.read<BookingCubit>().state.selectedDate;

    return SafeArea(
      top: false,
      child: Container(
        height: screenHeight * 0.58,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        padding: EdgeInsets.only(
          left: AppSpacing.s,
          right: AppSpacing.s,
          top: AppSpacing.s,
          bottom: MediaQuery.of(context).padding.bottom + AppSpacing.s,
        ),
        child: Column(
          children: [
            // ── Drag handle ──────────────────────────────────────────────
            Center(
              child: Container(
                width: 38,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white24
                      : AppColors.figmaBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.s),

            // ── Title ────────────────────────────────────────────────────
            Text(
              'Select Time',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: color.headingText,
              ),
            ),
            const SizedBox(height: 8),

            // ── Selected Date Header ─────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: AppColors.primaryNavy,
                ),
                const SizedBox(width: 8),
                Text(
                  _getFormattedDate(selectedDate),
                  style: AppTypography.body.copyWith(
                    color: AppColors.primaryNavy,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),

            // ── Picker with tinted highlight band ───────────────────────
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Orange-tinted highlight band behind the picker column
                  Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.accentOrange.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.accentOrange.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                    ),
                  ),

                  // CupertinoDatePicker in time mode
                  CupertinoTheme(
                    data: CupertinoThemeData(
                      brightness:
                          isDark ? Brightness.dark : Brightness.light,
                      textTheme: CupertinoTextThemeData(
                        // Selected and unselected row text
                        dateTimePickerTextStyle: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textLight
                              : AppColors.primaryNavy,
                        ),
                        pickerTextStyle: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.textLight
                              : AppColors.primaryNavy,
                        ),
                      ),
                    ),
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.time,
                      initialDateTime: _selectedDateTime,
                      backgroundColor: Colors.transparent,
                      use24hFormat: false,
                      onDateTimeChanged: (dt) {
                        setState(() => _selectedDateTime = dt);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.s),

            // ── Confirm button ───────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => _onConfirm(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentOrange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Confirm Time',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
