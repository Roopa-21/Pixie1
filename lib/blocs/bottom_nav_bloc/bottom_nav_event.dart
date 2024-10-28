
abstract class BottomNavEvent {}

class UpdateListenStateEvent extends BottomNavEvent {
  final bool isListening;

  UpdateListenStateEvent({required this.isListening});
}


