import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_app/bloc/rating/rating_result.dart';
import 'package:radio_app/bloc/rating/song/song_rating_bloc.dart';
import 'package:radio_app/repository/rating/song_rating_repository.dart';
import 'package:radio_app/screens/app-scaffold.dart';
import 'package:radio_app/screens/rating/rating_error_alert_dialog.dart';
import 'package:radio_app/screens/rating/rating_form_widget.dart';
import 'package:radio_app/screens/rating/rating_success_alert_dialog.dart';

class SongRatingScreen extends StatefulWidget {
  const SongRatingScreen({super.key, required this.songTitle, required this.interpret});

  final String songTitle;
  final String interpret;

  @override
  State<SongRatingScreen> createState() => _SongRatingScreenState();
}

class _SongRatingScreenState extends State<SongRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        headerTitle: "Rate the song:",
        body: RepositoryProvider(
          create: (context) => SongRatingRepository(),
          child: BlocProvider(
            create: (context) => SongRatingBloc(context.read<SongRatingRepository>()),
            child: Center(
              child: BlocBuilder<SongRatingBloc, SongRatingState>(
                builder: (context, state) {
                  return switch (state) {
                    SongRatingSubmissionInProgress() => CircularProgressIndicator(),
                    SongRatingSubmissionSuccessful() => SuccessAlertDialog(),
                    SongRatingSubmissionFailure() => ErrorAlertDialog(
                        heading: "Error while trying to submit rating!", errorMessage: state.errorMessage),
                    _ => _Form(widget: widget)
                  };
                },
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatelessWidget {
  const _Form({
    super.key,
    required this.widget,
  });

  final SongRatingScreen widget;

  @override
  Widget build(BuildContext context) {
    return RatingFormWidget(
      value: widget.songTitle,
      maxCommentLength: 255,
      processResult: (RatingResult ratingResult) {
        context
            .read<SongRatingBloc>()
            .add(SongRatingSubmitted(songTitle: widget.songTitle, songInterpret: widget.interpret, ratingResult: ratingResult));
      },
    );
  }
}
