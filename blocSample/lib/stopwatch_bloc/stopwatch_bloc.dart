import 'package:bloc/bloc.dart';
part 'stopwatch_event.dart';
part 'stopwatch_state.dart';

class StopWatchBloc extends Bloc<StopWatchEvent, StopWatchState> {
  StopWatchBloc() : super(CounterInitialState());

  @override
  Stream<StopWatchState> mapEventToState(StopWatchEvent event) async* {
    if (event is IncreasingCounter) {
      int counter = event.payload + 1;
      int h = counter ~/ 3600;
      int m = (counter - (h * 3600)) ~/ 60;
      int s = (counter - (h * 3600) - (m * 60)) % 60;
      yield UpdateState(state,
          counter: counter,
          hour: h,
          minute: m,
          second: s,
          running: true,
          started: true);
    } else if (event is ResetCounter) {
      yield UpdateState(state,
          counter: 0,
          hour: 0,
          minute: 0,
          second: 0,
          running: false,
          started: false);
    } else if (event is StopCounter) {
      yield UpdateState(state, running: false, started: true);
    }
  }
}
