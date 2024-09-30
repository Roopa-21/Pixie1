import 'package:equatable/equatable.dart';

abstract class AddCharacterEvent extends Equatable {
  const AddCharacterEvent();

  @override
  List<Object?> get props => [];
}

class PageChanged extends AddCharacterEvent {
  final int pageIndex;

  const PageChanged(this.pageIndex);

  @override
  List<Object?> get props => [pageIndex];
}

class ChipSelected extends AddCharacterEvent {
  final String chipCategory;
  final String selectedChip;

  const ChipSelected(this.chipCategory, this.selectedChip);

  @override
  List<Object?> get props => [chipCategory, selectedChip];
}
