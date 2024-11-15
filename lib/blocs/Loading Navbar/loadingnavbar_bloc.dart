import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/Loading%20Navbar/loadingnavbar_event.dart';
import 'package:pixieapp/blocs/Loading%20Navbar/loadingnavbar_state.dart';

class LoadingNavbarBloc extends Bloc<LoadingNavbarEvent, LoadingNavbarState> {
  LoadingNavbarBloc() : super(LoadingStateOne()) {
    on<StartLoadingNavbarEvent>(_onStartLoadingNavbarEvent);
  }

  Future<void> _onStartLoadingNavbarEvent(
      StartLoadingNavbarEvent event, Emitter<LoadingNavbarState> emit) async {
    try {
      // Reset to LoadingStateOne immediately when the event is triggered
      emit(LoadingStateOne());

      // Emit LoadingStateTwo after 10 seconds
      await Future.delayed(const Duration(seconds: 10));
      if (!emit.isDone) emit(LoadingStateTwo());

      // Emit LoadingStateThree after another 10 seconds
      await Future.delayed(const Duration(seconds: 10));
      if (!emit.isDone) emit(LoadingStateThree());
    } catch (error) {
      // Handle any unexpected errors gracefully
      print('Error in LoadingNavbarBloc: $error');
    }
  }
}
