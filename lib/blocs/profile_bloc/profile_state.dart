abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String childName;

  ProfileLoaded(this.childName);
}

class ProfileError extends ProfileState {
  final String error;

  ProfileError(this.error);
}
