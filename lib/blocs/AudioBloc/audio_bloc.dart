import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'audio_event.dart';
import 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  final AudioPlayer _audioPlayer;

  AudioBloc(this._audioPlayer) : super(AudioInitial()) {
    // Listeners for audio state changes
    _audioPlayer.positionStream.listen((position) {
      if (_audioPlayer.duration != null) {
        add(UpdatePositionEvent(position));
      }
    });

    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        add(AudioCompletedEvent());
      }
    });

    on<PlayAudioEvent>(_onPlayAudio);
    on<PauseAudioEvent>(_onPauseAudio);
    on<SeekAudioEvent>(_onSeekAudio);
    on<UpdatePositionEvent>(_onUpdatePosition);
    on<AudioCompletedEvent>(_onAudioCompleted);
    on<ResetAudioEvent>(_onResetAudio);
  }

  Future<void> _onPlayAudio(
      PlayAudioEvent event, Emitter<AudioState> emit) async {
    await _audioPlayer.play();
    emit(AudioPlaying(
        _audioPlayer.position, _audioPlayer.duration ?? Duration.zero));
  }

  Future<void> _onPauseAudio(
      PauseAudioEvent event, Emitter<AudioState> emit) async {
    await _audioPlayer.pause();
    emit(AudioPaused(
        _audioPlayer.position, _audioPlayer.duration ?? Duration.zero));
  }

  Future<void> _onSeekAudio(
      SeekAudioEvent event, Emitter<AudioState> emit) async {
    await _audioPlayer.seek(event.position);
    emit(AudioPlaying(event.position, _audioPlayer.duration ?? Duration.zero));
  }

  void _onUpdatePosition(UpdatePositionEvent event, Emitter<AudioState> emit) {
    if (state is AudioPlaying || state is AudioPaused) {
      emit(
          AudioPlaying(event.position, _audioPlayer.duration ?? Duration.zero));
    }
  }

  void _onAudioCompleted(AudioCompletedEvent event, Emitter<AudioState> emit) {
    emit(AudioPaused(Duration.zero, _audioPlayer.duration ?? Duration.zero));
    add(ResetAudioEvent()); // Trigger reset event when audio completes
  }

  void _onResetAudio(ResetAudioEvent event, Emitter<AudioState> emit) {
    emit(AudioReset()); // Reset to the initial state
    _audioPlayer.seek(Duration.zero); // Reset audio position
  }
}
