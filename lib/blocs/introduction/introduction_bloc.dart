import 'package:bloc/bloc.dart';
import 'introduction_event.dart';
import 'introduction_state.dart';

class TextBloc extends Bloc<TextEvent, TextState> {
  TextBloc() : super(TextInitial()) {
    on<TextChanged>((event, emit) {
      emit(TextUpdated(name: event.name));
    });
  }
}
