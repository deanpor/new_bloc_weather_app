part of 'location_cubit.dart';

class LocationState {
  final String savedLocation;

  LocationState({required this.savedLocation});

  Map<String, dynamic> toMap(){
    return {
      'savedLocation' : savedLocation,
    };

  }

  factory LocationState.fromMap(Map<String, dynamic> map){
    return LocationState(
      savedLocation: map['savedLocation'],
    );

  }

  String toJson() => json.encode(toMap());

  factory LocationState.fromJson(String source) =>
      LocationState.fromMap(json.decode(source));
}
