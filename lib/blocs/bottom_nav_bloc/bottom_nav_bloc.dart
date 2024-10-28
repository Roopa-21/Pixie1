import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/bottom_nav_bloc/bottom_nav_event.dart';
import 'package:pixieapp/blocs/bottom_nav_bloc/bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  bool isListening = false;

  BottomNavBloc() : super(BottomNavBlocInitial()) {
    on<UpdateListenStateEvent>((event, emit) {
      isListening = event.isListening;
      emit(ListenStateUpdated(isListening: isListening));
    });
  }
}