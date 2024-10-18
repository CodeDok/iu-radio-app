import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_app/repository/radioplayer/radio_player_repository.dart';
import 'package:radio_app/bloc/home/song_information.dart';
import 'package:radio_app/exceptions/playback_exception.dart';
import 'package:mockito/annotations.dart';
import 'radio_player_repository_test.mocks.dart';

@GenerateMocks([AudioPlayer])
void main() {
  late MockAudioPlayer mockAudioPlayer;
  late RadioPlayerRepository radioPlayerRepository;

  setUp(() {
    mockAudioPlayer = MockAudioPlayer();
    radioPlayerRepository = RadioPlayerRepository(audioPlayer: mockAudioPlayer);
  });

  test('startPlaying should start playing and return song information', () async {
    final songInformation = SongInformation(title: 'Test Title', interpret: 'Test Interpret');
    when(mockAudioPlayer.play()).thenAnswer((_) async => {});
    when(mockAudioPlayer.icyMetadataStream).thenAnswer((_) => Stream.value(IcyMetadata(info: IcyInfo(title: 'Test Interpret - Test Title', url: ''), headers: null, )));

    final result = await radioPlayerRepository.startPlaying();

    expect(result.title, songInformation.title);
    expect(result.interpret, songInformation.interpret);
    verify(mockAudioPlayer.play()).called(1);
  });

  test('startPlaying should throw PlaybackException on error', () async {
    when(mockAudioPlayer.play()).thenThrow(Exception('Playback error'));

    expect(() => radioPlayerRepository.startPlaying(), throwsA(isA<PlaybackException>()));
  });

  test('stopPlaying should stop the audio player', () async {
    when(mockAudioPlayer.stop()).thenAnswer((_) async => {});

    await radioPlayerRepository.stopPlaying();

    verify(mockAudioPlayer.stop()).called(1);
  });

  test('cleanup should dispose the audio player', () {
    radioPlayerRepository.cleanup();

    verify(mockAudioPlayer.dispose()).called(1);
  });
}
