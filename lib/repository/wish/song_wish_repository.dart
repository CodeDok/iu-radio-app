import 'package:radio_app/domain_models/song.dart';


class SongWishRepository {

  Future<void> sendSongWish(Song song) async {
    // Do some http request stuff
    await Future.delayed(Duration(seconds: 2));
  }
}
