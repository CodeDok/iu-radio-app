import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:radio_app/bloc/rating/rating_result.dart';
import 'package:radio_app/domain_models/five_star_rating.dart';
import 'package:radio_app/domain_models/moderator.dart';
import 'package:radio_app/domain_models/moderator_rating.dart';
import 'package:radio_app/repository/rating/moderator_rating_repository.dart';

part 'moderator_rating_event.dart';
part 'moderator_rating_state.dart';

class ModeratorRatingBloc extends Bloc<ModeratorRatingEvent, ModeratorRatingState> {

  final log = Logger('ModeratorRatingBloc');
  final ModeratorRatingRepository _moderatorRatingRepository;

  ModeratorRatingBloc(this._moderatorRatingRepository) : super(ModeratorRatingInitial()) {
    on<ModeratorRatingInformationLoaded>(_loadCurrentModeratorInformation);
    on<ModeratorRatingSubmitted>(_saveModeratorRating);
  }

  FutureOr<void> _loadCurrentModeratorInformation(
      ModeratorRatingInformationLoaded event, Emitter<ModeratorRatingState> emit) async {
    emit(ModeratorRatingLoadingModerator());
    try {
      Moderator moderator = await _moderatorRatingRepository.retrieveCurrentModerator();
      emit(ModeratorRatingLoadedModerator(
          moderatorId: moderator.id,
          moderatorFirstName: moderator.firstName,
          moderatorLastName: moderator.lastName,
          moderatorImageUrl: moderator.image.toString()));
    } on Exception catch (error, exception) {
      log.severe("Error while trying to load moderator information", error, exception);
      emit(ModeratorRatingLoadingError("Error while trying to load moderator information"));
    }
  }


  Future<void> _saveModeratorRating(ModeratorRatingSubmitted event, Emitter<ModeratorRatingState> emit) async {
    emit(ModeratorRatingSubmissionInProgress());
    try {
      await _moderatorRatingRepository.sendModeratorRating(
          ModeratorRating(
            moderator: Moderator(id: event.moderatorId, firstName: event.moderatorFirstName, lastName: event.moderatorLastName),
            rating: FiveStarRating(stars: event.ratingResult.rating),
            comment: event.ratingResult.comment
          )
      );
      emit(ModeratorRatingSubmissionSuccessful());
    } catch (exception) {
      log.severe("Error while trying to submit rating", exception.toString());
      emit(ModeratorRatingSubmissionFailure("Error while trying to submit rating"));
    }
  }
}
