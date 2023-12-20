import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class AppObserver extends BlocObserver {

  @override
  void onEvent(Bloc bloc, Object? event) {
    log('On Event: ${bloc.toString()} - ${event.toString()}');
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log('On Change: ${bloc.toString()} - ${change.currentState} - ${change.nextState}');
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('On Error: ${bloc.toString()} - ${error.toString()} - ${stackTrace.toString()}');
    super.onError(bloc, error, stackTrace);
  }
}
