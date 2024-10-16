import 'package:equatable/equatable.dart';

abstract class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object?> get props => [];
}

class AudioInitial extends AudioState {}

class AudioPlaying extends AudioState {
  final Duration currentPosition;
  final Duration totalDuration;

  const AudioPlaying(this.currentPosition, this.totalDuration);

  @override
  List<Object?> get props => [currentPosition, totalDuration];
}

class AudioPaused extends AudioState {
  final Duration currentPosition;
  final Duration totalDuration;

  const AudioPaused(this.currentPosition, this.totalDuration);

  @override
  List<Object?> get props => [currentPosition, totalDuration];
}

class AudioCompleted extends AudioState {}

class AudioReset extends AudioState {}
