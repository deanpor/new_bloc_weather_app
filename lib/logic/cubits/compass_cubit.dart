import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';

part 'compass_state.dart';

class CompassCubit extends Cubit<CompassState> {

  CompassCubit() : super(CompassState(heading: 0)){
    startListening();
  }

  late final StreamSubscription<CompassEvent> compassSubscription;

  void startListening() {
    compassSubscription = FlutterCompass.events!.listen((CompassEvent event) {
      emit(CompassState(heading: event.heading ?? 0));
    });
  }

  void dispose(){
    compassSubscription.cancel();
    super.close();

  }

}