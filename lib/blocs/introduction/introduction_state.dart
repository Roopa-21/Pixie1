abstract class TextState {}

class TextInitial extends TextState {}

class TextUpdated extends TextState {
  final String name;
  TextUpdated({required this.name});
}
