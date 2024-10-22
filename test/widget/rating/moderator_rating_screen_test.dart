import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:radio_app/bloc/rating/moderator/moderator_rating_bloc.dart';
import 'package:radio_app/repository/rating/moderator_rating_repository.dart';
import 'package:radio_app/screens/rating/moderator_rating_screen.dart';

class MockModeratorRatingRepository extends Mock implements ModeratorRatingRepository {}

class MockModeratorRatingBloc extends MockBloc<ModeratorRatingEvent, ModeratorRatingState> implements ModeratorRatingBloc {}

void main() {
  late MockModeratorRatingRepository mockModeratorRatingRepository;
  late MockModeratorRatingBloc mockModeratorRatingBloc;

  setUp(() {
    mockModeratorRatingRepository = MockModeratorRatingRepository();
    mockModeratorRatingBloc = MockModeratorRatingBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: RepositoryProvider<ModeratorRatingRepository>(
        create: (context) => mockModeratorRatingRepository,
        child: BlocProvider<ModeratorRatingBloc>(
          create: (context) => mockModeratorRatingBloc,
          child: const ModeratorRatingScreen(),
        ),
      ),
    );
  }

  testWidgets('should display CircularProgressIndicator when state is loading', (WidgetTester tester) async {
    when(() => mockModeratorRatingBloc.state).thenReturn(ModeratorRatingLoadingModerator());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should display ErrorAlertDialog when state is loading error', (WidgetTester tester) async {
    when(() => mockModeratorRatingBloc.state).thenReturn(ModeratorRatingLoadingError('Error'));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Error while trying to load moderator information'), findsOneWidget);
    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('should display SuccessAlertDialog when state is submission successful', (WidgetTester tester) async {
    when(() => mockModeratorRatingBloc.state).thenReturn(ModeratorRatingSubmissionSuccessful());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Submitted rating successfully!'), findsOneWidget);
  });

  testWidgets('should display ErrorAlertDialog when state is submission failure', (WidgetTester tester) async {
    when(() => mockModeratorRatingBloc.state).thenReturn(ModeratorRatingSubmissionFailure('Submission Error'));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('Error while trying to submit rating!'), findsOneWidget);
    expect(find.text('Submission Error'), findsOneWidget);
  });

  testWidgets('should display _Form when state is loaded moderator', (WidgetTester tester) async {
    when(() => mockModeratorRatingBloc.state).thenReturn(ModeratorRatingLoadedModerator(
      moderatorId: 1,
      moderatorFirstName: 'John',
      moderatorLastName: 'Doe',
      moderatorImageUrl: 'http://example.com/image.jpg',
    ));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump();

    expect(find.text('John Doe'), findsOneWidget);
  });
}