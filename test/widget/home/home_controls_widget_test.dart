import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:radio_app/bloc/home/home_bloc.dart';
import 'package:radio_app/bloc/home/song_information.dart';
import 'package:radio_app/screens/home/home_controls_widget.dart';
import 'package:radio_app/screens/rating/moderator_rating_screen.dart';
import 'package:radio_app/screens/rating/song_rating_screen.dart';
import 'package:radio_app/screens/wish/song_wish_screen.dart';

class MockHomeBloc extends MockBloc<HomePlayerEvent, HomePlayerState> implements HomeBloc {}

void main() {
  late MockHomeBloc mockHomeBloc;

  setUp(() {
    mockHomeBloc = MockHomeBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<HomeBloc>(
        create: (context) => mockHomeBloc,
        child: const HomeControls(),
      ),
    );
  }

  testWidgets('displays play button when in stopped state', (WidgetTester tester) async {
    whenListen(
      mockHomeBloc,
      Stream.fromIterable([HomePlayerStoppedState()]),
      initialState: HomePlayerStoppedState(),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
  });

  testWidgets('displays pause button when in playing state', (WidgetTester tester) async {
    whenListen(
      mockHomeBloc,
      Stream.fromIterable([HomePlayerPlayingState(songInformation: SongInformation(title: 'Test Song', interpret: 'Test Artist'))]),
      initialState: HomePlayerPlayingState(songInformation: SongInformation(title: 'Test Song', interpret: 'Test Artist')),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byIcon(Icons.pause), findsOneWidget);
  });

  testWidgets('navigates to SongRatingScreen when song rating button is pressed', (WidgetTester tester) async {
    whenListen(
      mockHomeBloc,
      Stream.fromIterable([HomePlayerPlayingState(songInformation: SongInformation(title: 'Test Song', interpret: 'Test Artist'))]),
      initialState: HomePlayerPlayingState(songInformation: SongInformation(title: 'Test Song', interpret: 'Test Artist')),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byTooltip('Rate current song'));
    await tester.pumpAndSettle();

    expect(find.byType(SongRatingScreen), findsOneWidget);
  });

  testWidgets('navigates to SongWishScreen when wish button is pressed', (WidgetTester tester) async {
    whenListen(
      mockHomeBloc,
      Stream.fromIterable([HomePlayerPlayingState(songInformation: SongInformation(title: 'Test Song', interpret: 'Test Artist'))]),
      initialState: HomePlayerPlayingState(songInformation: SongInformation(title: 'Test Song', interpret: 'Test Artist')),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byTooltip('Wish song'));
    await tester.pumpAndSettle();

    expect(find.byType(SongWishScreen), findsOneWidget);
  });

  testWidgets('navigates to ModeratorRatingScreen when rate moderator button is pressed', (WidgetTester tester) async {
    whenListen(
      mockHomeBloc,
      Stream.fromIterable([HomePlayerPlayingState(songInformation: SongInformation(title: 'Test Song', interpret: 'Test Artist'))]),
      initialState: HomePlayerPlayingState(songInformation: SongInformation(title: 'Test Song', interpret: 'Test Artist')),
    );

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byTooltip('Rate current moderator'));
    await tester.pumpAndSettle();

    expect(find.byType(ModeratorRatingScreen), findsOneWidget);
  });
}