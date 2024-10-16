import 'package:equatable/equatable.dart';

abstract class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object?> get props => [];
}

class PlayAudioEvent extends AudioEvent {}

class PauseAudioEvent extends AudioEvent {}

class SeekAudioEvent extends AudioEvent {
  final Duration position;

  const SeekAudioEvent(this.position);

  @override
  List<Object?> get props => [position];
}

class UpdatePositionEvent extends AudioEvent {
  final Duration position;

  const UpdatePositionEvent(this.position);

  @override
  List<Object?> get props => [position];
}

class AudioCompletedEvent extends AudioEvent {}

class ResetAudioEvent extends AudioEvent {}
