import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_event.dart';
import 'package:pixieapp/blocs/add_character_Bloc.dart/add_character_state.dart';

class AddCharacterBloc extends Bloc<AddCharacterEvent, AddCharacterState> {
  AddCharacterBloc()
      : super(const AddCharacterState(
          currentPage: 0,
          selectedChips: {},
        )) {
    on<PageChanged>(_onPageChanged);
    on<ChipSelected>(_onChipSelected);
  }

  void _onPageChanged(PageChanged event, Emitter<AddCharacterState> emit) {
    emit(state.copyWith(currentPage: event.pageIndex));
  }

  void _onChipSelected(ChipSelected event, Emitter<AddCharacterState> emit) {
    final updatedChips = Map<String, String>.from(state.selectedChips);
    updatedChips[event.chipCategory] = event.selectedChip;
    emit(state.copyWith(selectedChips: updatedChips));
  }
}
