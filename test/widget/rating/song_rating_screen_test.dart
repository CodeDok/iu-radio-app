import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:radio_app/bloc/rating/song/song_rating_bloc.dart';
import 'package:radio_app/repository/rating/song_rating_repository.dart';
import 'package:radio_app/screens/rating/rating_form_widget.dart';
import 'package:radio_app/screens/rating/song_rating_screen.dart';
import 'package:radio_app/screens/widgets/error_alert_dialog.dart';
import 'package:radio_app/screens/widgets/success_alert_dialog.dart';

class MockSongRatingRepository extends Mock implements SongRatingRepository {}

class MockSongRatingBloc extends MockBloc<SongRatingEvent, SongRatingState> implements SongRatingBloc {}

void main() {
  late MockSongRatingRepository mockSongRatingRepository;
  late MockSongRatingBloc mockSongRatingBloc;

  setUp(() {
    mockSongRatingRepository = MockSongRatingRepository();
    mockSongRatingBloc = MockSongRatingBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: RepositoryProvider<SongRatingRepository>(
        create: (context) => mockSongRatingRepository,
        child: BlocProvider<SongRatingBloc>(
          create: (context) => mockSongRatingBloc,
          child: const SongRatingScreen(songTitle: 'Test Song', interpret: 'Test Interpret'),
        ),
      ),
    );
  }

  testWidgets('displays CircularProgressIndicator when submission is in progress', (WidgetTester tester) async {
    when(() => mockSongRatingBloc.state).thenReturn(SongRatingSubmissionInProgress());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('displays SuccessAlertDialog when submission is successful', (WidgetTester tester) async {
    when(() => mockSongRatingBloc.state).thenReturn(SongRatingSubmissionSuccessful());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(SuccessAlertDialog), findsOneWidget);
    expect(find.text('Submitted rating successfully!'), findsOneWidget);
  });

  testWidgets('displays ErrorAlertDialog when submission fails', (WidgetTester tester) async {
    when(() => mockSongRatingBloc.state).thenReturn(SongRatingSubmissionFailure('Error message'));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(ErrorAlertDialog), findsOneWidget);
    expect(find.text('Error while trying to submit rating!'), findsOneWidget);
    expect(find.text('Error message'), findsOneWidget);
  });

  testWidgets('displays RatingFormWidget when in initial state', (WidgetTester tester) async {
    when(() => mockSongRatingBloc.state).thenReturn(SongRatingInitial());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(RatingFormWidget), findsOneWidget);
  });
}