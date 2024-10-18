import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:radio_app/bloc/wish/song_wish_bloc.dart';
import 'package:radio_app/repository/wish/song_wish_repository.dart';
import 'package:radio_app/screens/wish/song_wish_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockSongWishRepository extends Mock implements SongWishRepository {}

class MockSongWishBloc extends MockBloc<SongWishEvent, SongWishState> implements SongWishBloc {}

void main() {
  late MockSongWishRepository mockSongWishRepository;
  late MockSongWishBloc mockSongWishBloc;

  setUp(() {
    mockSongWishRepository = MockSongWishRepository();
    mockSongWishBloc = MockSongWishBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: RepositoryProvider<SongWishRepository>(
        create: (_) => mockSongWishRepository,
        child: BlocProvider<SongWishBloc>(
          create: (_) => mockSongWishBloc,
          child: const SongWishScreen(),
        ),
      ),
    );
  }

  testWidgets('renders initial form state', (WidgetTester tester) async {
    when(() => mockSongWishBloc.state).thenReturn(SongWishInitial());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('renders loading indicator when submission is in progress', (WidgetTester tester) async {
    when(() => mockSongWishBloc.state).thenReturn(SongWishInProgress());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders success dialog when submission is successful', (WidgetTester tester) async {
    when(() => mockSongWishBloc.state).thenReturn(SongWishSubmissionSuccessful());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Submitted wish successfully!'), findsOneWidget);
  });

  testWidgets('renders error dialog when submission fails', (WidgetTester tester) async {
    when(() => mockSongWishBloc.state).thenReturn(SongWishSubmissionFailure(errorMessage: 'Error occurred'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Error while trying to submit song wish'), findsOneWidget);
    expect(find.text('Error occurred'), findsOneWidget);
  });

  testWidgets('validates form and submits when FloatingActionButton is pressed', (WidgetTester tester) async {
    when(() => mockSongWishBloc.state).thenReturn(SongWishInitial());

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextFormField).first, 'Test Song');
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    verify(() => mockSongWishBloc.add(SongWishSubmitted(songTitle: 'Test Song', interpret: null))).called(1);
  });
}