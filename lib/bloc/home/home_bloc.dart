import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:just_audio/just_audio.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final player = AudioPlayer();
  bool isPlaying = false;
  String currentTitle = 'Unknown Title';
  String currentInterpret = 'Unknown Interpret';

  HomeBloc() : super(HomeInitial()) {
    on<PlayButton>((event, emit) async {
      emit(HomeInProgressState());
      try {
        if (isPlaying) {
          await player.pause();
        } else {
          await player.setUrl(
              'https://audio-edge-cmc51.fra.h.radiomast.io/ref-128k-mp3-stereo');
          player.play();

          player.icyMetadataStream.listen((icyMetadata) {
            final titleWithInterpret =
                icyMetadata?.info?.title ?? 'Unknown Title';
            List<String> parts = titleWithInterpret.split(' - ');

            if (parts.length == 2) {
              currentTitle = parts[1].trim(); // Second part as title
              currentInterpret = parts[0].trim(); // First part as interpret
            } else {
              currentTitle = titleWithInterpret;
              currentInterpret = 'Unknown Interpret';
            }

            add(MetadataUpdateEvent(currentTitle, currentInterpret));
          });
        }
        isPlaying = !isPlaying;
        emit(HomeSuccessState(
            isPlaying: isPlaying,
            title: currentTitle,
            interpret: currentInterpret));
      } catch (error) {
        emit(HomeFailureState());
      }
    });

    on<MetadataUpdateEvent>((event, emit) {
      currentTitle = event.title;
      currentInterpret = event.interpret;
      emit(HomeSuccessState(
          isPlaying: isPlaying,
          title: event.title,
          interpret: event.interpret));
    });
  }
}
