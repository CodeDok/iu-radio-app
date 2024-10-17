import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_app/bloc/rating/rating_result.dart';
import 'package:radio_app/bloc/rating/song/song_rating_bloc.dart';
import 'package:radio_app/repository/rating/song_rating_repository.dart';
import 'package:radio_app/screens/app-scaffold.dart';
import 'package:radio_app/screens/rating/rating_form_widget.dart';

class SongRatingScreen extends StatefulWidget {
  const SongRatingScreen({super.key, required this.songTitle});

  final String songTitle;

  @override
  State<SongRatingScreen> createState() => _SongRatingScreenState();
}

class _SongRatingScreenState extends State<SongRatingScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        headerTitle: "Rate Song",
        body: RepositoryProvider(
          create: (context) => SongRatingRepository(),
          child: BlocProvider(
            create: (context) => SongRatingBloc(context.read<SongRatingRepository>()),
            child: BlocBuilder<SongRatingBloc, SongRatingState>(
              builder: (context, state) {
                return switch (state) {
                  SongRatingSubmissionInProgress() => CircularProgressIndicator(),
                  SongRatingSubmissionSuccessful() => SuccessAlertDialog(),
                  SongRatingSubmissionFailure() => ErrorAlertDialog(errorMessage: state.errorMessage),
                  _ => Form(widget: widget)
                };
              },
            ),
          ),
        ));
  }
}

class SuccessAlertDialog extends StatelessWidget {
  const SuccessAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.star, color: Colors.yellow, size: 80),
      surfaceTintColor: Theme.of(context).colorScheme.secondary,
      title: const Text("Submitted rating successfully!"),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(Icons.bug_report, color: Colors.red),
      title: const Text("Error while trying to submit rating!"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(errorMessage),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}



class Form extends StatelessWidget {
  const Form({
    super.key,
    required this.widget,
  });

  final SongRatingScreen widget;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RatingFormWidget(
      value: widget.songTitle,
      maxCommentLength: 255,
      processResult: (RatingResult ratingResult) {
        context
            .read<SongRatingBloc>()
            .add(SongRatingSubmitted(songTitle: widget.songTitle, ratingResult: ratingResult));
      },
    ));
  }
}
