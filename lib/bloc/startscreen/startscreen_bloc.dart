import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'startscreen_event.dart';
part 'startscreen_state.dart';

class StartscreenBloc extends Bloc<StartscreenEvent, StartscreenState> {
  StartscreenBloc() : super(StartscreenInitial()) {
    on<StartscreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
