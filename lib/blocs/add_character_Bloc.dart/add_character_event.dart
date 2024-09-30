import 'package:equatable/equatable.dart';

abstract class AddCharacterEvent extends Equatable {
  const AddCharacterEvent();

  @override
  List<Object?> get props => [];
}

class Pagechange extends AddCharacterEvent {
  final int currentpageindex;

  const Pagechange(this.currentpageindex);

  @override
  List<Object?> get props => [currentpageindex];
}
