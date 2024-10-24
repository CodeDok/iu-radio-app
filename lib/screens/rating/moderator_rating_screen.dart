import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_app/bloc/rating/moderator/moderator_rating_bloc.dart';
import 'package:radio_app/bloc/rating/rating_result.dart';
import 'package:radio_app/repository/rating/moderator_rating_repository.dart';
import 'package:radio_app/screens/app-scaffold.dart';
import 'package:radio_app/screens/widgets/error_alert_dialog.dart';
import 'package:radio_app/screens/rating/rating_form_widget.dart';
import 'package:radio_app/screens/widgets/success_alert_dialog.dart';
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
                      ModeratorRatingLoadedModerator() => _Form(
                        moderatorId: state.moderatorId,
                          moderatorFirstName: state.moderatorFirstName,
                          moderatorLastName: state.moderatorLastName,
                          moderatorImageUrl: state.moderatorImageUrl),
                      ModeratorRatingLoadingError() => ErrorAlertDialog(
                          title: "Error while trying to load moderator information", errorMessage: state.errorMessage),
                      ModeratorRatingSubmissionSuccessful() => SuccessAlertDialog(title: "Submitted rating successfully!"),
                      ModeratorRatingSubmissionFailure() =>
                        ErrorAlertDialog(title: "Error while trying to submit rating!", errorMessage: state.errorMessage),
                    };
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class _Form extends StatelessWidget {
  const _Form({
    required this.moderatorId,
    required this.moderatorFirstName,
    required this.moderatorLastName,
    this.moderatorImageUrl,
  });

  final int moderatorId;
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
                : _NetworkImage(moderatorImageUrl: moderatorImageUrl!)),
        RatingFormWidget(
          value: "$moderatorFirstName $moderatorLastName",
          maxCommentLength: 255,
          processResult: (RatingResult ratingResult) {
            context.read<ModeratorRatingBloc>().add(ModeratorRatingSubmitted(
                moderatorId: moderatorId,
                moderatorFirstName: moderatorFirstName,
                moderatorLastName: moderatorLastName,
                ratingResult: ratingResult));
          },
        ),
      ],
    ));
  }
}

class _NetworkImage extends StatelessWidget {
  const _NetworkImage({
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
