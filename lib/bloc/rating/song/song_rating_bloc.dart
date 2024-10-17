import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:radio_app/bloc/rating/rating_result.dart';
import 'package:radio_app/domain_models/five_star_rating.dart';
import 'package:radio_app/domain_models/song.dart';
import 'package:radio_app/domain_models/song_rating.dart';
import 'package:radio_app/repository/rating/song_rating_repository.dart';

part 'song_rating_event.dart';
part 'song_rating_state.dart';

class SongRatingBloc extends Bloc<SongRatingEvent, SongRatingState> {
  final SongRatingRepository _songRatingRepository;

  SongRatingBloc(this._songRatingRepository) : super(SongRatingInitial()) {
    on<SongRatingSubmitted>(_submitSongRating);
  }

  FutureOr<void> _submitSongRating(SongRatingSubmitted event, Emitter<SongRatingState> emit) {
    emit(SongRatingSubmissionInProgress());
    try {
      _songRatingRepository.sendSongRating(
          SongRating(
            song: Song(title: event.songTitle, album: "", interpret: event.songInterpret),
            rating: FiveStarRating(stars: event.ratingResult.rating),
            comment: event.ratingResult.comment
          )
      );
      emit(SongRatingSubmissionSuccessful());
    } on Exception catch (_, error) {
      emit(SongRatingSubmissionFailure("Error while trying to submit rating: ${error.toString()}"));
    }
  }
}
