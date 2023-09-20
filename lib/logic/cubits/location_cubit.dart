import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> with HydratedMixin{
  LocationCubit() : super(LocationState(savedLocation : ''));

  // Method to update the saved location
  void updateLocation(String newLocation) {
    emit(LocationState(savedLocation: newLocation));
  }

  // Method to retrieve the saved location
  String getSavedLocation() {
    return state.savedLocation;
  }

  @override
  LocationState? fromJson(Map<String, dynamic> json) {
    return LocationState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(LocationState state) {
    return state.toMap();
  }

}
