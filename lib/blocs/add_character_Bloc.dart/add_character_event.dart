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

// Event for language change
class LanguageChangeEvent extends AddCharacterEvent {
  final String language;

  const LanguageChangeEvent(this.language);

  @override
  List<Object?> get props => [language];
}
