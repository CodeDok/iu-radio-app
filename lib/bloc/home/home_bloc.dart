import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:radio_app/bloc/home/song_information.dart';
import 'package:radio_app/repository/radioplayer/radio_player_repository.dart';

part 'home_player_event.dart';
part 'home_player_state.dart';

class HomeBloc extends Bloc<HomePlayerEvent, HomePlayerState> {

  final RadioPlayerRepository _radioPlayerRepository;
  StreamSubscription<SongInformation?>? _currentMetadataStream;

  HomeBloc(this._radioPlayerRepository) : super(HomeInitial()) {
    on<HomePlayerStarted>(_startPlaying);
    on<HomePlayerStopped>(_stopPlaying);
    on<_HomePlayerMetadataUpdated>(_updateIcecastMetadata);
  }

  FutureOr<void> _updateIcecastMetadata(_HomePlayerMetadataUpdated event, emit) {
    emit(HomePlayerPlayingState(songInformation: event.songInformation));
  }

  FutureOr<void> _stopPlaying(event, emit) async {
    try {
      await _radioPlayerRepository.stopPlaying();
      _currentMetadataStream?.cancel();
      emit(HomePlayerStoppedState());
    } catch (error) {
      emit(HomePlayerFailureState("Could not stop playback"));
    }
  }


  Future<void> _startPlaying(HomePlayerStarted event, Emitter<HomePlayerState> emit) async {
    emit(HomePlayerInitializationState());
    try {
      SongInformation songInformationAtStart = await _radioPlayerRepository.startPlaying();
      _currentMetadataStream = _radioPlayerRepository.getSongInformationStream().listen((songInformation) {
        add(_HomePlayerMetadataUpdated(songInformation: songInformation));
      });
      emit(HomePlayerPlayingState(songInformation: songInformationAtStart));
    } catch (error) {
      emit(HomePlayerFailureState("Could not start streaming to player"));
    }
  }


  @override
  Future<void> close() {
    _radioPlayerRepository.cleanup();
    _currentMetadataStream?.cancel();
    return super.close();
  }
}
