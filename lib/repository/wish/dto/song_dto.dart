import 'package:radio_app/domain_models/song.dart';

class SongDto {
  final String title;
  final String interpret;

  SongDto({required this.title, required this.interpret});

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "interpret": interpret
    };
  }

  factory SongDto.fromDomain(Song song) {
    return SongDto(title: song.title, interpret: song.interpret);
  }
}