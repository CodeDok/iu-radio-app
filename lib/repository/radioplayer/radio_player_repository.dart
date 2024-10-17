

import 'dart:async';

import 'package:just_audio/just_audio.dart';
import 'package:radio_app/bloc/home/song_information.dart';
import 'package:radio_app/exceptions/playback_exception.dart';


class RadioPlayerRepository {

  late AudioPlayer _audioPlayer;

  RadioPlayerRepository.fromUrl(String url) {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(url);
  }

  Future<SongInformation> startPlaying() async {
    try {
      _audioPlayer.play();
      return await getSongInformationStream().first;
    } catch (error) {
      throw PlaybackException("Could not start because ${error.toString()}");
    }
  }

  Stream<SongInformation> getSongInformationStream() {
    return _audioPlayer.icyMetadataStream
        .where((data) => data != null && data.info != null)
        .map<SongInformation>((icyMetadata) => _retrieveIcyMetadataValues(icyMetadata!));
  }

  Future<void> stopPlaying() async {
      await _audioPlayer.stop();
  }


  SongInformation _retrieveIcyMetadataValues(IcyMetadata? icyMetadata) {
    if (icyMetadata != null) {
      final titleWithInterpret = icyMetadata.info?.title ?? "";

      List<String> parts = titleWithInterpret.split(' - ');
      if (parts.length == 2) {
        var currentTitle = parts[1].trim(); // Second part as title
        var currentInterpret = parts[0].trim(); // First part as interpret
        return SongInformation(title: currentTitle, interpret: currentInterpret);
      }
    }
    return SongInformation.unknown();
  }

  void cleanup() {
    _audioPlayer.dispose();
  }

}