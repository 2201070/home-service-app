import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingState {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final String address;
  final String notes;
  final double basePrice;
  final bool isConfirmed;

  BookingState({
    required this.selectedDate,
    required this.selectedTime,
    required this.address,
    required this.notes,
    required this.basePrice,
    this.isConfirmed = false,
  });

  BookingState copyWith({
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
    String? address,
    String? notes,
    double? basePrice,
    bool? isConfirmed,
  }) {
    return BookingState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      basePrice: basePrice ?? this.basePrice,
      isConfirmed: isConfirmed ?? this.isConfirmed,
    );
  }
}

class BookingCubit extends Cubit<BookingState> {
  BookingCubit({required double initialPrice})
      : super(BookingState(
          selectedDate: DateTime(2024, 8, 24),
          selectedTime: const TimeOfDay(hour: 11, minute: 0),
          address: '123 Maple Street, Austin\nTX 78701, United States',
          notes: '',
          basePrice: initialPrice,
          isConfirmed: false,
        ));

  void selectDate(DateTime date) {
    emit(state.copyWith(selectedDate: date));
  }

  void selectTime(TimeOfDay time) {
    emit(state.copyWith(selectedTime: time));
  }

  void updateAddress(String newAddress) {
    emit(state.copyWith(address: newAddress));
  }

  void updateNotes(String newNotes) {
    emit(state.copyWith(notes: newNotes));
  }

  void confirmBooking() {
    emit(state.copyWith(isConfirmed: true));
  }
}
