abstract class TextEvent {}

class TextChanged extends TextEvent {
  final String name;
  TextChanged({required this.name});
}
