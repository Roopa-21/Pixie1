abstract class ProfileEvent{}
class FetchChildName extends ProfileEvent {}

class UpdateChildName extends ProfileEvent {
  final String newName;

  UpdateChildName(this.newName);
}