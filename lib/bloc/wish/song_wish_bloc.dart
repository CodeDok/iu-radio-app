import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:radio_app/domain_models/song.dart';
import 'package:radio_app/repository/wish/song_wish_repository.dart';

part 'song_wish_event.dart';
part 'song_wish_state.dart';

class SongWishBloc extends Bloc<SongWishEvent, SongWishState> {
  final SongWishRepository _songWishRepository;


  SongWishBloc(this._songWishRepository) : super(SongWishInitial()) {
    on<SongWishSubmitted>(_submitSongWish);
  }

  FutureOr<void> _submitSongWish(SongWishSubmitted event, Emitter<SongWishState> emit) {
    emit(SongWishInProgress());
    try {
      _songWishRepository.sendSongWish(
          Song(title: event.songTitle, interpret: event.interpret ?? "")
      );
      emit(SongWishSubmissionSuccessful());
    } on Exception catch (_, error) {
      emit(SongWishSubmissionFailure(errorMessage: "Error while trying to submit rating: ${error.toString()}"));
    }
  }
}
