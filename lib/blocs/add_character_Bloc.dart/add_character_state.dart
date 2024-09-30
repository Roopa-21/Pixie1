import 'package:equatable/equatable.dart';

class AddCharacterState extends Equatable {
  final int currentPage;
  final Map<String, String> selectedChips;

  const AddCharacterState(
      {required this.currentPage, required this.selectedChips});

  AddCharacterState copyWith({
    int? currentPage,
    Map<String, String>? selectedChips,
  }) {
    return AddCharacterState(
      currentPage: currentPage ?? this.currentPage,
      selectedChips: selectedChips ?? this.selectedChips,
    );
  }

  @override
  List<Object> get props => [currentPage, selectedChips];
}
