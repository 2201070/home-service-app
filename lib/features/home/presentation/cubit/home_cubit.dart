import 'package:flutter_bloc/flutter_bloc.dart';

class HomeState {
  final int currentTabIndex;

  const HomeState({this.currentTabIndex = 0});

  HomeState copyWith({int? currentTabIndex}) {
    return HomeState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void selectTab(int index) {
    emit(state.copyWith(currentTabIndex: index));
  }
}
