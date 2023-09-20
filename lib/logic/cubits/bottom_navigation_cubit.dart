import 'package:flutter_bloc/flutter_bloc.dart';

part'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationState(pageIndex:0)); // Initial selected index is 0

  void updateIndex(int newIndex) => emit(BottomNavigationState(pageIndex: newIndex));
}