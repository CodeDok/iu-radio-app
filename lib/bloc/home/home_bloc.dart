import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool isPlaying = false;

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is PlayButton) {
        emit(HomeInProgressState());
        try {
          isPlaying = !isPlaying;
          emit(HomeSuccessState(isPlaying));
        } catch (error) {
          emit(HomeFailureState());
        }
      }
    });
  }
}
