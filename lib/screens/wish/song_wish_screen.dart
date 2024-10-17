import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_app/bloc/wish/song_wish_bloc.dart';
import 'package:radio_app/repository/wish/song_wish_repository.dart';
import 'package:radio_app/screens/app-scaffold.dart';
import 'package:radio_app/screens/widgets/error_alert_dialog.dart';
import 'package:radio_app/screens/widgets/success_alert_dialog.dart';

class SongWishScreen extends StatefulWidget {
  const SongWishScreen({super.key});

  @override
  State<SongWishScreen> createState() => _SongWishScreenState();
}

class _SongWishScreenState extends State<SongWishScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        headerTitle: "Wish a song",
        body: RepositoryProvider(
          create: (context) => SongWishRepository(),
          child: BlocProvider(
            create: (context) => SongWishBloc(context.read<SongWishRepository>()),
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: BlocBuilder<SongWishBloc, SongWishState>(
                  builder: (context, state) {
                    return switch (state) {
                      SongWishInitial() => _Form(formKey: _formKey),
                      SongWishInProgress() => CircularProgressIndicator(),
                      SongWishSubmissionSuccessful() => SuccessAlertDialog(title: "Submitted wish successfully!"),
                      SongWishSubmissionFailure() => ErrorAlertDialog(title: "Error while trying to submit song wish", errorMessage: state.errorMessage),
                    };
                  },
                ),
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({required GlobalKey<FormState> formKey}) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  String? _title, _interpret;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget._formKey,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  labelText: "Song Title"
              ),
              onSaved: (newValue) => _title = newValue!,
              validator: (value) {
                if (value == null || value.length < 2) {
                  return "Title must have more than 1 character!";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "(optional) Interpret"
              ),
              onSaved: (newValue) => _title = newValue!,
            ),
            SizedBox(height: 50),
            FloatingActionButton(
              heroTag: "Rate",
              onPressed: () {
                widget._formKey.currentState?.save();
                if (widget._formKey.currentState!.validate()) {
                  context.read<SongWishBloc>().add(SongWishSubmitted(songTitle: _title!, interpret: _interpret));
                }
              },
              child: const Icon(Icons.send),
            )
          ],
        ));
  }
}
