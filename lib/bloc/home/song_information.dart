

class SongInformation {
  const SongInformation({
    required this.title,
    required this.interpret
  });

  final String title;
  final String interpret;

  SongInformation.unknown()
  : title = "Unknown Title",
    interpret = "Unknown Interpret";

  @override
  String toString() {
    return 'SongInformation{title: $title, interpret: $interpret}';
  }
}