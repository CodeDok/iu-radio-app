import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_app/bloc/rating/moderator/moderator_rating_bloc.dart';
import 'package:radio_app/bloc/rating/rating_result.dart';
import 'package:radio_app/bloc/rating/song/song_rating_bloc.dart';
import 'package:radio_app/repository/rating/moderator_rating_repository.dart';
import 'package:radio_app/repository/rating/song_rating_repository.dart';
import 'package:radio_app/screens/app-scaffold.dart';
import 'package:radio_app/screens/rating/rating_error_alert_dialog.dart';
import 'package:radio_app/screens/rating/rating_form_widget.dart';
import 'package:radio_app/screens/rating/rating_success_alert_dialog.dart';
import 'package:radio_app/screens/widgets/rounded_square_image.dart';

class ModeratorRatingScreen extends StatefulWidget {
  const ModeratorRatingScreen({super.key});

  @override
  State<ModeratorRatingScreen> createState() => _ModeratorRatingScreenState();
}

class _ModeratorRatingScreenState extends State<ModeratorRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        headerTitle: "Rate your moderator:",
        body: RepositoryProvider(
          create: (context) => ModeratorRatingRepository(),
          child: BlocProvider(
            create: (context) =>
                ModeratorRatingBloc(context.read<ModeratorRatingRepository>())..add(ModeratorRatingInformationLoaded()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<ModeratorRatingBloc, ModeratorRatingState>(
                  builder: (context, state) {
                    return switch (state) {
                      ModeratorRatingSubmissionInProgress() ||
                      ModeratorRatingLoadingModerator() ||
                      ModeratorRatingInitial() => Center(child: CircularProgressIndicator()),
                      ModeratorRatingLoadedModerator() => Form(
                          moderatorFirstName: state.moderatorFirstName,
                          moderatorLastName: state.moderatorLastName,
                          moderatorImageUrl: state.moderatorImageUrl),
                      ModeratorRatingLoadingError() => ErrorAlertDialog(
                          heading: "Error while trying to load moderator information", errorMessage: state.errorMessage),
                      ModeratorRatingSubmissionSuccessful() => SuccessAlertDialog(),
                      ModeratorRatingSubmissionFailure() =>
                        ErrorAlertDialog(heading: "Error while trying to submit rating!", errorMessage: state.errorMessage),
                    };
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class Form extends StatelessWidget {
  const Form({
    super.key,
    required this.moderatorFirstName,
    required this.moderatorLastName,
    this.moderatorImageUrl,
  });

  final String moderatorFirstName;
  final String moderatorLastName;
  final String? moderatorImageUrl;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        RoundedSquareContainer(
            imageWidget: moderatorImageUrl!.isEmpty
                ? Image.asset("assets/images/iu-radio-app-logo.png")
                : NetworkImage(moderatorImageUrl: moderatorImageUrl!)),
        RatingFormWidget(
          value: "$moderatorFirstName $moderatorLastName",
          maxCommentLength: 255,
          processResult: (RatingResult ratingResult) {
            context.read<ModeratorRatingBloc>().add(ModeratorRatingSubmitted(
                moderatorFirstName: moderatorFirstName,
                moderatorLastName: moderatorLastName,
                ratingResult: ratingResult));
          },
        ),
      ],
    ));
  }
}

class NetworkImage extends StatelessWidget {
  const NetworkImage({
    super.key,
    required this.moderatorImageUrl,
  });

  final String moderatorImageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(moderatorImageUrl, fit: BoxFit.cover, loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
