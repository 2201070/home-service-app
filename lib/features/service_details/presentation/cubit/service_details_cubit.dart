import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceDetailsState {
  final bool isDescriptionExpanded;

  const ServiceDetailsState({this.isDescriptionExpanded = false});

  ServiceDetailsState copyWith({bool? isDescriptionExpanded}) {
    return ServiceDetailsState(
      isDescriptionExpanded: isDescriptionExpanded ?? this.isDescriptionExpanded,
    );
  }
}

class ServiceDetailsCubit extends Cubit<ServiceDetailsState> {
  ServiceDetailsCubit() : super(const ServiceDetailsState());

  void toggleDescription() {
    emit(state.copyWith(
      isDescriptionExpanded: !state.isDescriptionExpanded,
    ));
  }
}
