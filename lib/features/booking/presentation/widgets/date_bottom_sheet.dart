/// Date bottom sheet for the Booking feature.
///
/// Shows a fully custom calendar grid inside a modal bottom sheet.
/// Caller: invoke via [showModalBottomSheet] with [isScrollControlled: true]
/// and [backgroundColor: Colors.transparent].
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_services/app/theme/app_colors.dart';
import 'package:home_services/app/theme/app_spacing.dart';
import 'package:home_services/features/booking/presentation/cubit/booking_cubit.dart';

class DateBottomSheet extends StatefulWidget {
  const DateBottomSheet({super.key});

  @override
  State<DateBottomSheet> createState() => _DateBottomSheetState();
}

class _DateBottomSheetState extends State<DateBottomSheet> {
  late DateTime _focusedMonth;
  late DateTime _selectedDate;

  static const List<String> _weekdayLabels = [
    'Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa',
  ];

  static const List<String> _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  @override
  void initState() {
    super.initState();
    // Read the current cubit state as the starting selection.
    final cubitDate = context.read<BookingCubit>().state.selectedDate;
    _selectedDate = cubitDate;
    _focusedMonth = DateTime(cubitDate.year, cubitDate.month);
  }

  void _previousMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    });
  }

  void _onConfirm(BuildContext ctx) {
    ctx.read<BookingCubit>().selectDate(_selectedDate);
    Navigator.pop(ctx);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        primaryColor: AppColors.primaryNavy,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryNavy,
          secondary: AppColors.accentOrange,
          surface: Colors.white,
          onPrimary: Colors.white,
          onSurface: AppColors.primaryNavy,
        ),
      ),
      child: Builder(
        builder: (innerContext) {
          final color = AppColor(innerContext);
          const isDark = false; // Always light theme!
          final screenHeight = MediaQuery.of(innerContext).size.height;

          final daysInMonth =
              DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
          // weekday: Mon=1…Sun=7 → offset for Sunday-first grid
          final firstWeekday =
              DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday;
          final weekdayOffset = firstWeekday % 7; // Sun=0, Mon=1 … Sat=6
          final totalCells = weekdayOffset + daysInMonth;

          final today = DateTime.now();

          return SafeArea(
            top: false,
            child: Container(
              height: screenHeight * 0.58,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: EdgeInsets.only(
                left: AppSpacing.s,
                right: AppSpacing.s,
                top: AppSpacing.s,
                bottom: MediaQuery.of(innerContext).padding.bottom + AppSpacing.s,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // ── Drag handle ──────────────────────────────────────────────
                  Center(
                    child: Container(
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.figmaBorder,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s),

                  // ── Title ────────────────────────────────────────────────────
                  Text(
                    'Select Date',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: color.headingText,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.s),

                  // ── Month navigation ─────────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _NavButton(
                        icon: Icons.chevron_left_rounded,
                        onPressed: _previousMonth,
                        isDark: isDark,
                      ),
                      Text(
                        '${_monthNames[_focusedMonth.month - 1]} ${_focusedMonth.year}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: color.headingText,
                        ),
                      ),
                      _NavButton(
                        icon: Icons.chevron_right_rounded,
                        onPressed: _nextMonth,
                        isDark: isDark,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // ── Weekday header row ───────────────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _weekdayLabels.map((label) {
                      return SizedBox(
                        width: 36,
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondaryLight,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // ── Calendar grid ────────────────────────────────────────────
                  Expanded(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: totalCells,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 0,
                        childAspectRatio: 1.0,
                      ),
                      itemBuilder: (innerContext, index) {
                        if (index < weekdayOffset) return const SizedBox.shrink();

                        final day = index - weekdayOffset + 1;
                        final cellDate = DateTime(
                          _focusedMonth.year,
                          _focusedMonth.month,
                          day,
                        );
                        final isSelected =
                            DateUtils.isSameDay(_selectedDate, cellDate);
                        final isToday = DateUtils.isSameDay(today, cellDate);
                        final isPast = cellDate.isBefore(
                          DateTime(today.year, today.month, today.day),
                        );

                        Color textColor;
                        if (isSelected) {
                          textColor = Colors.white;
                        } else if (isPast) {
                          textColor = color.secondaryText.withValues(alpha: 0.35);
                        } else {
                          textColor = color.headingText;
                        }

                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: isPast
                              ? null
                              : () {
                                  debugPrint('Tapped cell date: $cellDate');
                                  setState(() {
                                    _selectedDate = cellDate;
                                    debugPrint('Selected date updated to: $_selectedDate');
                                  });
                                },
                          child: Container(
                            margin: const EdgeInsets.all(2),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? AppColors.accentOrange
                                  : Colors.transparent,
                              border: isToday && !isSelected
                                  ? Border.all(
                                      color: AppColors.accentOrange,
                                      width: 1.5,
                                  )
                                  : null,
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: AppColors.accentOrange
                                            .withValues(alpha: 0.45),
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Text(
                              '$day',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight:
                                    isSelected || isToday
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                color: textColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // ── Confirm button ───────────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => _onConfirm(innerContext),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentOrange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Confirm Date',
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
        },
      ),
    );
  }
}

/// Circular soft-gray icon button used for month prev/next navigation.
class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isDark;

  const _NavButton({
    required this.icon,
    required this.onPressed,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark
          ? Colors.white.withValues(alpha: 0.08)
          : AppColors.figmaLightGrayBg,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Icon(
            icon,
            size: 20,
            color: isDark ? Colors.white70 : AppColors.primaryNavy,
          ),
        ),
      ),
    );
  }
}
