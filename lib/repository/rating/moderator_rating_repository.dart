
import 'package:radio_app/bloc/rating/moderator/moderator_rating_bloc.dart';
import 'package:radio_app/domain_models/moderator.dart';
import 'package:radio_app/domain_models/moderator_rating.dart';

class ModeratorRatingRepository {

  Future<Moderator> retrieveCurrentModerator() async {
    await Future.delayed(Duration(seconds: 2));

    return Moderator(
        firstName: "Dummy",
        lastName: "Dummy Lastname",
        image: Uri.parse("https://i1.wp.com/www.stugon.com/wp-content/uploads/2014/02/unsplash-free-stock-photo.jpg")
    );
  }

  Future<void> sendModeratorRating(ModeratorRating moderatorRating) async {
    // Do some http request stuff
    await Future.delayed(Duration(seconds: 2));
  }

}