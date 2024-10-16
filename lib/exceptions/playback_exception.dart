
class PlaybackException implements Exception {
  String cause;
  PlaybackException(this.cause);
}