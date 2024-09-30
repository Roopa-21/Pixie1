import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_state.dart';

class AddCharacterBloc extends Bloc<AddCharacterEvent, AddCharacterState> {
  AddCharacterBloc() : super(const AddCharacterState(currentpageindex: 0)) {
    on<Pagechange>((event, emit) {
      emit(AddCharacterState(currentpageindex: event.currentpageindex));
    });
  }
}
