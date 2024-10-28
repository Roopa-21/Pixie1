abstract class BottomNavState {}

class BottomNavBlocInitial extends BottomNavState {
  

  
}
class ListenStateUpdated extends BottomNavState {
  final bool isListening;

  ListenStateUpdated({required this.isListening});
}